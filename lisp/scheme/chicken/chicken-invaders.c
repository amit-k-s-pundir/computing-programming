/* Generated from /home/sonu/workspace/programming/lisp/scheme/chicken/chicken-invaders.scm by the CHICKEN compiler
   http://www.call-with-current-continuation.org
   2012-08-30 14:15
   Version 4.7.0 
   linux-unix-gnu-x86 [ manyargs dload ptables ]
   compiled 2011-07-07 on localhost (Linux)
   command line: /home/sonu/workspace/programming/lisp/scheme/chicken/chicken-invaders.scm -output-file /home/sonu/workspace/programming/lisp/scheme/chicken/chicken-invaders.c -extend easyffi
   used units: library eval
*/

#include "chicken.h"

#include <gtk/gtk.h>


static C_word code_177() { gtk_init(&C_main_argc, &C_main_argv);
; return C_SCHEME_UNDEFINED; }


C_externexport  void  destroy(GtkWidget *t0,void * t1);

C_externexport  int  delete_event(GtkWidget *t0,GdkEvent *t1,void * t2);

C_externexport  void  hello(GtkWidget *t0,void * t1);

static C_PTABLE_ENTRY *create_ptable(void);
C_noret_decl(C_library_toplevel)
C_externimport void C_ccall C_library_toplevel(C_word c,C_word d,C_word k) C_noret;
C_noret_decl(C_eval_toplevel)
C_externimport void C_ccall C_eval_toplevel(C_word c,C_word d,C_word k) C_noret;

static C_TLS C_word lf[29];
static double C_possibly_force_alignment;
static C_char C_TLS li0[] C_aligned={C_lihdr(0,0,15),40,103,116,107,95,109,97,105,110,95,113,117,105,116,41,0};
static C_char C_TLS li1[] C_aligned={C_lihdr(0,0,22),40,103,116,107,95,105,110,105,116,32,97,51,56,52,51,32,97,51,55,52,52,41,0,0};
static C_char C_TLS li2[] C_aligned={C_lihdr(0,0,22),40,103,116,107,95,119,105,110,100,111,119,95,110,101,119,32,97,52,56,53,49,41,0,0};
static C_char C_TLS li3[] C_aligned={C_lihdr(0,0,42),40,103,95,115,105,103,110,97,108,95,99,111,110,110,101,99,116,32,97,53,55,54,52,32,97,53,54,54,53,32,97,53,53,54,54,32,97,53,52,54,55,41,0,0,0,0,0,0};
static C_char C_TLS li4[] C_aligned={C_lihdr(0,0,50),40,103,95,115,105,103,110,97,108,95,99,111,110,110,101,99,116,95,115,119,97,112,112,101,100,32,97,55,55,56,52,32,97,55,54,56,53,32,97,55,53,56,54,32,97,55,52,56,55,41,0,0,0,0,0,0};
static C_char C_TLS li5[] C_aligned={C_lihdr(0,0,45),40,103,116,107,95,99,111,110,116,97,105,110,101,114,95,115,101,116,95,98,111,114,100,101,114,95,119,105,100,116,104,32,97,57,53,57,57,32,97,57,52,49,48,48,41,0,0,0};
static C_char C_TLS li6[] C_aligned={C_lihdr(0,0,35),40,103,116,107,95,98,117,116,116,111,110,95,110,101,119,95,119,105,116,104,95,108,97,98,101,108,32,97,49,48,51,49,48,55,41,0,0,0,0,0};
static C_char C_TLS li7[] C_aligned={C_lihdr(0,0,28),40,103,116,107,95,119,105,100,103,101,116,95,100,101,115,116,114,111,121,32,97,49,49,49,49,49,53,41,0,0,0,0};
static C_char C_TLS li8[] C_aligned={C_lihdr(0,0,35),40,103,116,107,95,99,111,110,116,97,105,110,101,114,95,97,100,100,32,97,49,49,57,49,50,52,32,97,49,49,56,49,50,53,41,0,0,0,0,0};
static C_char C_TLS li9[] C_aligned={C_lihdr(0,0,25),40,103,116,107,95,119,105,100,103,101,116,95,115,104,111,119,32,97,49,50,57,49,51,51,41,0,0,0,0,0,0,0};
static C_char C_TLS li10[] C_aligned={C_lihdr(0,0,3),46,0,0,0,0,0,0,0};
static C_char C_TLS li11[] C_aligned={C_lihdr(0,0,10),40,103,116,107,95,109,97,105,110,41,0,0,0,0,0,0};
static C_char C_TLS li12[] C_aligned={C_lihdr(0,0,25),40,104,101,108,108,111,32,119,105,100,103,101,116,49,53,54,32,100,97,116,97,49,53,55,41,0,0,0,0,0,0,0};
static C_char C_TLS li13[] C_aligned={C_lihdr(0,0,41),40,100,101,108,101,116,101,95,101,118,101,110,116,32,119,105,100,103,101,116,49,54,51,32,101,118,101,110,116,49,54,52,32,100,97,116,97,49,54,53,41,0,0,0,0,0,0,0};
static C_char C_TLS li14[] C_aligned={C_lihdr(0,0,27),40,100,101,115,116,114,111,121,32,119,105,100,103,101,116,49,55,51,32,100,97,116,97,49,55,52,41,0,0,0,0,0};
static C_char C_TLS li15[] C_aligned={C_lihdr(0,0,10),40,116,111,112,108,101,118,101,108,41,0,0,0,0,0,0};


