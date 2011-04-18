#ifdef LISP_FEATURE_SB_THREAD
#include <architecture/i386/table.h>
#include <i386/user_ldt.h>
#include <mach/mach_init.h>
#endif

#include "thread.h"
#include "validate.h"
#include "runtime.h"
#include "interrupt.h"
#include "x86-darwin-os.h"
#include "genesis/fdefn.h"

#include <mach/mach.h>
#include <mach/mach_error.h>
#include <mach/mach_types.h>
#include <mach/sync_policy.h>
#include <mach/vm_region.h>
#include <mach/machine/thread_state.h>
#include <mach/machine/thread_status.h>
#include <sys/_types.h>
#include <sys/ucontext.h>
#include <pthread.h>
#include <assert.h>
#include <stdlib.h>
#include <stdio.h>

#ifdef LISP_FEATURE_SB_THREAD

pthread_mutex_t modify_ldt_lock = PTHREAD_MUTEX_INITIALIZER;

void set_data_desc_size(data_desc_t* desc, unsigned long size)
{
    desc->limit00 = (size - 1) & 0xffff;
    desc->limit16 = ((size - 1) >> 16) &0xf;
}

void set_data_desc_addr(data_desc_t* desc, void* addr)
{
    desc->base00 = (unsigned int)addr & 0xffff;
    desc->base16 = ((unsigned int)addr & 0xff0000) >> 16;
    desc->base24 = ((unsigned int)addr & 0xff000000) >> 24;
}

#endif

#ifdef LISP_FEATURE_MACH_EXCEPTION_HANDLER
kern_return_t mach_thread_init(mach_port_t thread_exception_port);
#endif

int arch_os_thread_init(struct thread *thread) {
#ifdef LISP_FEATURE_SB_THREAD
    int n;
    sel_t sel;

    data_desc_t ldt_entry = { 0, 0, 0, DESC_DATA_WRITE,
                              3, 1, 0, DESC_DATA_32B, DESC_GRAN_BYTE, 0 };

    set_data_desc_addr(&ldt_entry, thread);
    set_data_desc_size(&ldt_entry, dynamic_values_bytes);

    thread_mutex_lock(&modify_ldt_lock);
    n = i386_set_ldt(LDT_AUTO_ALLOC, (union ldt_entry*) &ldt_entry, 1);

    if (n < 0) {
        perror("i386_set_ldt");
        lose("unexpected i386_set_ldt(..) failure\n");
    }
    thread_mutex_unlock(&modify_ldt_lock);

    FSHOW_SIGNAL((stderr, "/ TLS: Allocated LDT %x\n", n));
    sel.index = n;
    sel.rpl = USER_PRIV;
    sel.ti = SEL_LDT;

    __asm__ __volatile__ ("mov %0, %%fs" : : "r"(sel));

    thread->tls_cookie=n;
    pthread_setspecific(specials,thread);
#endif
#ifdef LISP_FEATURE_MACH_EXCEPTION_HANDLER
    mach_thread_init(THREAD_STRUCT_TO_EXCEPTION_PORT(thread));
#endif

#ifdef LISP_FEATURE_C_STACK_IS_CONTROL_STACK
    stack_t sigstack;

    /* Signal handlers are run on the control stack, so if it is exhausted
     * we had better use an alternate stack for whatever signal tells us
     * we've exhausted it */
    sigstack.ss_sp=((void *) thread)+dynamic_values_bytes;
    sigstack.ss_flags=0;
    sigstack.ss_size = 32*SIGSTKSZ;
    sigaltstack(&sigstack,0);
#endif
    return 1;                  /* success */
}

int arch_os_thread_cleanup(struct thread *thread) {
#if defined(LISP_FEATURE_SB_THREAD)
    int n = thread->tls_cookie;

    /* Set the %%fs register back to 0 and free the ldt by setting it
     * to NULL.
     */
    FSHOW_SIGNAL((stderr, "/ TLS: Freeing LDT %x\n", n));

    __asm__ __volatile__ ("mov %0, %%fs" : : "r"(0));
    thread_mutex_lock(&modify_ldt_lock);
    i386_set_ldt(n, NULL, 1);
    thread_mutex_unlock(&modify_ldt_lock);
#endif
    return 1;                  /* success */
}

#ifdef LISP_FEATURE_MACH_EXCEPTION_HANDLER

void sigill_handler(int signal, siginfo_t *siginfo, os_context_t *context);
void sigtrap_handler(int signal, siginfo_t *siginfo, os_context_t *context);
void memory_fault_handler(int signal, siginfo_t *siginfo,
                          os_context_t *context);

