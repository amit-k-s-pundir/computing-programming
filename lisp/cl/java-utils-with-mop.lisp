;; (setf asdf:*central-registry*
;; 	  (list* '*default-pathname-defaults*
;; 			 #p "/opt/lisp/cl/clbuild/systems/"
;; 			 #p "/home/sonu/cl/systems/"
;; 			 #p "/usr/share/common-lisp/systems/"
;; 			 asdf:*central-registry*))

;;(asdf:oos 'asdf:load-op :asdf-binary-locations)

;; (defun asdf-load-packages (packages)
;;   (loop for package in packages
;; 	 do (asdf:oos 'asdf:load-op package) ))

(defun ql-load-packages (packages)
  (loop for package in packages
	 do (ql:quickload package) ))

;(asdf-load-packages '(:cl-who :cl-ppcre :parenscript :cl-fad :hunchentoot))

;(asdf-load-packages '( :cl-ppcre :parenscript :cl-who :cl-fad))

(ql-load-packages '( "cl-ppcre" "cl-fad" "cl-who" "parenscript" "hunchentoot"))

(defpackage java-utils
  (:use :common-lisp :cl-ppcre :parenscript :cl-who :cl-fad))

(defclass java-super-class ()
  )

(defclass java-test-class (java-root-class) ;  (java-super-class java-super-interface)
  ((field1 :initform nil :initarg :field1)
   (field2 :initform 5 :initarg :field2))
  (:metaclass java-metalevel-class)
   (:interface-p nil)
  (:java-specifiers '(:public nil))
  )

(defclass java-metalevel-class (standard-class)
  ((name :initform nil :initarg :java-class-name :accessor java-class-name)
   (interface-p :initform nil :initarg :interface-p :reader interface-p)
   (java-specifiers :initform nil :initarg :java-specifiers :reader java-specifiers)))

(defmethod sb-mop:validate-superclass ((class java-metalevel-class)
								(superclass standard-class))
  t)

(defclass java-root-class ()
  ()
  (:metaclass java-metalevel-class))

(defmethod sb-mop:validate-superclass ((class java-root-class)
									   (super-class standard-object))
  t)

(setq *java-str* (format nil "~A" (write-class-to-java (find-class 'java-test-class))))

(defmethod write-class-to-java ((clazz java-metalevel-class))
  (let ((s (make-array '(0) :fill-pointer 0
					   :adjustable t))
		(slots-definition-metaobjects (sb-mop:class-slots clazz))
		(class-name (sb-mop:class-name clazz))
		(superclasses (mapcan #'(lambda (x)
								  `(,(sb-mop:class-name x)))
							  (sb-mop:class-direct-superclasses clazz)
										;		(superinterfaces (class-direct-superinterfaces clazz))
							  )))
	(format nil "~A ~A class ~A ~@[extends ~{~A~^, ~} ~] ~
~@[implements ~{~A~^, ~} ~]{~%" "access-specifier" "storage-specifier"
class-name superclasses '("interface1" "interface2"))
										;		s
	))

(defmethod sb-mop:initialize-instance :around
  ((class java-metalevel-class) &rest all-keys &key direct-superclasses)
  (let ((root-class (find-class 'java-root-class))
		(pobjs-mc (find-class 'java-metalevel-class)))
	(if (member-if #'(lambda (super)
					   (eq (sb-mop:class-of super) pobjs-mc)) direct-superclasses)
		(call-next-method)
	  (apply #'call-next-method class
			 :direct-superclasses (append direct-superclasses (list root-class))
			 all-keys))))

(defun )










;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defmacro defjavaclass (name supertypes-names slot-specifiers class-options)
  `(progn
										;	 (defun java-class-name ()	   ',name)
	 (defclass ,name ,supertypes-names ,slot-specifiers ,args)))

(defclass java-standard-direct-slot-definition
	(standard-direct-slot-definition)
  ((literal-java :initform nil
				 :initarg :literal-java
				 :reader slot-definition-literal-java)))

(defclass java-standard-effective-slot-definition
	(standard-effective-slot-definition)
  ((literal-java :initform nil
				 :initarg :literal-java
				 :reader slot-definition-literal-java)))
  
(defmacro defjavamethod (function-name method-qualifiers specialized-lambda-list declerations
						 documentation &rest forms)
  `(defmethod ,function-name ,method-qualifiers ,specialized-lambda-list
			  ,declaration ,documentation ,forms))

`(defgeneric write-java-class )

(defclass java-root-class ()
  ((persistent? :initform nil))
  (:metaclass java-metalevel-class))

(defun setup-struts-project (proj-name base-dir)
  (setup-javaee-project proj-name base-dir))

(defun write-starter-openjpa-persistence-xml (&body body)
  )