/* from k376 in gtk_main in k207 in k204 */
C_noret_decl(stub136)
static void C_ccall stub136(C_word C_c,C_word C_self,C_word C_k,C_word C_buf) C_noret;
static void C_ccall stub136(C_word C_c,C_word C_self,C_word C_k,C_word C_buf){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
int C_level=C_save_callback_continuation(&C_a,C_k);
gtk_main();
C_k=C_restore_callback_continuation2(C_level);
C_kontinue(C_k,C_r);}

/* from k367 */
static C_word C_fcall stub130(C_word C_buf,C_word C_a0) C_regparm;
C_regparm static C_word C_fcall stub130(C_word C_buf,C_word C_a0){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
GtkWidget *t0=(GtkWidget *)C_c_pointer_or_null(C_a0);
gtk_widget_show(t0);
return C_r;}

/* from k354 */
static C_word C_fcall stub120(C_word C_buf,C_word C_a0,C_word C_a1) C_regparm;
C_regparm static C_word C_fcall stub120(C_word C_buf,C_word C_a0,C_word C_a1){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
GtkContainer *t0=(GtkContainer *)C_c_pointer_or_null(C_a0);
GtkWidget *t1=(GtkWidget *)C_c_pointer_or_null(C_a1);
gtk_container_add(t0,t1);
return C_r;}

/* from k340 */
static C_word C_fcall stub112(C_word C_buf,C_word C_a0) C_regparm;
C_regparm static C_word C_fcall stub112(C_word C_buf,C_word C_a0){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
GtkWidget *t0=(GtkWidget *)C_c_pointer_or_null(C_a0);
gtk_widget_destroy(t0);
return C_r;}

/* from k326 in gtk_button_new_with_label in k207 in k204 */
static C_word C_fcall stub104(C_word C_buf,C_word C_a0) C_regparm;
C_regparm static C_word C_fcall stub104(C_word C_buf,C_word C_a0){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
char * t0=(char * )C_string_or_null(C_a0);
C_r=C_mpointer_or_false(&C_a,(void*)gtk_button_new_with_label(t0));
return C_r;}

/* from k316 */
static C_word C_fcall stub96(C_word C_buf,C_word C_a0,C_word C_a1) C_regparm;
C_regparm static C_word C_fcall stub96(C_word C_buf,C_word C_a0,C_word C_a1){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
GtkContainer *t0=(GtkContainer *)C_c_pointer_or_null(C_a0);
int t1=(int )C_num_to_int(C_a1);
gtk_container_set_border_width(t0,t1);
return C_r;}

/* from k289 */
static C_word C_fcall stub78(C_word C_buf,C_word C_a0,C_word C_a1,C_word C_a2,C_word C_a3) C_regparm;
C_regparm static C_word C_fcall stub78(C_word C_buf,C_word C_a0,C_word C_a1,C_word C_a2,C_word C_a3){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
void *t0=(void *)C_c_pointer_or_null(C_a0);
char * t1=(char * )C_string_or_null(C_a1);
void *t2=(void *)C_c_pointer_or_null(C_a2);
void *t3=(void *)C_c_pointer_or_null(C_a3);
C_r=C_int_to_num(&C_a,g_signal_connect_swapped(t0,t1,t2,t3));
return C_r;}

/* from k254 */
static C_word C_fcall stub58(C_word C_buf,C_word C_a0,C_word C_a1,C_word C_a2,C_word C_a3) C_regparm;
C_regparm static C_word C_fcall stub58(C_word C_buf,C_word C_a0,C_word C_a1,C_word C_a2,C_word C_a3){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
void *t0=(void *)C_c_pointer_or_null(C_a0);
char * t1=(char * )C_string_or_null(C_a1);
void *t2=(void *)C_c_pointer_or_null(C_a2);
void *t3=(void *)C_c_pointer_or_null(C_a3);
C_r=C_int_to_num(&C_a,g_signal_connect(t0,t1,t2,t3));
return C_r;}

/* from k235 */
static C_word C_fcall stub49(C_word C_buf,C_word C_a0) C_regparm;
C_regparm static C_word C_fcall stub49(C_word C_buf,C_word C_a0){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
int t0=(int )C_num_to_int(C_a0);
C_r=C_mpointer_or_false(&C_a,(void*)gtk_window_new(t0));
return C_r;}

/* from k222 */
static C_word C_fcall stub39(C_word C_buf,C_word C_a0,C_word C_a1) C_regparm;
C_regparm static C_word C_fcall stub39(C_word C_buf,C_word C_a0,C_word C_a1){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
int * t0=(int * )C_c_s32vector_or_null(C_a0);
C_char ***t1=(C_char ***)C_c_pointer_or_null(C_a1);
gtk_init(t0,t1);
return C_r;}

/* from gtk_main_quit in k207 in k204 */
static C_word C_fcall stub34(C_word C_buf) C_regparm;
C_regparm static C_word C_fcall stub34(C_word C_buf){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
gtk_main_quit();
return C_r;}