/* exc_server handles mach exception messages from the kernel and
 * calls catch exception raise. We use the system-provided
 * mach_msg_server, which, I assume, calls exc_server in a loop.
 *
 */
extern boolean_t exc_server();

/* This executes in the faulting thread as part of the signal
 * emulation.  It is passed a context with the uc_mcontext field
 * pointing to a valid block of memory. */
void build_fake_signal_context(os_context_t *context,
                               x86_thread_state32_t *thread_state,
                               x86_float_state32_t *float_state) {
    pthread_sigmask(0, NULL, &context->uc_sigmask);
    context->uc_mcontext->SS = *thread_state;
    context->uc_mcontext->FS = *float_state;
}

/* This executes in the faulting thread as part of the signal
 * emulation.  It is effectively the inverse operation from above. */
void update_thread_state_from_context(x86_thread_state32_t *thread_state,
                                      x86_float_state32_t *float_state,
                                      os_context_t *context) {
    *thread_state = context->uc_mcontext->SS;
    *float_state = context->uc_mcontext->FS;
    pthread_sigmask(SIG_SETMASK, &context->uc_sigmask, NULL);
}

/* Modify a context to push new data on its stack. */
void push_context(u32 data, x86_thread_state32_t *thread_state)
{
    u32 *stack_pointer;

    stack_pointer = (u32*) thread_state->ESP;
    *(--stack_pointer) = data;
    thread_state->ESP = (unsigned int) stack_pointer;
}

void align_context_stack(x86_thread_state32_t *thread_state)
{
    /* 16byte align the stack (provided that the stack is, as it
     * should be, 4byte aligned. */
    while (thread_state->ESP & 15) push_context(0, thread_state);
}

/* Stack allocation starts with a context that has a mod-4 ESP value
 * and needs to leave a context with a mod-16 ESP that will restore
 * the old ESP value and other register state when activated.  The
 * first part of this is the recovery trampoline, which loads ESP from
 * EBP, pops EBP, and returns. */
asm("_stack_allocation_recover: movl %ebp, %esp; popl %ebp; ret;");

void open_stack_allocation(x86_thread_state32_t *thread_state)
{
    void stack_allocation_recover(void);

    push_context(thread_state->EIP, thread_state);
    push_context(thread_state->EBP, thread_state);
    thread_state->EBP = thread_state->ESP;
    thread_state->EIP = (unsigned int) stack_allocation_recover;

    align_context_stack(thread_state);
}

/* Stack allocation of data starts with a context with a mod-16 ESP
 * value and reserves some space on it by manipulating the ESP
 * register. */
void *stack_allocate(x86_thread_state32_t *thread_state, size_t size)
{
    /* round up size to 16byte multiple */
    size = (size + 15) & -16;

    thread_state->ESP = ((u32)thread_state->ESP) - size;

    return (void *)thread_state->ESP;
}

/* Arranging to invoke a C function is tricky, as we have to assume
 * cdecl calling conventions (caller removes args) and x86/darwin
 * alignment requirements.  The simplest way to arrange this,
 * actually, is to open a new stack allocation.
 * WARNING!!! THIS DOES NOT PRESERVE REGISTERS! */
void call_c_function_in_context(x86_thread_state32_t *thread_state,
                                void *function,
                                int nargs,
                                ...)
{
    va_list ap;
    int i;
    u32 *stack_pointer;

    /* Set up to restore stack on exit. */
    open_stack_allocation(thread_state);

    /* Have to keep stack 16byte aligned on x86/darwin. */
    for (i = (3 & -nargs); i; i--) {
        push_context(0, thread_state);
    }

    thread_state->ESP = ((u32)thread_state->ESP) - nargs * 4;
    stack_pointer = (u32 *)thread_state->ESP;

    va_start(ap, nargs);
    for (i = 0; i < nargs; i++) {
        //push_context(va_arg(ap, u32), thread_state);
        stack_pointer[i] = va_arg(ap, u32);
    }
    va_end(ap);

    push_context(thread_state->EIP, thread_state);
    thread_state->EIP = (unsigned int) function;
}

