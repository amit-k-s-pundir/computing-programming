(require 'cl)

(defvar *initfunctions-for-this-defjavaclass*)
(defvar *readers-for-this-defjavaclass*)
(defvar *writers-for-this-defjavaclass*)
(defvar *slot-names-for-this-defjavaclass*)

(setq spring-bean-xml-prologue "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<beans xmlns=\"http://www.springframework.org/schema/beans\"
       xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
       xsi:schemaLocation=\"http://www.springframework.org/schema/beans
           http://www.springframework.org/schema/beans/spring-beans-2.5.xsd\">")

(defun spring-write-bean-config-file-xml (buffer beans)
;;  (princ prologue buffer)
  (let ((body (mapconcat 'bean-sexp-to-spring-xml beans "\n"))
		(epilogue "</beans>"))
	(princ (format "%s %s %s" prologue body epilogue) buffer)))

(defun bean-sexp-to-spring-xml (bean)
  (format "<bean id=\"%S\" class=\"%S\">%S</bean>" (cdr (assoc 'id bean))
		  (cdr (assoc 'class bean)) "")) 

(defmacro* spring-write-java-bean-java (bean)
  "Writes the spring xml configuration for a Java bean described through the list bean.
"
)

(defmacro* spring-write-java-bean-xml (bean)
  "Writes the spring xml configuration for a Java bean described through the list bean.
"
)

(defmacro* defjavaclass (&environment env name direct-superclasses direct-slots &rest options)
  (let (*initfunctions-for-this-defjavaclass*
		*readers-for-this-defjavaclass*
		*writers-for-this-defjavaclass*
		*slot-names-for-this-defjavaclass*)
	(multiple-value-bind (metaclass canonical-options)
		(canonize-defjavaclass-options name options)
	  (let ((canonical-slots (canonize-defjavaclass-slots name direct-slots env)))
		(let* ((defjavaclass-form
				`(let ,( mapcar #'cdr *initfunctions-for-this-defjavaclass*)
				   (load-defjavaclass ',name
									  ',metaclass
									  ',direct-superclasses
									  (list ,@canonical-slots)
									  (list ,@canonical-options)
									  ',*readers-for-this-defjavaclass*
									  ',*writers-for-this-defjavaclass*
									  ',*slot-names-for-this-defjavaclass*))))
		  `(eval-when (:load-toplevel :execute)
;			 (eval ,defjavaclass-form)
			 ,defjavaclass-form))))))

(defun* load-defjavaclass (name  metaclass  supers canonical-slots canonical-options
						  readers writers slot-names)
  (labels ((prologue ()
			 (let* ((class-kind (class-option-value  canonical-options :class-kind))
					(access-modifier (class-option-value canonical-options :access-modifier))
					(static-modifier (class-option-value  canonical-options :static-modifier))
					(super-class-name (car supers))
					(interfaces (cdr supers))
					(single-interface-p (and interfaces
											 (not (cdr interfaces))))
					(class-name name))
			   ;; (format nil "~<~A ~A ~A ~A ~:[~;extends ~A~] ~:[~;implements ~:[~A~;~A,~{,~A~}~]~] {~:@>"
			   ;; 		   `(,access-modifier
			   ;; 			 ,static-modifier ,class-kind ,class-name ,super-class-name ,super-class-name 
			   ;; 			 ,interfaces ,(not single-interface-p) ,(car interfaces) ,(cdr interfaces)
			   ;; 							;					 ,(apply #'concatenate 'string interfaces)
			   ;; 			 ))
			   (format nil "%s %s %s %s
;;~:[~;extends ~A~] is substituted with:
%s
;;~:[~;implements ~:[~A~;~A,~{,~A~}~]~] is substituted with:
%s
{"  access-modifier static-modifier class-kind class-name (if (null super-class-name)
																	  ""
																	(concat "extends" super-class-name))
 (if interfaces
	 (concat "implements" (if (single-interface-p)
							  (concat " " (car interfaces))
							(concat " " (mapconcat (function (lambda (x) x))
												   (cdr interfaces) " "))))
   "")
 ;,(apply #'concatenate 'string interfaces)
 ))))
		   ;; Each slot of defjavaclass will come with a :type slot option
		   ;; - the slot-type for that particular slot - which will have the
		   ;; following grammar: slot-type -> var-type | fun-type | type-type
		   ;; var-type -> java-var-type-spec fun-type -> (java-fun-return-type
		   ;; arg-type-list) arg-type-list -> '(' java-fun-arg-type-spec* ')'
		   ;; type-type -> nested-class-type | nested-interface-type
		   ;; nested-class-type -> 'static-nested-class' 'inner-class' |
		   ;; 'local-class' | 'anonymous-class' nested-interface-type ->
		   ;; 'annotation' | 'interface'
	(parse-var (canonical-slot)
			 (let* ((slot-name (symbol-name (slot-option-value canonical-slot :name)))
										;				  (slot-options (cdr canonical-slot))
					(access-modifier (slot-option-value canonical-slot :access-modifier))
										;					(static-modifier (if (eql :class (slot-option-value canonical-slot :allocation))
										;					"static"
										;					""))
					(static-modifier (slot-option-value canonical-slot :static-modifier))
					(slot-kind (slot-option-value canonical-slot :slot-kind))
					(slot-type (slot-option-value canonical-slot :slot-type))
										; (name (slot-option-value slot-options name))
					(slot-value (slot-option-value canonical-slot :slot-value))
					)
			   ;; (format nil "~<~%~S ~S ~S ~S ~:[;~;= ~S;~]~:@>" `(,access-modifier ,static-modifier
			   ;; 																	  ,slot-type ,slot-name
			   ;; 																	  ,slot-value
			   ;; 																	  ,slot-value))
			   (format nil "%s %s %s %s %s" access-modifier static-modifier
					   slot-type slot-name (if slot-value
											   (concat "= " slot-value)
											 ";"))
			   ))
	(parse-function (canonical-slot)
			 (let ((access-modifier (slot-option-value canonical-slot :access-modifier))
				   (static-modifier (slot-option-value canonical-slot :static-modifier))
				   (slot-kind (slot-option-value canonical-slot :slot-kind))
				   (slot-name (slot-option-value canonical-slot :name))
				   (slot-value (slot-option-value canonical-slot :slot-value)))
			   ;; (format nil "~<~%~S ~S ~S ~S{~%~S~%}~:@>" `(,access-modifier
			   ;; 											   ,static-modifier
			   ;; 											   ,slot-type ,name ,slot-value))
			   (format nil "%s %s %s %s{%s}" access-modifier static-modifier
					   slot-type name slot-value)
			   ))
		;		   (parse-type (canonical-slot)
										;		   (format nil "~<~%~S~@:>" `(,slot-value))
		;		   )
		   ;;(parse-annotation (slot))
		   ;;(parse-java-code (slot)
		   ;;					(format nil "~<~%~A~@:>" `(,@initform)))
	(epilogue ()
;;			  (format nil "}")
			  (format "%s" "}")
			  )
	(parse-slot (canonical-slot)
			 (case (slot-option-value canonical-slot :slot-kind)
			   (:var (parse-var canonical-slot))
			   (:nested-type (parse-type canonical-slot))
			   (:annotation (parse-annotation canonical-slot))
			   (:function (parse-function canonical-slot))
			   (:java-code (parse-java-code canonical-slot))))
	(let ((prologue-string (prologue))
		  (body-string (apply #'concatenate 'string (map 'list #'parse-slot canonical-slots)))
		  (epilogue-string (epilogue)))
										;		  `(apply #'cocatenate 'string ,prologue-string ,body-string ,epilogue-string)
	  (apply #'concatenate 'string `(,prologue-string ,body-string ,epilogue-string)))))

;; Each slot has an optional value; in the case of nested
;; types, it may be their definition as a literal string,
;; in which case, their definition will not be parsed and
;; will be send to the output stream directly. On the other
;; hand if the definition of the literal string is a list
;; then it will be parsed as usual.

(defun* canonize-defjavaclass-options (class-name options)
  (maplist (lambda (sublist)
			 (let ((option-name (first (pop sublist))))
			   (when (member* option-name sublist :key #'first)
				 ;; (error 'simple-program-error
				 ;; 		:format-control "Multiple ~S  options in DEFCLASS ~S."
				 ;; 		:format-arguments (list option-name class-name))
				 (error "Multiple %s  options in DEFCLASS %s" option-name class-name)
				 )))
		   options)
  (let (metaclass
		default-initargs
		documentation
		canonized-options
		class-kind
		access-modifier
		static-modifier)
	(dolist (option options)
	  (unless (listp option)
		(error "~S is not a legal defclass option" option))
	  (case (first option)
		(:metaclass
		 ;; do nothins
		 )
		(:default-initargs
		 (let (initargs arg-names)
		   (doplist (key val) (cdr option)
			 (when (member* key arg-names)
			   ;; (error 'simple-program-error
			   ;; 		  :format-control "~@<Duplicate initialization arguments ~
               ;;                           name ~S in :DEFAULT-INITARGS of ~
               ;;                           DEFCLASS ~S. ~:>"
			   ;; 		  :format-arguments (list key class-name))
			   (error "Duplicate initialization arguments name %s in :DEFAULT-INITARGS of
                                          DEFCLASS %s" key class-name))
			 (push key arg-names)
			 (push ``(,',key ,',val ,,(make-initfunction val)) initargs))
		   (setf default-initargs t)
		   (push `(:direct-default-initargs (list ,@(nreverse initargs)))
				 canonized-options)))
		(:documentation
		 ;;(unless (stringp (second option))
		   ;;(error "~S is not a legal :documentation value" (second option)))
		 (setf documentation t)
		 (push `(:documentation ,(second option)) canonized-options))
		(:class-kind
		 (setf class-kind t)
		 (push `'(:class-kind ,(second option)) canonized-options))
		(:access-modifier
		 (setf access-modifier t)
		 (push `'(:access-modifier ,(second option)) canonized-options))
		(:static-modifier
		 (setf static-modifier t)
		 (push `'(:static-modifier ,(second option)) canonized-options))
		(otherwise
		 (push `(',(car option) ',(cdr option)) canonized-options))))
	(values (or metaclass 'standard-javaclass) (nreverse canonized-options))))

;; Returns list of the following form:
;; ((:initfunction ,(make-initfunction initform) :name ',name :readers ',readers :writers ',writers
;;                          :initargs ',initargs
;;                        ,@type-check-function
;;                      ',others) ...)
;; where each element of the list correspond to a slot.
(defun* canonize-defjavaclass-slots (class-name slots env)
  (let (canonized-specs)
	(dolist (spec slots)
	  (when (atom spec)
		(setf spec (list spec)))
	  (when (and (cdr spec) (null (cddr spec)))
		;; (error 'simple-program-error
		;; 	   :format-control "~@<in DEFCLASS ~S, the slot specification ~S ~
        ;;                          is invalid; the probable intended meaning may ~
        ;;                          be achieved by specifying ~S instead. ~:>"
		;; 	   :format-arguments (list class-name spec
		;; 							   `(,(car spec) :initform ,(cadr spec))))
		(error "In DEFCLASS %s, the slot specification %s is invalid;
 the probable intended meaning may be achieved by specifying ~S instead" class-name
 spec `(,(car spec) :iniftorm ,(cadr spec)))
		)
	  (let* ((name (car spec))
			 (plist (cdr spec))
			 (readers ())
			 (writers ())
			 (initargs ())
			 (others ())
			 (unsupplied (list nil))
			 (type t)
			 (initform unsupplied)
			 (slot-kind))
		(check-slot-name-for-defjavaclass name class-name env)
		(push name *slot-names-for-this-defjavaclass*)
		(flet ((note-reader (x)
				 (unless (symbolp x)
				   ;; (error 'simple-program-error
				   ;; 		  :format-control "Slot reader name ~S for slot ~S in ~
                   ;;                                   DEFCLASS ~S is not a symbol."
				   ;; 		  :format-arguments (list x name class-name))
				   (error "Slot reader name %s for slot %s in DEFCLASS %s is not a symbol"
						  x name class-name)
				   )
				 (push x readers)
				 (push x *readers-for-this-defjavaclass*))
			   (note-writer (x)
				 (push x writers)
				 (push x *writers-for-this-defjavaclass*)))
		  (doplist (key val) plist
			(case key
			  (:accessor (note-reader val) (note-writer `(setf ,val)))
			  (:reader (note-reader val))
			  (:writer (note-writer val))
			  (:initarg
			   (unless (symbolp val)
				 ;; (error 'simple-program-error
				 ;; 		:format-control "Slot initarg named ~S for slot ~S in ~
                 ;;                             DEFCLASS ~S is not a symbol."
				 ;; 		:format-arguments (list val name class-name))
				 (error "Slot initarg named %s for slot %s in ~
                                         DEFCLASS %s is not a symbol"
						val name class-name)
				 )
			   (push val initargs))
			  (otherwise
				(when (member* key '(:initform :allocation :slot-kind :type :documentation))
				  (when (eq key :initform)
					(setf initform val))
				  (when (eq key :slot-kind)
					(setf slot-kind val))
				  ;;(when (get-properties others (list key))
					;;(error 'simple-program-error
                      ;;    :format-control "Duplicate slot option ~S for slot ~
                        ;;                   ~S in DEFCLASS ~S."
                          ;;:format-arguments (list key name class-name)))
				  )
				(push val (getf others key))))))
		(do ((head others (cddr head)))
			((null head))
		  (unless (cdr (second head))
			(setf (second head) (car (second head)))))
		(let* ((type-check-function
				(if (eq type t)
					nil
					`('type-check-function (lambda (value)
											 (declare (type ,type value))
													  value))))
				 (canon `(:name ',name :readers ',readers :writers ',writers
								:initargs ',initargs
								,@type-check-function ',others)))
			   (push (if (eq initform unsupplied)
						 `(list* ,@canon)
						 `(list* :initfunction ,(make-initfunction initform)
								 ,@canon))
				 canonized-specs))))
	  (nreverse canonized-specs)))

(defun* make-initfunction (initform)
  (cond ((or (eq initform t)
             (equal initform ''t))
         '(function constantly-t))
        ((or (eq initform nil)
             (equal initform ''nil))
         '(function constantly-nil))
        ((or (eql initform 0)
             (equal initform ''0))
         '(function constantly-0))
        (t
         (let ((entry (assoc* initform *initfunctions-for-this-defjavaclass*
                             :test #'equal)))
           (unless entry
             (setq entry (list initform
                               (gensym)
                               `(function (lambda ()
                                  (declare (optimize
                                            (sb-c:store-coverage-data 0)))
                                  ,initform))))
             (push entry *initfunctions-for-this-defjavaclass*))
           (cadr entry)))))

;; (defun* check-slot-name-for-defjavaclass (name class-name env)
;;   (flet ((slot-name-illegal (reason)
;;           (error 'simple-program-error
;;                   :format-control
;;                   (format nil "~~@<In DEFCLASS ~~S, the slot name ~~S ~
;;                                is ~A.~~@:>" reason)
;;                   :format-arguments (list class-name name))
;; 		  ))
;;     (cond ((not (symbolp name))
;;            (slot-name-illegal "not a symbol"))
;;           ((keywordp name)
;;            (slot-name-illegal "a keyword"))
;;           ;;((constantp name env)
;; ;;           (slot-name-illegal "a constant"))
;;           ((member* name *slot-names-for-this-defjavaclass* :test #'eq)
;;            (error 'simple-program-error
;;                   :format-control "Multiple slots named ~S in DEFCLASS ~S."
;;                   :format-arguments (list name class-name))))))

;; Finds the value of a given slot or a class option from a list of
;; canonical-options.
;; options: canonical-options
;; name: name of an option among the canonical-options.
(defun* slot-option-value (canonical-slot slot-option)
;  `(second (find ,name ,options :key #'car))
  (getf canonical-slot slot-option))

(defun* class-option-value (canonical-options option-name)
  (second (find option-name canonical-options :key #'car)))

(defmacro* doplist ((key val) plist &body body)
  `(let ((.plist-tail. ,plist) ,key ,val)
	 (loop (when (null .plist-tail.) (return nil))
		(setq ,key (pop .plist-tail.))
		(when (null .plist-tail.)
		  (error "malformed plist, odd number of elements"))
		(setq ,val (pop .plist-tail.))
		(progn ,@body))))

(setq output-string (defjavaclass Test (SuperTest)
					   ((x :slot-kind :var :access-modifier "public"
						   :static-modifier "static" :slot-type "int" :initform 5))
					   (:access-modifier "public") (:static-modifier "static") (:class-kind "class")))