C_noret_decl(C_toplevel)
C_externexport void C_ccall C_toplevel(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_206)
static void C_ccall f_206(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_209)
static void C_ccall f_209(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_403)
static void C_ccall f_403(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_406)
static void C_ccall f_406(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_409)
static void C_ccall f_409(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_412)
static void C_ccall f_412(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_416)
static void C_ccall f_416(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_419)
static void C_ccall f_419(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_422)
static void C_ccall f_422(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_425)
static void C_ccall f_425(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_428)
static void C_ccall f_428(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_431)
static void C_ccall f_431(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_434)
static void C_ccall f_434(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_440)
static void C_ccall f_440(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_437)
static void C_ccall f_437(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_395)
static void C_ccall f_395(C_word c,C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_389)
static void C_ccall f_389(C_word c,C_word t0,C_word t1,C_word t2,C_word t3,C_word t4) C_noret;
C_noret_decl(f_393)
static void C_ccall f_393(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_383)
static void C_ccall f_383(C_word c,C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_374)
static void C_ccall f_374(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_378)
static void C_ccall f_378(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_364)
static void C_ccall f_364(C_word c,C_word t0,C_word t1,C_word t2) C_noret;
C_noret_decl(f_347)
static void C_ccall f_347(C_word c,C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_337)
static void C_ccall f_337(C_word c,C_word t0,C_word t1,C_word t2) C_noret;
C_noret_decl(f_323)
static void C_ccall f_323(C_word c,C_word t0,C_word t1,C_word t2) C_noret;
C_noret_decl(f_328)
static void C_ccall f_328(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_309)
static void C_ccall f_309(C_word c,C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_274)
static void C_ccall f_274(C_word c,C_word t0,C_word t1,C_word t2,C_word t3,C_word t4,C_word t5) C_noret;
C_noret_decl(f_283)
static void C_ccall f_283(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_239)
static void C_ccall f_239(C_word c,C_word t0,C_word t1,C_word t2,C_word t3,C_word t4,C_word t5) C_noret;
C_noret_decl(f_248)
static void C_ccall f_248(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_232)
static void C_ccall f_232(C_word c,C_word t0,C_word t1,C_word t2) C_noret;
C_noret_decl(f_215)
static void C_ccall f_215(C_word c,C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_212)
static void C_ccall f_212(C_word c,C_word t0,C_word t1) C_noret;

/* from destroy */
 void  destroy(GtkWidget *t0,void * t1){
C_word x,s=0+3+3,*a=C_alloc(s);
C_callback_adjust_stack(a,s);
x=C_mpointer_or_false(&a,(void*)t0);
C_save(x);
x=C_mpointer_or_false(&a,(void*)t1);
C_save(x);C_callback_wrapper((void *)f_395,2);}

/* from delete_event */
 int  delete_event(GtkWidget *t0,GdkEvent *t1,void * t2){
C_word x,s=0+3+3+3,*a=C_alloc(s);
C_callback_adjust_stack(a,s);
x=C_mpointer_or_false(&a,(void*)t0);
C_save(x);
x=C_mpointer_or_false(&a,(void*)t1);
C_save(x);
x=C_mpointer_or_false(&a,(void*)t2);
C_save(x);
return C_truep(C_callback_wrapper((void *)f_389,3));}

/* from hello */
 void  hello(GtkWidget *t0,void * t1){
C_word x,s=0+3+3,*a=C_alloc(s);
C_callback_adjust_stack(a,s);
x=C_mpointer_or_false(&a,(void*)t0);
C_save(x);
x=C_mpointer_or_false(&a,(void*)t1);
C_save(x);C_callback_wrapper((void *)f_383,2);}

C_noret_decl(tr6)
static void C_fcall tr6(C_proc6 k) C_regparm C_noret;
C_regparm static void C_fcall tr6(C_proc6 k){
C_word t5=C_pick(0);
C_word t4=C_pick(1);
C_word t3=C_pick(2);
C_word t2=C_pick(3);
C_word t1=C_pick(4);
C_word t0=C_pick(5);
C_adjust_stack(-6);
(k)(6,t0,t1,t2,t3,t4,t5);}

C_noret_decl(tr3)
static void C_fcall tr3(C_proc3 k) C_regparm C_noret;
C_regparm static void C_fcall tr3(C_proc3 k){
C_word t2=C_pick(0);
C_word t1=C_pick(1);
C_word t0=C_pick(2);
C_adjust_stack(-3);
(k)(3,t0,t1,t2);}

C_noret_decl(tr5)
static void C_fcall tr5(C_proc5 k) C_regparm C_noret;
C_regparm static void C_fcall tr5(C_proc5 k){
C_word t4=C_pick(0);
C_word t3=C_pick(1);
C_word t2=C_pick(2);
C_word t1=C_pick(3);
C_word t0=C_pick(4);
C_adjust_stack(-5);
(k)(5,t0,t1,t2,t3,t4);}

C_noret_decl(tr4)
static void C_fcall tr4(C_proc4 k) C_regparm C_noret;
C_regparm static void C_fcall tr4(C_proc4 k){
C_word t3=C_pick(0);
C_word t2=C_pick(1);
C_word t1=C_pick(2);
C_word t0=C_pick(3);
C_adjust_stack(-4);
(k)(4,t0,t1,t2,t3);}