void signal_emulation_wrapper(x86_thread_state32_t *thread_state,
                              x86_float_state32_t *float_state,
                              int signal,
                              siginfo_t *siginfo,
                              void (*handler)(int, siginfo_t *, void *))
{

    /* CLH: FIXME **NOTE: HACK ALERT!** Ideally, we would allocate
     * context and regs on the stack as local variables, but this
     * causes problems for the lisp debugger. When it walks the stack
     * for a back trace, it sees the 1) address of the local variable
     * on the stack and thinks that is a frame pointer to a lisp
     * frame, and, 2) the address of the sap that we alloc'ed in
     * dynamic space and thinks that is a return address, so it,
     * heuristicly (and wrongly), chooses that this should be
     * interpreted as a lisp frame instead of as a C frame.
     * We can work around this in this case by os_validating the
     * context (and regs just for symmetry).
     */

    os_context_t *context;
    mcontext_t *regs;

    context = (os_context_t*) os_validate(0, sizeof(os_context_t));
    regs = (mcontext_t*) os_validate(0, sizeof(mcontext_t));
    context->uc_mcontext = regs;

    /* when BSD signals are fired, they mask they signals in sa_mask
       which always seem to be the blockable_sigset, for us, so we
       need to:
       1) save the current sigmask
       2) block blockable signals
       3) call the signal handler
       4) restore the sigmask */

    build_fake_signal_context(context, thread_state, float_state);

    block_blockable_signals(0, 0);

    handler(signal, siginfo, context);

    update_thread_state_from_context(thread_state, float_state, context);

    os_invalidate((os_vm_address_t)context, sizeof(os_context_t));
    os_invalidate((os_vm_address_t)regs, sizeof(mcontext_t));

    /* Trap to restore the signal context. */
    asm volatile ("movl %0, %%eax; movl %1, %%ebx; .long 0xffff0b0f"
                  : : "r" (thread_state), "r" (float_state));
}

/* Convenience wrapper for the above */
void call_handler_on_thread(mach_port_t thread,
                            x86_thread_state32_t *thread_state,
                            int signal,
                            siginfo_t *siginfo,
                            void (*handler)(int, siginfo_t *, void *))
{
    x86_thread_state32_t new_state;
    x86_thread_state32_t *save_thread_state;
    x86_float_state32_t *save_float_state;
    mach_msg_type_number_t state_count;
    siginfo_t *save_siginfo;
    kern_return_t ret;
    /* Initialize the new state */
    new_state = *thread_state;
    open_stack_allocation(&new_state);
    stack_allocate(&new_state, 256);
    /* Save old state */
    save_thread_state = (x86_thread_state32_t *)stack_allocate(&new_state, sizeof(*save_thread_state));
    *save_thread_state = *thread_state;
    /* Save float state */
    save_float_state = (x86_float_state32_t *)stack_allocate(&new_state, sizeof(*save_float_state));
    state_count = x86_FLOAT_STATE32_COUNT;
    if ((ret = thread_get_state(thread,
                                x86_FLOAT_STATE32,
                                (thread_state_t)save_float_state,
                                &state_count)) != KERN_SUCCESS)
        lose("thread_get_state (x86_THREAD_STATE32) failed %d\n", ret);
    /* Set up siginfo */
    save_siginfo = stack_allocate(&new_state, sizeof(*siginfo));
    if (siginfo == NULL)
        save_siginfo = siginfo;
    else
        *save_siginfo = *siginfo;
    /* Prepare to call */
    call_c_function_in_context(&new_state,
                               signal_emulation_wrapper,
                               5,
                               save_thread_state,
                               save_float_state,
                               signal,
                               save_siginfo,
                               handler);
    /* Update the thread state */
    state_count = x86_THREAD_STATE32_COUNT;
    if ((ret = thread_set_state(thread,
                                x86_THREAD_STATE32,
                                (thread_state_t)&new_state,
                                state_count)) != KERN_SUCCESS)
        lose("thread_set_state (x86_FLOAT_STATE32) failed %d\n", ret);

}

#if defined DUMP_CONTEXT
void dump_context(x86_thread_state32_t *thread_state)
{
    int i;
    u32 *stack_pointer;

    printf("eax: %08lx  ecx: %08lx  edx: %08lx  ebx: %08lx\n",
           thread_state->EAX, thread_state->ECX, thread_state->EDX, thread_state->EAX);
    printf("esp: %08lx  ebp: %08lx  esi: %08lx  edi: %08lx\n",
           thread_state->ESP, thread_state->EBP, thread_state->ESI, thread_state->EDI);
    printf("eip: %08lx  eflags: %08lx\n",
           thread_state->EIP, thread_state->EFLAGS);
    printf("cs: %04hx  ds: %04hx  es: %04hx  "
           "ss: %04hx  fs: %04hx  gs: %04hx\n",
           thread_state->CS,
           thread_state->DS,
           thread_state->ES,
           thread_state->SS,
           thread_state->FS,
           thread_state->GS);

    stack_pointer = (u32 *)thread_state->ESP;
    for (i = 0; i < 48; i+=4) {
        printf("%08x:  %08x %08x %08x %08x\n",
               thread_state->ESP + (i * 4),
               stack_pointer[i],
               stack_pointer[i+1],
               stack_pointer[i+2],
               stack_pointer[i+3]);
    }
}
#endif

