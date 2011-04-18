;;;;  -*- Mode: Lisp; Syntax: Common-Lisp; Package: SYSTEM -*-
;;;;
;;;;  top.lsp -- Top-level loop, break loop, and error handlers
;;;;
;;;;  Copyright (c) 1990, Giuseppe Attardi.
;;;;
;;;;    This program is free software; you can redistribute it and/or
;;;;    modify it under the terms of the GNU Library General Public
;;;;    License as published by the Free Software Foundation; either
;;;;    version 2 of the License, or (at your option) any later version.
;;;;
;;;;    See file '../Copyright' for full details.
;;;;
;;;;  Revised on July 11, by Carl Hoffman.
;;;;  Modified Oct 1986 by Ken Rimey.
;;;;  Reworked March 1987, by Edward Wang.
;;;;  Merged into new distribution Sept 1987, by Edward Wang.
;;;;  Reworked for Threads November 1988, by Giuseppe Attardi.
;;;;  Reworked for CLOS November 1988, by Giuseppe Attardi.

(in-package "SYSTEM")

(export '(*break-readtable* *break-on-warnings* *break-enable*
	  *tpl-evalhook* *tpl-prompt-hook*))

(defvar *quit-tag* (cons nil nil))
(defvar *quit-tags* nil)
(defvar *break-level* 0)		; nesting level of error loops
(defvar *break-env* nil)
(defvar *ihs-base* 0)
(defvar *ihs-top* (ihs-top 'si::top-level))
(defvar *ihs-current* 0)
(defvar *frs-base* 0)
(defvar *frs-top* 0)
(defvar *tpl-continuable* t)
(defvar *tpl-prompt-hook* nil)
(defvar *eof* (cons nil nil))

(defvar *last-error* nil)

(defvar *break-enable* t
  "ECL specific.
When an error is signaled, control enters a break loop only if the value of
this variable is non-NIL.  The initial value is T, but ECL automatically
rebinds this variable to NIL when control enters a break loop.")

(defvar *break-message* nil)

(defvar *break-readtable* nil)
(defvar *tpl-level* -1)			; nesting level of top-level loops
(defvar *step-level* 0)			; repeated from trace.lsp

(defvar *break-hidden-functions* '(error cerror apply funcall invoke-debugger))
(defvar *break-hidden-packages* (list #-ecl-min (find-package 'system)))

(defconstant tpl-commands
   '(("Top level commands"
      ((:cf :compile-file) tpl-compile-command :string
       ":cf		Compile file"
       ":compile-file &string &rest files		[Top level command]~@
	:cf &string &rest files				[Abbreviation]~@
	~@
	Compile files.  With no arguments, uses values from latest :cf~@
	command.  File extensions are optional.~%")
      ((:exit :eof) quit :eval
       ":exit or ^D	Exit Lisp"
       ":exit &eval &optional (status 0)		[Top level command]~@
	~@
	Exit Lisp without further confirmation.~%")
      ((:ld :load) tpl-load-command :string
       ":ld		Load file"
       ":load &string &rest files			[Top level command]~@
	:ld &string &rest files				[Abbreviation]~@
	~@
	Load files.  With no arguments, uses values from latest :ld~@
	or :cf command. File extensions are optional.~%")
      ((:step) tpl-step-command nil
       ":step		Single step form"
       ":step form					[Top level command]~@
	~@
	Evaluate form in single step mode.  While stepping, a new break~@
	level is invoked before every evaluation.  Extra commands are~@
	available at this time to control stepping and form evaluation.~%")
      ((:tr :trace) tpl-trace-command nil
       ":tr(ace)	Trace function"
       ":trace &rest functions				[Top level command]~@
	:tr &rest functions				[Abbreviation]~@
	~@
	Trace specified functions.  With no arguments, show currently~@
	traced functions.~@
	~@
	See also: :untrace.~%")
      ((:untr :untrace) tpl-untrace-command nil
       ":untr(ace)	Untrace function"
       ":untrace &rest functions			[Top level command]~@
	:untr &rest functions				[Abbreviation]~@
	~@
	Untrace specified functions.  With no arguments, untrace~@
	all functions.~@
	~@
	See also: :trace.~%")
      )
     ("Help commands"
      ((:apropos) tpl-apropos-command nil
       ":apropos	Apropos"
       ":apropos string &optional package		[Top level command]~@
	~@
	Finds all available symbols whose print names contain string.~@
	If a non NIL package is specified, only symbols in that package are considered.~@
	~%")
      ((:doc document) tpl-document-command nil
       ":doc(ument)	Document"
       ":document symbol				[Top level command]~@
	~@
	Displays documentation about function, print names contain string.~%")
      ((? :h :help) tpl-help-command nil
       ":h(elp) or ?	Help.  Type \":help help\" for more information"
       ":help &optional topic				[Top level command]~@
	:h &optional topic				[Abbrevation]~@
      	~@
	Print information on specified topic.  With no arguments, print~@
	quick summery of top level commands.~@
	~@
	Help information for top level commands follows the documentation~@
	style found in \"Common Lisp, the Language\"; and, in general, the~@
	commands themselves follow the conventions of Common Lisp functions,~@
	with the exception that arguments are normally not evaluated.~@
	Those commands that do evaluate their arguments are indicated by the~@
	keyword &eval in their description.  A third class of commands~@
	treat their arguments as whitespace-separated, case-sensitive~@
	strings, requiring double quotes only when necessary.  This style~@
	of argument processing is indicated by the keyword &string.~@
	For example, the :load command accepts a list of file names:
	~@
	:load &string &rest files			[Top level Command]~@
	~@
	whereas :exit, which requires an optional evaluated argument, is~@
	~@
	:exit &eval &optional status			[Top level Command]~%")
      )))

(defvar *tpl-commands* tpl-commands)

(defconstant break-commands
  '("Break commands"
     ((:q :quit) tpl-quit-command nil
       ":q(uit)		Return to some previous break level"
       ":quit &optional n				[Break command]~@
	:q &optional n					[Abbreviation]~@
	~@
	Without argument, return to top level;~@
	otherwise return to break level n.~%")
      ((:pop) (tpl-pop-command) :constant
       ":pop		Pop to previous break level"
       ":pop						[Break command]~@
	~@
	Pop to previous break level, or if already in top level,~@
	exit Lisp after confirmation.~%")
      ((:c :continue) continue nil
       ":c(ontinue)	Continue execution"
       ":continue					[Break command]~@
	:c						[Abbreviation]~@
	~@
	Continue execution.  Return from current break level to the caller.~@
	This command is only available when the break level is continuable~@
	(e.g., called from a correctable error or the function break).~%")
      ((:b :backtrace) tpl-backtrace nil
       ":b(acktrace)	Print backtrace"
       ":backtrace &optional n				[Break command]~@
	:b &optional n					[Abbreviation]~@
	~@
	Show function call history.  Only those functions called since~@
	the previous break level are shown.  In addition, functions compiled~@
	in-line or explicitly hidden are not displayed.  Without an argument,~@
	a concise backtrace is printed with the current function in upper~@
	case.  With integer argument n, the n functions above and including~@
	the current one are printed in a verbose format.  The current~@
	function is indicated with a '@' at the beginning of the line.~@
	With non-integer argument, all functions since the the previous break~@
	level are printed verbosely.~@
	~@
	See also: :function, :previous, :next.~%")
      ((:f :function) tpl-print-current nil
       ":f(unction)	Show current function"
       ":function					[Break command]~@
	:f						[Abbreviation]~@
	~@
	Show current function.  The current function is the implicit focus~@
	of attention for several other commands.  When it is an interpreted~@
 	function, its lexical environment is available for inspection and~@
	becomes the environment for evaluating user input forms.~@
	~@
	See also: :backtrace, :next, previous, :disassemble, :variables.~%")
      ((:p :previous) tpl-previous nil
       ":p(revious)	Go to previous function"
       ":previous &optional (n 1)			[Break command]~@
	:p &optional (n 1)				[Abbreviation]~@
	~@
	Move to the nth previous visible function in the backtrace.~@
 	It becomes the new current function.~@
	~@
	See also: :backtrace, :function, :go, :next.~%")
      ((:n :next) tpl-next nil
       ":n(ext)		Go to next function"
       ":next &optional (n 1)				[Break command]~@
	:n &optional (n 1)				[Abbreviation]~@
	~@
	Move to the nth next visible function in the backtrace.  It becomes~@
	the new current function.~@
	~@
	See also: :backtrace, :function, :go, :previous.~%")
      ((:g :go) tpl-go nil
       ":g(o)		Go to next function"
       ":go &optional (n 1)				[Break command]~@
	:g &optional (n 1)				[Abbreviation]~@
	~@
	Move to the function at IHS[i].~@
	See also: :backtrace, :function, :next, :previous.~%")
      ((:fs :forward-search) tpl-forward-search :string
       ":fs             Search forward for function"
       ":forward-search &string substring		[Break command]~@
	:fs &string substring				[Abbreviation]~@
	~@
	Search forward in the backtrace for function containing substring.~@
	The match is case insensitive.~@
	~@
	See also: :backtrace, :function, :next.~%")
      ((:bs :backward-search) tpl-backward-search :string
       ":bs             Search backward for function"
       ":backward-search &string substring		[Break command]~@
	:bs &string substring				[Abbreviation]~@
	~@
	Search backward in the backtrace for function containing substring.~@
	The match is case insensitive.~@
	~@
	See also: :backtrace, :function, :previous.~%")
      ((:d :disassemble) tpl-disassemble-command nil
       ":d(isassemble)	Disassemble current function"
       ":disassemble					[Break command]~@
	:d						[Abbreviation]~@
	~@
	Disassemble the current function. Currently, only interpreted functions~@
	can be disassembled.~%")
      ((:le :lambda-expression) tpl-lambda-expression-command nil
       ":l(ambda-)e(expression)	Show lisp code for current function"
       ":lambda-expression				[Break command]~@
	:le						[Abbreviation]~@
	~@
	Show the lisp code of the current function. Only works for interpreted~@
        functions.~%")
      ((:v :variables) tpl-variables-command nil
       ":v(ariables)	Show local variables, functions, blocks, and tags"
       ":variables &optional no-values			[Break command]~@
	:v &optional no-values				[Abbreviation]~@
	~@
	Show lexical variables, functions, block names, and tags local~@
	to the current function.  The current function must be interpreted.~@
	The values of local variables and functions are also shown,~@
	unless the argument is non-null.~%")
#|
      ((:l :local) tpl-local-command nil
       ":l(ocal)	Return the nth local value on the stack"
       ":local &optional (n 0)				[Break command]~@
	:l &optional (n 0)				[Abbreviation]
	~@
	For compiled functions, return the value of the nth lexical variable.~@
	As is done normally, the returned value is both printed by the top~@
	level as well as saved in the variable *.~%")
|#
      ((:hide) tpl-hide nil
       ":hide		Hide function"
       ":hide function					[Break command]~@
	~@
	Hide function.  A hidden function is not displayed in a backtrace.~@
	~@
	See also: :backtrace, :unhide, :hide-package.~%")
      ((:unhide) tpl-unhide nil
       ":unhide		Unhide function"
       ":unhide function				[Break command]~@
	~@
	Unhide function.  The specified function will be displayed in future~@
	backtraces, unless its home package is also hidden.~@
	~@
	See also: :backtrace, :hide, :unhide-package.~%")
      ((:hp :hide-package) tpl-hide-package nil
       ":hp		Hide package"
       ":hide-package package				[Break command]~@
	:hp package					[Abbreviation]~@
	~@
	Hide package.  Functions in a hidden package are not displayed~@
	in a backtrace.~@
	~@
	See also: :backtrace, :unhide-package.~%")
      ((:unhp :unhide-package) tpl-unhide-package nil
       ":unhp		Unhide package"
       ":unhide-package package				[Break command]~@
	:unhp package					[Abbreviation]~@
	~@
	Unhide package.  Functions in the specified package will be displayed~@
	in future backtraces, unless they are individually hidden.~@
	~@
	See also: :backtrace, :hide-package, :hide, :unhide.~%")
      ((:unhide-all) tpl-unhide-all nil
       ":unhide-all     Unhide all variables and packages"
       ":unhide-all					[Break command]~@
	~@
	Unhide all variables and packages.  All functions will be displayed~@
	in future backtraces.~@
	~@
	See also: :hide, :unhide, :hide-package, :unhide-package.~%")
#|
      ((:vs :value-stack) tpl-vs-command nil
       ":vs             Show value stack"
       ":value-stack &optional n			[Break command]~@
	:vs &optional n					[Abbreviation]~@
	~@
	Without an argument, show the entire value stack since the previous~@
	break level.  With an integer argument n, print nothing, but return~@
	the nth value stack entry.~@
	~@
	See also: :local.~%")
|#
      ((:bds :binding-stack) tpl-bds-command nil
       ":bds            Show binding stack"
       ":binding-stack &optional variable		[Break command]~@
	:bds &optional variable				[Abbreviation]~@
	~@
	Without an argument, show the entire binding stack since the previous~@
	break level.  With a variable name, print nothing, but return the~@
	value of the given variable on the binding stack.~%")
      ((:m :message) tpl-print-message nil
       ":m(essage)      Show error message"
       ":message					[Break command]~@
	:m						[Abbreviation]~@
	~@
	Show current error message.~%")
      ((:hs :help-stack) tpl-help-stack-command nil
       ":hs		Help stack"
       ":help-stack					[Break command]~@
	:hs						[Abbrevation]~@
	~@
	Lists the functions to access the LISP system stacks.~%")
      )
  )

(defvar *lisp-initialized* nil)

(defun top-level ()
  "Args: ()
ECL specific.
The top-level loop of ECL. It is called by default when ECL is invoked."
  (catch *quit-tag*
    (let* ((*debugger-hook* nil)
	   + ++ +++ - * ** *** / // ///)

      (in-package "CL-USER")

      (unless *lisp-initialized*
	(let ((*break-enable* nil))
	  ;; process command arguments
	  (process-command-args))
	(format t "ECL (Embeddable Common-Lisp) ~A" (lisp-implementation-version))
	(format t "~%Copyright (C) 1984 Taiichi Yuasa and Masami Hagiya~@
Copyright (C) 1993 Giuseppe Attardi~@
Copyright (C) 2000 Juan J. Garcia-Ripoll
ECL is free software, and you are welcome to redistribute it~@
under certain conditions; see file 'Copyright' for details.")
	(format *standard-output* "~%Type :h for Help.  ")
	(setq *lisp-initialized* t))

      (let ((*break-enable* t)
	    (*tpl-level* -1))
	(tpl)))))

(defun terminal-interrupt (correctablep)
  (let ((*break-enable* t))
    (if correctablep
      (cerror "Continues execution." 'ext:interactive-interrupt)
      (error "Console interrupt -- cannot continue."))))

(defun tpl (&key ((:commands *tpl-commands*) tpl-commands)
		 ((:prompt-hook *tpl-prompt-hook*) *tpl-prompt-hook*)
  		 (broken-at nil)
		 (quiet nil))
  (let* ((*ihs-base* *ihs-top*)
	 (*ihs-top* (if broken-at (ihs-search t broken-at) (ihs-top 'tpl)))
	 (*ihs-current* (if broken-at (ihs-prev *ihs-top*) *ihs-top*))
	 (*frs-base* (or (sch-frs-base *frs-top* *ihs-base*) (1+ (frs-top))))
	 (*frs-top* (frs-top))
	 (*read-suppress* nil)
	 (*quit-tags* (cons *quit-tag* *quit-tags*))
	 (*quit-tag* *quit-tags*)	; any unique new value
	 (*tpl-level* (1+ *tpl-level*))
	 values)
    (set-break-env)
    (set-current-ihs)
    (unless quiet
      (break-where))
    (loop
     (setq +++ ++ ++ + + -)
     (when (zerop *tpl-level*)
	   (reset-stack-limits))
     (when (catch *quit-tag*
	     (tpl-prompt)
	     (setq - (locally (declare (notinline tpl-read)) (tpl-read)))
	     (setq values
		   (multiple-value-list
		    (eval-with-env - *break-env*)))
	     (setq /// // // / / values *** ** ** * * (car /))
	     (tpl-print values)
	     nil)
	   (break-where)))))

(defun tpl-prompt ()
  (typecase *tpl-prompt-hook*
    (string (format t *tpl-prompt-hook*))
    (function (funcall *tpl-prompt-hook*))
    (t (fresh-line)
       (format t "~A~V,,,'>A "
	       (if (eq *package* (find-package 'user))
		   ""
		 (package-name *package*))
	       (- *tpl-level* *step-level* -1)
	       ""))))

(defun tpl-read ()
  (finish-output)
  (loop
    (case (peek-char nil *standard-input* nil :EOF)
      ((#\))
       (warn "Ignoring an unmatched right parenthesis.")
       (read-char))
      ((#\space #\tab)
       (read-char))
      ((#\newline #\return)
       (read-char)
       ;; avoid repeating prompt on successive empty lines:
       (let ((command (tpl-make-command :newline "")))
	 (when command (return command))))
      (:EOF
       (terpri)
       (return (tpl-make-command :EOF "")))
      (#\:
       (return (tpl-make-command (read-preserving-whitespace)
				 (read-line))))
      (#\?
       (read-char)
       (case (peek-char nil *standard-input* nil :EOF)
	 ((#\space #\tab #\newline #\return :EOF)
	  (return (tpl-make-command :HELP (read-line))))
	 (t
	  (unread-char #\?)
	  (return (read-preserving-whitespace)))))
      ;; We use READ-PRESERVING-WHITESPACE because with READ, if an
      ;; error happens within the reader, and we perform a ":C" or
      ;; (CONTINUE), the reader will wait for an inexistent #\Newline.
      (t
       (return (read))))))

(defun tpl-make-command (name line &aux (c nil))
  (dolist (commands *tpl-commands*)
    (when (setq c (assoc name (cdr commands) :test #'member))
      (return)))
  (cond ((null c)
	 (if (eq name :newline)		; special handling for Newline.
	     nil
	     `(tpl-unknown-command ',name)))
	((eq (third c) :restart)
	 `(invoke-restart-interactively ,(second c))) 
	((eq (third c) :eval)
	 `(,(second c) . ,(tpl-parse-forms line)))
	((eq (third c) :string)
	 `(,(second c) . ,(tpl-parse-strings line)))
	((eq (third c) :constant)
	 (second c))
	(t
	 `(,(second c) . ,(tpl-parse-forms line t)))))

(defun tpl-parse-forms (line &optional quote)
  (with-input-from-string (stream line)
    (do ((form (read stream nil *eof*) (read stream nil *eof*))
	 (list nil))
	((eq form *eof*) (nreverse list))
      (push (if quote `',form form) list))))

(defun tpl-parse-strings (line)
  (do ((i 0 end)
       (start)
       (end)
       (list nil)
       (space-p #'(lambda (c) (or (eql c #\space) (eql c #\tab))))
       (length (length line)))
      ((>= i length) (nreverse list))
    (cond ((null (setq start (position-if-not space-p line :START i)))
	   (setq end length))
	  ((eql (schar line start) #\")
	   (multiple-value-bind
	       (string n)
	       (read-from-string line t nil :START start)
	     (push string list)
	     (setq end n)))
	  (t
	   (setq end (or (position-if space-p line :START start) length))
	   (push (subseq line start end) list)))))

(defun tpl-print (values)
  (fresh-line)
  (dolist (v values)
    (prin1 v)
    (terpri)))

(defun tpl-unknown-command (command)
  (format t "Unknown top level command: ~s~%" command)
  (values))

(defun tpl-pop-command (&rest any)
  (declare (ignore any))
  (throw (pop *quit-tags*) t))

(defun tpl-quit-command (&optional (level 0))
  (when (and (>= level 0) (< level *tpl-level*))
    (let ((x (nth (- *tpl-level* level 1) *quit-tags*)))
      (throw x x)))
  (tpl-print-current))

(defun tpl-previous (&optional (n 1))
  (do ((i (si::ihs-prev *ihs-current*) (si::ihs-prev i)))
      ((or (< i *ihs-base*) (<= n 0)))
    (when (ihs-visible i)
      (setq *ihs-current* i)
      (decf n)))
  (set-break-env)
  (tpl-print-current))

(defun tpl-next (&optional (n 1))
  (do ((i (si::ihs-next *ihs-current*) (si::ihs-next i)))
      ((or (> i *ihs-top*) (<= n 0)))
    (when (ihs-visible i)
      (setq *ihs-current* i)
      (decf n)))
  (set-break-env)
  (tpl-print-current))

(defun tpl-go (ihs-index)
  (setq *ihs-current* (min (max ihs-index *ihs-base*) *ihs-top*))
  (if (ihs-visible *ihs-current*)
      (progn (set-break-env) (tpl-print-current))
      (tpl-previous)))

(defun tpl-print-message ()
  (when *break-message*
    (princ *break-message*)
    (terpri))
  (values))

(defun tpl-disassemble-command (&optional no-values)
  (let*((*print-level* 2)
	(*print-length* 4)
	(*print-pretty* t)
	(*print-readably* nil)
	(functions) (blocks) (variables))
    (unless (si::bc-disassemble (ihs-fun *ihs-current*))
      (tpl-print-current)
      (format t " Function cannot be disassembled.~%"))
    (values)))

(defun tpl-lambda-expression-command (&optional no-values)
  (let*((*print-level* 2)
	(*print-length* 4)
	(*print-pretty* t)
	(*print-readably* nil)
	(function (ihs-fun *ihs-current*))
	(le (function-lambda-expression function)))
    (if le
	(pprint le)
	(format t " No source code available for this function.~%"))
    (values)))

(defun reconstruct-bytecodes-lambda-list (data)
  (declare (si::c-local data))
  (let ((output '()))
    (dotimes (n (pop data))	;; required values
      (declare (fixnum n))
      (push (pop data) output))
    (let ((l (pop data)))	;; optional values
      (declare (fixnum l))
      (unless (zerop l)
	(push '&optional output)
	(dotimes (n l)
	  (push (first data) output)
	  (setf data (cdddr data)))))
    (let ((rest (pop data)))	;; &rest value
      (when rest
	(push '&rest output)
	(push rest output)))
    (let* ((allow-other-keys (pop data))) ;; &keys and &allow-other-keys
      (unless (eql allow-other-keys 0)
	(push '&key output)
	(let ((l (pop data)))
	  (declare (fixnum l))
	  (dotimes (n l)
	    (let* ((key (first data))
		   (var (second data)))
	      (unless (and (keywordp key) (string= key var))
		(setf var (list (list key var))))
	      (push var output))))
	(when allow-other-keys
	  (push '&allow-other-keys output))))
    (nreverse output)))

(defun function-lambda-list (function)
  (cond
    ((typep function 'generic-function)
     (generic-function-lambda-list function))
    ((not (typep function 'compiled-function))
     (function-lambda-list (fdefinition function)))
    ;; Use the lambda list from the function definition, if available,
    ;; but remove &aux arguments.
    ((let ((f (function-lambda-expression function)))
       (when f
	 (let* ((list (if (eql (first f) 'LAMBDA)
			  (second f)
			  (third f)))
		(ndx (position '&aux list)))
	   (if ndx
	       (subseq list 0 (1- ndx))
	       list)))))
    ;; Reconstruct the lambda list from the bytecodes
    ((multiple-value-bind (lex-env bytecodes data)
	 (si::bc-split function)
       (when bytecodes
	 (reconstruct-bytecodes-lambda-list (coerce data 'list)))))))

(defun tpl-variables-command (&optional no-values)
  (let*((*print-level* 2)
	(*print-length* 4)
	(*print-pretty* t)
	(*print-readably* nil)
	(functions '())
	(blocks '())
	(variables '())
	record0 record1)
    (dolist (record *break-env*)
      (cond ((atom record)
	     (push (compiled-function-name record) functions))
	    ((progn
	       (setf record0 (car record) record1 (cdr record))
	       (symbolp record0))
	     (setq variables (list* record0 record1 variables)))
	    ((symbolp record1)
	     (push record1 blocks))
	    (t
	     )))
    (format t "~:[~;Local functions: ~:*~{~s~^, ~}.~%~]" functions)
    (format t "~:[~;Block names: ~:*~{~s~^, ~}.~%~]" blocks)
    (format t "Local variables: ~:[~:[none~;~:*~{~s~1*~:@{, ~s~1*~}~}~]~;~
				   ~:[none~;~:*~{~%  ~s: ~s~}~]~]~%"
	    (not no-values) variables)
    (values)))

(defun tpl-bds-command (&optional var)
  (if var
    (do ((bi (1+ (frs-bds (max 0 (1- *frs-base*)))) (1+ bi))
	 (last (frs-bds (1+ *frs-top*))))
	((> bi last)
	 (format t "Variable not found.~%")
	 (values))
      (when (eq (bds-var bi) var)
	(return (bds-val bi))))
    (do ((bi (1+ (frs-bds (max 0 (1- *frs-base*)))) (1+ bi))
	 (last (frs-bds (1+ *frs-top*)))
	 (fi *frs-base*)
	 (*print-level* 2)
	 (*print-length* 4)
	 (*print-pretty* t))
	((> bi last) (values))
      (do ()
	  ((or (> fi *frs-top*) (>= (frs-bds fi) bi)))
	(print-frs fi)
	(incf fi))
      (format t "BDS[~d]: ~s = ~s~%"
	      bi (bds-var bi) (bds-val bi)))))

(defun tpl-backtrace (&optional n)
  (if (null n)
      (let ((*print-pretty* nil))	; because CLOS allows (setf foo)
					; as function names
	(princ "Backtrace:")
	(do ((i *ihs-top* (si::ihs-prev i))
	     (b nil t))
	    ((< i *ihs-base*))
	  (when (ihs-visible i)
	    (let ((*print-case* (if (= i *ihs-current*) :UPCASE :DOWNCASE)))
	      (format t "~:[~; >~] ~S" b (ihs-fname i)))))
	(terpri))
      (do ((i *ihs-top* (si::ihs-prev i))
	   (k (if (integerp n) n nil) (and k (1- k))))
	  ((= k 0) (values))
	(let*((j (or (sch-frs-base *frs-base* i) (1+ *frs-top*)))
	      (*print-level* 2)
	      (*print-length* 4)
	      (*print-pretty* t))
	  (do () ((or (> j *frs-top*) (> (frs-ihs j) i)))
	    (print-frs j)
	    (incf j)))))
  (values))

(defun print-frs (i)
  (format *debug-io* "    FRS[~d]: ---> IHS[~d],BDS[~d]~%"
	  i (frs-ihs i) (frs-bds i)))

(defun break-where ()
  (if (<= *tpl-level* 0)
    (format t "Top level.~%")
    (tpl-print-current)))

(defun tpl-print-current ()
  (let ((name (ihs-fname *ihs-current*)))
    (format t "Broken at ~:@(~S~)." name))
  (let ((fun (ihs-fun *ihs-current*)))
    (when (and (symbolp fun) (fboundp fun))
      (setf fun (fdefinition fun)))
    (multiple-value-bind (file position)
	(si::bc-file fun)
      (when file
	(format t " File: ~S (Form #~D)" file position))))
  (values))

(defun tpl-hide (fname)
  (unless (member fname *break-hidden-functions* :test #'eq)
    (push fname *break-hidden-functions*)
    (unless (ihs-visible *ihs-current*)
      (set-current-ihs)))
  (values))

(defun tpl-unhide (fname)
  (setq *break-hidden-functions*
	(delete fname *break-hidden-functions* :test #'eq))
  (values))

(defun tpl-unhide-package (package)
  (setq *break-hidden-packages*
	(delete (find-package package) *break-hidden-packages* :test #'eq))
  (values))

(defun tpl-unhide-all ()
  (setq *break-hidden-functions* nil)
  (setq *break-hidden-packages* nil)
  (values))

(defun tpl-hide-package (package)
  (setq package (find-package package))
  (unless (member package *break-hidden-packages* :test #'eq)
    (push package *break-hidden-packages*)
    (unless (ihs-visible *ihs-current*)
      (set-current-ihs)))
  (values))

(defun ihs-visible (i)
  (let ((fname (ihs-fname i)))
    #+clos
    (when (and (consp fname) (eq 'SETF (car fname)))
	  (setq fname (second fname)))
    (or (eq fname 'EVAL)
	(eq fname 'BYTECODES)
	(and (not (member (symbol-package fname) *break-hidden-packages*
			  :TEST #'eq))
	     (not (null fname))
	     (not (member fname *break-hidden-functions* :TEST #'eq))))))

(defun ihs-fname (i)
  (let ((function (ihs-fun i)))
    (cond ((symbolp function) function)
          ((compiled-function-p function)
           (or (compiled-function-name function) 'lambda))
	  #+clos
	  ((si:instancep function) (slot-value function 'name))
          (t :zombi))))

(defun set-current-ihs ()
  (do ((i *ihs-current* (si::ihs-prev i)))
      ((or (and (ihs-visible i) (setq *ihs-current* i))
	   (<= i *ihs-base*))))
  (set-break-env))

(defun set-break-env ()
  (setq *break-env* (ihs-env *ihs-current*)))

(defun ihs-search (string unrestricted &optional (start (si::ihs-top 'tpl)))
  (do ((ihs start (si::ihs-prev ihs)))
      ((< ihs *ihs-base*)
       (return nil))
    (when (and (or unrestricted (ihs-visible ihs))
	       (search (string string) (symbol-name (ihs-fname ihs))
		       :test #'char-equal))
      (return ihs))))

(defun tpl-backward-search (string)
  (let ((new-ihs (ihs-search string nil *ihs-current*)))
    (cond (new-ihs
	   (setf *ihs-current* new-ihs)
	   (set-current-ihs)
	   (tpl-print-current))
	  (t
	   (format *debug-io* "Search for ~a failed.~%" string)))
    (values)))

(defun tpl-forward-search (string)
  (do ((ihs (si::ihs-next *ihs-current*) (si::ihs-next ihs)))
      ((> ihs *ihs-top*)
       (format *debug-io* "Search for ~a failed.~%" string))
    (when (and (ihs-visible ihs)
	       (search string (symbol-name (ihs-fname ihs))
		       :test #'char-equal))
      (setq *ihs-current* ihs)
      (set-current-ihs)
      (tpl-print-current)
      (return)))
  (values))

(defun tpl-apropos-command (&optional string pkg)
  (when string (apropos string pkg)))

(defun tpl-document-command (&optional symbol)
  (when symbol (help symbol)))

(defun tpl-step-command (&optional form)
  (when form (step* form)))

(defun tpl-trace-command (&rest functions)
  (trace* functions))

(defun tpl-untrace-command (&rest functions)
  (untrace* functions))

(defvar *tpl-last-load* nil)

(defun tpl-load-command (&rest files)
  (when files
    (setq *tpl-last-load* files))
  (dolist (file *tpl-last-load*) (load file))
  *tpl-last-load*)

(defvar *tpl-last-compile* nil)

(defun tpl-compile-command (&rest files)
  (when files
    (setq *tpl-last-compile* files))
  (dolist (file *tpl-last-compile*) (compile-file file))
  (setq *tpl-last-load* *tpl-last-compile*))

(defun tpl-help-command (&optional topic)
  (cond ((null topic)
	 (dolist (commands *tpl-commands*)
	   (format t "~%~A:~%" (car commands))
	   (dolist (c (cdr commands))
	     (when (fourth c)
	       (format t "~A.~%" (fourth c))))))
	((or (stringp topic) (symbolp topic))
	 (let (c)
	   (setq topic (intern (string topic) (find-package 'keyword)))
	   (dolist (commands *tpl-commands*)
	     (when (setq c (assoc topic (cdr commands) :test #'member))
	       (return)))
	   (cond ((null (fifth c))
		  (format t "No such help topic: ~s~%"
			  (string topic)))
		 (t
		  (terpri)
		  (format t (fifth c))
		  (terpri)))))
	(t
	 (format t "Not a valid help topic: ~s~%" topic)))
  (values))

(defun tpl-help-stack-command ()
  (format t "
Use the following functions to directly access ECL stacks.

Invocation History Stack:
(sys:IHS-TOP)	Returns the index of the TOP of the IHS.
(SYS:IHS-VS i)	Returns the VS index of the i-th entity in IHS.
(SYS:IHS-FUN i)	Returns the function of the i-th entity in IHS.

Frame (catch, block) Stack:
(sys:FRS-TOP)	Returns the index of the TOP of the FRS.
(SYS:FRS-VS i)	Returns the VS index of the i-th entity in FRS.
(SYS:FRS-BDS i)	Returns the BDS index of the i-th entity in FRS.
(SYS:FRS-IHS i)	Returns the IHS index of the i-th entity in FRS.

Binding Stack:
(sys:BDS-TOP)	Returns the index of the TOP of the BDS.
(SYS:BDS-VAR i)	Returns the symbol of the i-th entity in BDS.
(SYS:BDS-VAL i)	Returns the value of the i-th entity in BDS.

Note that these functions are named by external symbols in the SYSTEM
package."
))

(defun default-debugger (condition)
  (unless *break-enable*
    (throw *quit-tag* nil))
  (let*((*standard-input* *debug-io*)
	(*standard-output* *debug-io*)
	(*print-pretty* nil)
	(*print-circle* t)
	(*readtable* (or *break-readtable* *readtable*))
	(*break-message* (format nil "~&~A~%" condition))
	(*break-level* (1+ *break-level*))
	(*break-env* nil))
    (when (listen *debug-io*)
      (clear-input *debug-io*))
    ;; Like in SBCL, the error message is output through *error-output*
    ;; The rest of the interaction is performed through *debug-io*
    (princ *break-message* *error-output*)
    (tpl-print-current)
    ;; Here we show a list of restarts and invoke the toplevel with
    ;; an extended set of commands which includes invoking the associated
    ;; restarts.
    (let* ((restarts (compute-restarts condition))
	   (restart-commands (list "Restart commands")))
      (format t (if restarts "Available restarts:~%" "No restarts available.~%"))
      (loop for restart in restarts
	 and i from 1
	 do (let ((user-command (format nil "r~D" i))
		  (name (format nil "~@[(~A) ~]" (restart-name restart)))
		  (helpstring (princ-to-string restart)))
	      (push (list
		     (list (intern (string-upcase user-command) :keyword))
		     restart :restart
		     (format nil ":~A~16T~A~24T~A" user-command helpstring name)
		     (format nil ":~A~48T~A~& ~&~A~A" (string-downcase user-command) "[Restart command]" name helpstring))
		    restart-commands)
	      (format t "~D. ~A~A~%" i name restart)))
      (tpl :commands
	   (adjoin (nreverse restart-commands)
		   (adjoin break-commands *tpl-commands*))))))

(defun invoke-debugger (condition)
  (when *debugger-hook*
    (let* ((old-hook *debugger-hook*)
	   (*debugger-hook* nil))
      (funcall old-hook condition old-hook)))
  (locally (declare (notinline default-debugger))
    (default-debugger condition)))

(defun safe-eval (form env err-value)
  (catch 'si::protect-tag
    (let* ((*debugger-hook*
	    #'(lambda (condition old-hooks)
		(throw 'si::protect-tag condition))))
      (return-from safe-eval (eval-with-env form env))))
  err-value)