C_noret_decl(tr2)
static void C_fcall tr2(C_proc2 k) C_regparm C_noret;
C_regparm static void C_fcall tr2(C_proc2 k){
C_word t1=C_pick(0);
C_word t0=C_pick(1);
C_adjust_stack(-2);
(k)(2,t0,t1);}

/* toplevel */
static C_TLS int toplevel_initialized=0;
C_main_entry_point
C_noret_decl(toplevel_trampoline)
static void C_fcall toplevel_trampoline(void *dummy) C_regparm C_noret;
C_regparm static void C_fcall toplevel_trampoline(void *dummy){
C_toplevel(2,C_SCHEME_UNDEFINED,C_restore);}

void C_ccall C_toplevel(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word *a;
if(toplevel_initialized) C_kontinue(t1,C_SCHEME_UNDEFINED);
else C_toplevel_entry(C_text("toplevel"));
C_resize_stack(131072);
C_check_nursery_minimum(3);
if(!C_demand(3)){
C_save(t1);
C_reclaim((void*)toplevel_trampoline,NULL);}
toplevel_initialized=1;
if(!C_demand_2(220)){
C_save(t1);
C_rereclaim2(220*sizeof(C_word), 1);
t1=C_restore;}
a=C_alloc(3);
C_initialize_lf(lf,29);
lf[0]=C_h_intern(&lf[0],19,"GTK_WINDOW_TOPLEVEL");
lf[1]=C_h_intern(&lf[1],13,"gtk_main_quit");
lf[2]=C_h_intern(&lf[2],8,"gtk_init");
lf[3]=C_h_intern(&lf[3],9,"s32vector");
lf[4]=C_h_intern(&lf[4],14,"gtk_window_new");
lf[5]=C_h_intern(&lf[5],16,"g_signal_connect");
lf[6]=C_h_intern(&lf[6],17,"\003sysmake-c-string");
lf[7]=C_h_intern(&lf[7],24,"g_signal_connect_swapped");
lf[8]=C_h_intern(&lf[8],30,"gtk_container_set_border_width");
lf[9]=C_h_intern(&lf[9],25,"gtk_button_new_with_label");
lf[10]=C_h_intern(&lf[10],18,"gtk_widget_destroy");
lf[11]=C_h_intern(&lf[11],17,"gtk_container_add");
lf[12]=C_h_intern(&lf[12],15,"gtk_widget_show");
lf[13]=C_h_intern(&lf[13],8,"gtk_main");
lf[14]=C_h_intern(&lf[14],6,"\003sysgc");
lf[15]=C_h_intern(&lf[15],5,"hello");
lf[16]=C_h_intern(&lf[16],5,"print");
lf[17]=C_decode_literal(C_heaptop,"\376B\000\000\014Hello, world");
lf[18]=C_h_intern(&lf[18],12,"delete_event");
lf[19]=C_decode_literal(C_heaptop,"\376B\000\000\024Delete event occured");
lf[20]=C_h_intern(&lf[20],7,"destroy");
lf[21]=C_h_intern(&lf[21],6,"window");
lf[22]=C_h_intern(&lf[22],6,"button");
lf[23]=C_h_intern(&lf[23],25,"\003sysimplicit-exit-handler");
lf[24]=C_decode_literal(C_heaptop,"\376B\000\000\007clicked");
lf[25]=C_decode_literal(C_heaptop,"\376B\000\000\007clicked");
lf[26]=C_decode_literal(C_heaptop,"\376B\000\000\013Hello World");
lf[27]=C_decode_literal(C_heaptop,"\376B\000\000\007destroy");
lf[28]=C_decode_literal(C_heaptop,"\376B\000\000\014delete_event");
C_register_lf2(lf,29,create_ptable());
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_206,a[2]=t1,tmp=(C_word)a,a+=3,tmp);
C_library_toplevel(2,C_SCHEME_UNDEFINED,t2);}

/* k204 */
static void C_ccall f_206(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_206,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_209,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_eval_toplevel(2,C_SCHEME_UNDEFINED,t2);}