void
control_stack_exhausted_handler(int signal, siginfo_t *siginfo,
                                os_context_t *context) {

    unblock_signals_in_context_and_maybe_warn(context);
    arrange_return_to_lisp_function
        (context, StaticSymbolFunction(CONTROL_STACK_EXHAUSTED_ERROR));
}

void
undefined_alien_handler(int signal, siginfo_t *siginfo, os_context_t *context) {
    arrange_return_to_lisp_function
        (context, StaticSymbolFunction(UNDEFINED_ALIEN_VARIABLE_ERROR));
}

kern_return_t
catch_exception_raise(mach_port_t exception_port,
                      mach_port_t thread,
                      mach_port_t task,
                      exception_type_t exception,
                      exception_data_t code_vector,
                      mach_msg_type_number_t code_count)
{
    struct thread *th = (struct thread*) exception_port;
    x86_thread_state32_t thread_state;
    mach_msg_type_number_t state_count;
    vm_address_t region_addr;
    vm_size_t region_size;
    vm_region_basic_info_data_t region_info;
    mach_msg_type_number_t info_count;
    mach_port_t region_name;
    void *addr = NULL;
    int signal = 0;
    void (*handler)(int, siginfo_t *, void *) = NULL;
    siginfo_t siginfo;
    kern_return_t ret;

    /* Get state and info */
    state_count = x86_THREAD_STATE32_COUNT;
    if ((ret = thread_get_state(thread,
                                x86_THREAD_STATE32,
                                (thread_state_t)&thread_state,
                                &state_count)) != KERN_SUCCESS)
        lose("thread_get_state (x86_THREAD_STATE32) failed %d\n", ret);
    switch (exception) {
    case EXC_BAD_ACCESS:
        signal = SIGBUS;
        /* Check if write protection fault */
        if ((code_vector[0] & OS_VM_PROT_ALL) == 0) {
            ret = KERN_INVALID_RIGHT;
            break;
        }
        addr = (void*)code_vector[1];
        /* Undefined alien */
        if (os_trunc_to_page(addr) == undefined_alien_address) {
            handler = undefined_alien_handler;
            break;
        }
        /* At stack guard */
        if (os_trunc_to_page(addr) == CONTROL_STACK_GUARD_PAGE(th)) {
            lower_thread_control_stack_guard_page(th);
            handler = control_stack_exhausted_handler;
            break;
        }
        /* Return from stack guard */
        if (os_trunc_to_page(addr) == CONTROL_STACK_RETURN_GUARD_PAGE(th)) {
            reset_thread_control_stack_guard_page(th);
            break;
        }
        /* Regular memory fault */
        handler = memory_fault_handler;
        break;
    case EXC_BAD_INSTRUCTION:
        signal = SIGTRAP;
        /* Check if illegal instruction trap */
        if (code_vector[0] != EXC_I386_INVOP) {
            ret = KERN_INVALID_RIGHT;
            break;
        }
        /* Check if UD2 instruction */
        if (*(unsigned short *)thread_state.EIP != 0x0b0f) {
            /* KLUDGE: There are two ways we could get here:
             * 1) We're executing data and we've hit some truly
             *    illegal opcode, of which there are a few, see
             *    Intel 64 and IA-32 Architectures
             *    Sofware Developer's Manual
             *    Volume 3A page 5-34)
             * 2) The kernel started an unrelated signal handler
             *    before we got a chance to run. The context that
             *    caused the exception is saved in a stack frame
             *    somewhere down below.
             * In either case we rely on the exception to retrigger,
             * eventually bailing out if we're spinning on case 2).
             */
            static mach_port_t last_thread;
            static unsigned int last_eip;
            if (last_thread == thread && last_eip == thread_state.EIP)
                ret = KERN_INVALID_RIGHT;
            else
                ret = KERN_SUCCESS;
            last_thread = thread;
            last_eip = thread_state.EIP;
            break;
        }
        /* Skip the trap code */
        thread_state.EIP += 2;
        /* Return from handler? */
        if (*(unsigned short *)thread_state.EIP == 0xffff) {
            if ((ret = thread_set_state(thread,
                                        x86_THREAD_STATE32,
                                        (thread_state_t)thread_state.EAX,
                                        x86_THREAD_STATE32_COUNT)) != KERN_SUCCESS)
                lose("thread_set_state (x86_THREAD_STATE32) failed %d\n", ret);
            if ((ret = thread_set_state(thread,
                                        x86_FLOAT_STATE32,
                                        (thread_state_t)thread_state.EBX,
                                        x86_FLOAT_STATE32_COUNT)) != KERN_SUCCESS)
                lose("thread_set_state (x86_FLOAT_STATE32) failed %d\n", ret);
            break;
        }
        /* Trap call */
        handler = sigtrap_handler;
        break;
    default:
        ret = KERN_INVALID_RIGHT;
    }
    /* Call handler */
    if (handler != 0) {
      siginfo.si_signo = signal;
      siginfo.si_addr = addr;
      call_handler_on_thread(thread, &thread_state, signal, &siginfo, handler);
    }
    return ret;
}