/* k207 in k204 */
static void C_ccall f_209(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word t12;
C_word t13;
C_word t14;
C_word t15;
C_word t16;
C_word t17;
C_word t18;
C_word t19;
C_word ab[49],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_209,2,t0,t1);}
t2=C_mutate((C_word*)lf[0]+1 /* (set! GTK_WINDOW_TOPLEVEL ...) */,C_int_to_num(&a,GTK_WINDOW_TOPLEVEL));
t3=C_mutate((C_word*)lf[1]+1 /* (set! gtk_main_quit ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_212,a[2]=((C_word)li0),tmp=(C_word)a,a+=3,tmp));
t4=C_mutate((C_word*)lf[2]+1 /* (set! gtk_init ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_215,a[2]=((C_word)li1),tmp=(C_word)a,a+=3,tmp));
t5=C_mutate((C_word*)lf[4]+1 /* (set! gtk_window_new ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_232,a[2]=((C_word)li2),tmp=(C_word)a,a+=3,tmp));
t6=C_mutate((C_word*)lf[5]+1 /* (set! g_signal_connect ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_239,a[2]=((C_word)li3),tmp=(C_word)a,a+=3,tmp));
t7=C_mutate((C_word*)lf[7]+1 /* (set! g_signal_connect_swapped ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_274,a[2]=((C_word)li4),tmp=(C_word)a,a+=3,tmp));
t8=C_mutate((C_word*)lf[8]+1 /* (set! gtk_container_set_border_width ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_309,a[2]=((C_word)li5),tmp=(C_word)a,a+=3,tmp));
t9=C_mutate((C_word*)lf[9]+1 /* (set! gtk_button_new_with_label ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_323,a[2]=((C_word)li6),tmp=(C_word)a,a+=3,tmp));
t10=C_mutate((C_word*)lf[10]+1 /* (set! gtk_widget_destroy ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_337,a[2]=((C_word)li7),tmp=(C_word)a,a+=3,tmp));
t11=C_mutate((C_word*)lf[11]+1 /* (set! gtk_container_add ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_347,a[2]=((C_word)li8),tmp=(C_word)a,a+=3,tmp));
t12=C_mutate((C_word*)lf[12]+1 /* (set! gtk_widget_show ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_364,a[2]=((C_word)li9),tmp=(C_word)a,a+=3,tmp));
t13=C_mutate((C_word*)lf[13]+1 /* (set! gtk_main ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_374,a[2]=((C_word)li11),tmp=(C_word)a,a+=3,tmp));
t14=C_mutate((C_word*)lf[15]+1 /* (set! hello ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_383,a[2]=((C_word)li12),tmp=(C_word)a,a+=3,tmp));
t15=C_mutate((C_word*)lf[18]+1 /* (set! delete_event ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_389,a[2]=((C_word)li13),tmp=(C_word)a,a+=3,tmp));
t16=C_mutate((C_word*)lf[20]+1 /* (set! destroy ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_395,a[2]=((C_word)li14),tmp=(C_word)a,a+=3,tmp));
t17=code_177();
t18=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_403,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace("/home/sonu/workspace/programming/lisp/scheme/chicken/chicken-invaders.scm:56: gtk_window_new");
((C_proc3)C_fast_retrieve_symbol_proc(lf[4]))(3,*((C_word*)lf[4]+1),t18,C_fast_retrieve(lf[0]));}

/* k401 in k207 in k204 */
static void C_ccall f_403(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word ab[6],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_403,2,t0,t1);}
t2=C_mutate((C_word*)lf[21]+1 /* (set! window ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_406,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace("/home/sonu/workspace/programming/lisp/scheme/chicken/chicken-invaders.scm:60: g_signal_connect");
((C_proc6)C_fast_retrieve_symbol_proc(lf[5]))(6,*((C_word*)lf[5]+1),t3,C_fast_retrieve(lf[21]),lf[28],C_mpointer_or_false(&a,(void*)delete_event),C_SCHEME_FALSE);}

/* k404 in k401 in k207 in k204 */
static void C_ccall f_406(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[6],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_406,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_409,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace("/home/sonu/workspace/programming/lisp/scheme/chicken/chicken-invaders.scm:61: g_signal_connect");
((C_proc6)C_fast_retrieve_symbol_proc(lf[5]))(6,*((C_word*)lf[5]+1),t2,C_fast_retrieve(lf[21]),lf[27],C_mpointer_or_false(&a,(void*)destroy),C_SCHEME_FALSE);}

/* k407 in k404 in k401 in k207 in k204 */
static void C_ccall f_409(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_409,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_412,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace("/home/sonu/workspace/programming/lisp/scheme/chicken/chicken-invaders.scm:63: gtk_container_set_border_width");
((C_proc4)C_fast_retrieve_symbol_proc(lf[8]))(4,*((C_word*)lf[8]+1),t2,C_fast_retrieve(lf[21]),C_fix(10));}

/* k410 in k407 in k404 in k401 in k207 in k204 */
static void C_ccall f_412(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_412,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_416,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace("/home/sonu/workspace/programming/lisp/scheme/chicken/chicken-invaders.scm:65: gtk_button_new_with_label");
((C_proc3)C_fast_retrieve_symbol_proc(lf[9]))(3,*((C_word*)lf[9]+1),t2,lf[26]);}

/* k414 in k410 in k407 in k404 in k401 in k207 in k204 */
static void C_ccall f_416(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word ab[6],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_416,2,t0,t1);}
t2=C_mutate((C_word*)lf[22]+1 /* (set! button ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_419,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace("/home/sonu/workspace/programming/lisp/scheme/chicken/chicken-invaders.scm:67: g_signal_connect");
((C_proc6)C_fast_retrieve_symbol_proc(lf[5]))(6,*((C_word*)lf[5]+1),t3,C_fast_retrieve(lf[22]),lf[25],C_mpointer_or_false(&a,(void*)hello),C_SCHEME_FALSE);}

/* k417 in k414 in k410 in k407 in k404 in k401 in k207 in k204 */
static void C_ccall f_419(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[6],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_419,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_422,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace("/home/sonu/workspace/programming/lisp/scheme/chicken/chicken-invaders.scm:73: g_signal_connect_swapped");
((C_proc6)C_fast_retrieve_symbol_proc(lf[7]))(6,*((C_word*)lf[7]+1),t2,C_fast_retrieve(lf[22]),lf[24],C_mpointer_or_false(&a,(void*)gtk_widget_destroy),C_fast_retrieve(lf[21]));}

/* k420 in k417 in k414 in k410 in k407 in k404 in k401 in k207 in k204 */
static void C_ccall f_422(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_422,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_425,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace("/home/sonu/workspace/programming/lisp/scheme/chicken/chicken-invaders.scm:76: gtk_container_add");
((C_proc4)C_fast_retrieve_symbol_proc(lf[11]))(4,*((C_word*)lf[11]+1),t2,C_fast_retrieve(lf[21]),C_fast_retrieve(lf[22]));}

/* k423 in k420 in k417 in k414 in k410 in k407 in k404 in k401 in k207 in k204 */
static void C_ccall f_425(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_425,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_428,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace("/home/sonu/workspace/programming/lisp/scheme/chicken/chicken-invaders.scm:77: gtk_widget_show");
((C_proc3)C_fast_retrieve_symbol_proc(lf[12]))(3,*((C_word*)lf[12]+1),t2,C_fast_retrieve(lf[22]));}

/* k426 in k423 in k420 in k417 in k414 in k410 in k407 in k404 in k401 in k207 in k204 */
static void C_ccall f_428(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_428,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_431,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace("/home/sonu/workspace/programming/lisp/scheme/chicken/chicken-invaders.scm:78: gtk_widget_show");
((C_proc3)C_fast_retrieve_symbol_proc(lf[12]))(3,*((C_word*)lf[12]+1),t2,C_fast_retrieve(lf[21]));}

/* k429 in k426 in k423 in k420 in k417 in k414 in k410 in k407 in k404 in k401 in k207 in k204 */
static void C_ccall f_431(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_431,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_434,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace("/home/sonu/workspace/programming/lisp/scheme/chicken/chicken-invaders.scm:79: gtk_main");
((C_proc2)C_fast_retrieve_symbol_proc(lf[13]))(2,*((C_word*)lf[13]+1),t2);}

/* k432 in k429 in k426 in k423 in k420 in k417 in k414 in k410 in k407 in k404 in k401 in k207 in k204 */
static void C_ccall f_434(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word ab[6],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_434,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_437,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_440,a[2]=t2,tmp=(C_word)a,a+=3,tmp);
C_trace("##sys#implicit-exit-handler");
((C_proc2)C_fast_retrieve_symbol_proc(lf[23]))(2,*((C_word*)lf[23]+1),t3);}

/* k438 in k432 in k429 in k426 in k423 in k420 in k417 in k414 in k410 in k407 in k404 in k401 in k207 in k204 */
static void C_ccall f_440(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
t2=t1;
((C_proc2)C_fast_retrieve_proc(t2))(2,t2,((C_word*)t0)[2]);}

/* k435 in k432 in k429 in k426 in k423 in k420 in k417 in k414 in k410 in k407 in k404 in k401 in k207 in k204 */
static void C_ccall f_437(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
t2=((C_word*)t0)[2];
((C_proc2)(void*)(*((C_word*)t2+1)))(2,t2,C_SCHEME_UNDEFINED);}

/* destroy in k207 in k204 */
static void C_ccall f_395(C_word c,C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr4,(void*)f_395,4,t0,t1,t2,t3);}
C_trace("/home/sonu/workspace/programming/lisp/scheme/chicken/chicken-invaders.scm:48: gtk_main_quit");
((C_proc2)C_fast_retrieve_symbol_proc(lf[1]))(2,*((C_word*)lf[1]+1),t1);}

/* delete_event in k207 in k204 */
static void C_ccall f_389(C_word c,C_word t0,C_word t1,C_word t2,C_word t3,C_word t4){
C_word tmp;
C_word t5;
C_word t6;
C_word ab[3],*a=ab;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr5,(void*)f_389,5,t0,t1,t2,t3,t4);}
t5=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_393,a[2]=t1,tmp=(C_word)a,a+=3,tmp);
C_trace("/home/sonu/workspace/programming/lisp/scheme/chicken/chicken-invaders.scm:42: print");
((C_proc3)C_fast_retrieve_proc(*((C_word*)lf[16]+1)))(3,*((C_word*)lf[16]+1),t5,lf[19]);}

/* k391 in delete_event in k207 in k204 */
static void C_ccall f_393(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
t2=((C_word*)t0)[2];
((C_proc2)(void*)(*((C_word*)t2+1)))(2,t2,C_SCHEME_TRUE);}

/* hello in k207 in k204 */
static void C_ccall f_383(C_word c,C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr4,(void*)f_383,4,t0,t1,t2,t3);}
C_trace("/home/sonu/workspace/programming/lisp/scheme/chicken/chicken-invaders.scm:36: print");
((C_proc3)C_fast_retrieve_proc(*((C_word*)lf[16]+1)))(3,*((C_word*)lf[16]+1),t1,lf[17]);}

/* gtk_main in k207 in k204 */
static void C_ccall f_374(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
if(c!=2) C_bad_argc_2(c,2,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_374,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_378,a[2]=t1,tmp=(C_word)a,a+=3,tmp);
C_trace("##sys#gc");
((C_proc3)C_fast_retrieve_symbol_proc(lf[14]))(3,*((C_word*)lf[14]+1),t2,C_SCHEME_FALSE);}