void *
mach_exception_handler(void *port)
{
  mach_msg_server(exc_server, 2048, (mach_port_t) port, 0);
  /* mach_msg_server should never return, but it should dispatch mach
   * exceptions to our catch_exception_raise function
   */
  lose("mach_msg_server returned");
}

#endif

#ifdef LISP_FEATURE_MACH_EXCEPTION_HANDLER

/* Sets up the thread that will listen for mach exceptions. note that
   the exception handlers will be run on this thread. This is
   different from the BSD-style signal handling situation in which the
   signal handlers run in the relevant thread directly. */

mach_port_t mach_exception_handler_port_set = MACH_PORT_NULL;

pthread_t
setup_mach_exception_handling_thread()
{
    kern_return_t ret;
    pthread_t mach_exception_handling_thread = NULL;
    pthread_attr_t attr;

    /* allocate a mach_port for this process */
    ret = mach_port_allocate(mach_task_self(),
                             MACH_PORT_RIGHT_PORT_SET,
                             &mach_exception_handler_port_set);

    /* create the thread that will receive the mach exceptions */

    FSHOW((stderr, "Creating mach_exception_handler thread!\n"));

    pthread_attr_init(&attr);
    pthread_create(&mach_exception_handling_thread,
                   &attr,
                   mach_exception_handler,
                   (void*) mach_exception_handler_port_set);
    pthread_attr_destroy(&attr);

    return mach_exception_handling_thread;
}

/* tell the kernel that we want EXC_BAD_ACCESS exceptions sent to the
   exception port (which is being listened to do by the mach
   exception handling thread). */
kern_return_t
mach_thread_init(mach_port_t thread_exception_port)
{
    kern_return_t ret;
    /* allocate a named port for the thread */

    FSHOW((stderr, "Allocating mach port %x\n", thread_exception_port));

    ret = mach_port_allocate_name(mach_task_self(),
                                  MACH_PORT_RIGHT_RECEIVE,
                                  thread_exception_port);
    if (ret) {
        lose("mach_port_allocate_name failed with return_code %d\n", ret);
    }

    /* establish the right for the thread_exception_port to send messages */
    ret = mach_port_insert_right(mach_task_self(),
                                 thread_exception_port,
                                 thread_exception_port,
                                 MACH_MSG_TYPE_MAKE_SEND);
    if (ret) {
        lose("mach_port_insert_right failed with return_code %d\n", ret);
    }

    ret = thread_set_exception_ports(mach_thread_self(),
                                     EXC_MASK_BAD_ACCESS | EXC_MASK_BAD_INSTRUCTION,
                                     thread_exception_port,
                                     EXCEPTION_DEFAULT,
                                     THREAD_STATE_NONE);
    if (ret) {
        lose("thread_set_exception_port failed with return_code %d\n", ret);
    }

    ret = mach_port_move_member(mach_task_self(),
                                thread_exception_port,
                                mach_exception_handler_port_set);
    if (ret) {
        lose("mach_port_ failed with return_code %d\n", ret);
    }

    return ret;
}

void
setup_mach_exceptions() {
    setup_mach_exception_handling_thread();
    mach_thread_init(THREAD_STRUCT_TO_EXCEPTION_PORT(all_threads));
}

pid_t
mach_fork() {
    pid_t pid = fork();
    if (pid == 0) {
        setup_mach_exceptions();
        return pid;
    } else {
        return pid;
    }
}

#endif