/* k376 in gtk_main in k207 in k204 */
static void C_ccall f_378(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word ab[11],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_378,2,t0,t1);}
t2=C_a_i_bytevector(&a,1,C_fix(6));
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)stub136,a[2]=((C_word)li10),tmp=(C_word)a,a+=3,tmp);
C_trace("g139140");
t4=t3;
((C_proc3)C_fast_retrieve_proc(t4))(3,t4,((C_word*)t0)[2],t2);}

/* gtk_widget_show in k207 in k204 */
static void C_ccall f_364(C_word c,C_word t0,C_word t1,C_word t2){
C_word tmp;
C_word t3;
C_word t4;
C_word *a;
if(c!=3) C_bad_argc_2(c,3,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr3,(void*)f_364,3,t0,t1,t2);}
t3=(C_truep(t2)?C_i_foreign_pointer_argumentp(t2):C_SCHEME_FALSE);
t4=t1;
((C_proc2)(void*)(*((C_word*)t4+1)))(2,t4,stub130(C_SCHEME_UNDEFINED,t3));}

/* gtk_container_add in k207 in k204 */
static void C_ccall f_347(C_word c,C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr4,(void*)f_347,4,t0,t1,t2,t3);}
t4=(C_truep(t2)?C_i_foreign_pointer_argumentp(t2):C_SCHEME_FALSE);
t5=(C_truep(t3)?C_i_foreign_pointer_argumentp(t3):C_SCHEME_FALSE);
t6=t1;
((C_proc2)(void*)(*((C_word*)t6+1)))(2,t6,stub120(C_SCHEME_UNDEFINED,t4,t5));}

/* gtk_widget_destroy in k207 in k204 */
static void C_ccall f_337(C_word c,C_word t0,C_word t1,C_word t2){
C_word tmp;
C_word t3;
C_word t4;
C_word *a;
if(c!=3) C_bad_argc_2(c,3,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr3,(void*)f_337,3,t0,t1,t2);}
t3=(C_truep(t2)?C_i_foreign_pointer_argumentp(t2):C_SCHEME_FALSE);
t4=t1;
((C_proc2)(void*)(*((C_word*)t4+1)))(2,t4,stub112(C_SCHEME_UNDEFINED,t3));}

/* gtk_button_new_with_label in k207 in k204 */
static void C_ccall f_323(C_word c,C_word t0,C_word t1,C_word t2){
C_word tmp;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word ab[9],*a=ab;
if(c!=3) C_bad_argc_2(c,3,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr3,(void*)f_323,3,t0,t1,t2);}
t3=C_a_i_bytevector(&a,1,C_fix(3));
t4=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_328,a[2]=t3,a[3]=t1,tmp=(C_word)a,a+=4,tmp);
if(C_truep(t2)){
t5=C_i_foreign_string_argumentp(t2);
C_trace("##sys#make-c-string");
((C_proc3)C_fast_retrieve_symbol_proc(lf[6]))(3,*((C_word*)lf[6]+1),t4,t5);}
else{
t5=t4;
f_328(2,t5,C_SCHEME_FALSE);}}

/* k326 in gtk_button_new_with_label in k207 in k204 */
static void C_ccall f_328(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
t2=((C_word*)t0)[3];
((C_proc2)(void*)(*((C_word*)t2+1)))(2,t2,stub104(((C_word*)t0)[2],t1));}

/* gtk_container_set_border_width in k207 in k204 */
static void C_ccall f_309(C_word c,C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr4,(void*)f_309,4,t0,t1,t2,t3);}
t4=(C_truep(t2)?C_i_foreign_pointer_argumentp(t2):C_SCHEME_FALSE);
t5=C_i_foreign_integer_argumentp(t3);
t6=t1;
((C_proc2)(void*)(*((C_word*)t6+1)))(2,t6,stub96(C_SCHEME_UNDEFINED,t4,t5));}

/* g_signal_connect_swapped in k207 in k204 */
static void C_ccall f_274(C_word c,C_word t0,C_word t1,C_word t2,C_word t3,C_word t4,C_word t5){
C_word tmp;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word ab[13],*a=ab;
if(c!=6) C_bad_argc_2(c,6,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr6,(void*)f_274,6,t0,t1,t2,t3,t4,t5);}
t6=C_a_i_bytevector(&a,1,C_fix(4));
t7=(C_truep(t2)?C_i_foreign_pointer_argumentp(t2):C_SCHEME_FALSE);
t8=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_283,a[2]=t7,a[3]=t6,a[4]=t1,a[5]=t5,a[6]=t4,tmp=(C_word)a,a+=7,tmp);
if(C_truep(t3)){
t9=C_i_foreign_string_argumentp(t3);
C_trace("##sys#make-c-string");
((C_proc3)C_fast_retrieve_symbol_proc(lf[6]))(3,*((C_word*)lf[6]+1),t8,t9);}
else{
t9=t8;
f_283(2,t9,C_SCHEME_FALSE);}}

/* k281 in g_signal_connect_swapped in k207 in k204 */
static void C_ccall f_283(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
t2=((C_word*)t0)[6];
t3=(C_truep(t2)?C_i_foreign_pointer_argumentp(t2):C_SCHEME_FALSE);
t4=((C_word*)t0)[5];
t5=(C_truep(t4)?C_i_foreign_pointer_argumentp(t4):C_SCHEME_FALSE);
t6=((C_word*)t0)[4];
((C_proc2)(void*)(*((C_word*)t6+1)))(2,t6,stub78(((C_word*)t0)[3],((C_word*)t0)[2],t1,t3,t5));}

/* g_signal_connect in k207 in k204 */
static void C_ccall f_239(C_word c,C_word t0,C_word t1,C_word t2,C_word t3,C_word t4,C_word t5){
C_word tmp;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word ab[13],*a=ab;
if(c!=6) C_bad_argc_2(c,6,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr6,(void*)f_239,6,t0,t1,t2,t3,t4,t5);}
t6=C_a_i_bytevector(&a,1,C_fix(4));
t7=(C_truep(t2)?C_i_foreign_pointer_argumentp(t2):C_SCHEME_FALSE);
t8=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_248,a[2]=t7,a[3]=t6,a[4]=t1,a[5]=t5,a[6]=t4,tmp=(C_word)a,a+=7,tmp);
if(C_truep(t3)){
t9=C_i_foreign_string_argumentp(t3);
C_trace("##sys#make-c-string");
((C_proc3)C_fast_retrieve_symbol_proc(lf[6]))(3,*((C_word*)lf[6]+1),t8,t9);}
else{
t9=t8;
f_248(2,t9,C_SCHEME_FALSE);}}

/* k246 in g_signal_connect in k207 in k204 */
static void C_ccall f_248(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
t2=((C_word*)t0)[6];
t3=(C_truep(t2)?C_i_foreign_pointer_argumentp(t2):C_SCHEME_FALSE);
t4=((C_word*)t0)[5];
t5=(C_truep(t4)?C_i_foreign_pointer_argumentp(t4):C_SCHEME_FALSE);
t6=((C_word*)t0)[4];
((C_proc2)(void*)(*((C_word*)t6+1)))(2,t6,stub58(((C_word*)t0)[3],((C_word*)t0)[2],t1,t3,t5));}

/* gtk_window_new in k207 in k204 */
static void C_ccall f_232(C_word c,C_word t0,C_word t1,C_word t2){
C_word tmp;
C_word t3;
C_word t4;
C_word t5;
C_word ab[5],*a=ab;
if(c!=3) C_bad_argc_2(c,3,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr3,(void*)f_232,3,t0,t1,t2);}
t3=C_a_i_bytevector(&a,1,C_fix(3));
t4=C_i_foreign_integer_argumentp(t2);
t5=t1;
((C_proc2)(void*)(*((C_word*)t5+1)))(2,t5,stub49(t3,t4));}

/* gtk_init in k207 in k204 */
static void C_ccall f_215(C_word c,C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr4,(void*)f_215,4,t0,t1,t2,t3);}
t4=(C_truep(t2)?C_i_foreign_struct_wrapper_argumentp(lf[3],t2):C_SCHEME_FALSE);
t5=(C_truep(t3)?C_i_foreign_pointer_argumentp(t3):C_SCHEME_FALSE);
t6=t1;
((C_proc2)(void*)(*((C_word*)t6+1)))(2,t6,stub39(C_SCHEME_UNDEFINED,t4,t5));}

/* gtk_main_quit in k207 in k204 */
static void C_ccall f_212(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
if(c!=2) C_bad_argc_2(c,2,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_212,2,t0,t1);}
t2=t1;
((C_proc2)(void*)(*((C_word*)t2+1)))(2,t2,stub34(C_SCHEME_UNDEFINED));}

#ifdef C_ENABLE_PTABLES
static C_PTABLE_ENTRY ptable[36] = {
{"toplevel:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)C_toplevel},
{"f_206:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_206},
{"f_209:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_209},
{"f_403:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_403},
{"f_406:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_406},
{"f_409:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_409},
{"f_412:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_412},
{"f_416:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_416},
{"f_419:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_419},
{"f_422:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_422},
{"f_425:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_425},
{"f_428:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_428},
{"f_431:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_431},
{"f_434:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_434},
{"f_440:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_440},
{"f_437:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_437},
{"f_395:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_395},
{"f_389:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_389},
{"f_393:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_393},
{"f_383:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_383},
{"f_374:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_374},
{"f_378:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_378},
{"f_364:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_364},
{"f_347:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_347},
{"f_337:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_337},
{"f_323:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_323},
{"f_328:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_328},
{"f_309:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_309},
{"f_274:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_274},
{"f_283:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_283},
{"f_239:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_239},
{"f_248:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_248},
{"f_232:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_232},
{"f_215:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_215},
{"f_212:_2fhome_2fsonu_2fworkspace_2fprogramming_2flisp_2fscheme_2fchicken_2fchicken_2dinvaders_2escm",(void*)f_212},
{NULL,NULL}};
#endif

static C_PTABLE_ENTRY *create_ptable(void){
#ifdef C_ENABLE_PTABLES
return ptable;
#else
return NULL;
#endif
}
/* end of file */
