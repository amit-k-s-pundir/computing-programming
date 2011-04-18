(defclass persistent-metalevel-class (standard-class)
  ((checked-schema-congruence-p :initform nil :reader class-checked-schema-congruence-p)))

(defclass persistent-standard-direct-slot-definition
	(standard-direct-slot-definition)
  ((transientp :initform nil :initarg :transient
			   :reader slot-definition-transient-p)))

(defclass persistent-standard-effective-slot-definition
	(sb-mop:standard-effective-slot-definition)
  ((transientp :initform nil :initarg :transient
			   :reader slot-definition-transient-p)))

(defmethod sb-mop:validate-superclass ((class persistent-metalevel-class)
									   (superclass standard-class))
  t)

(defclass hypertext-node ()
  ((contents :initform "" :accessor contents)
   (in-links :initform nil)
   (out-links :initform nil))
  (:metaclass persistent-metalevel-class))

(defmethod sb-mop:direct-slot-definition-class
	((class persistent-metalevel-class) initargs)
  (declare (ignore initargs))
  (find-class 'persistent-standard-direct-slot-definition))

(defclass persistence-root-class ()
  ((persistent? :initform t)
   (cached? :initform nil)
   (:metaclass persistent-metalevel-class)))

(defmethod initialize-instance :around
	((class persistent-metalevel-class)
	 &rest all-keys &key direct-superclasses)
  (let ((root-class (find-class 'persistece-root-class))
		(probjs-mc (find-class 'persistent-metalevel-class)))
	(if (member-if
		 #'(lambda (super)
			 (eq (class-of super) probjs-mc)) direct-superclasses)
		(call-next-method)
		(apply #'call-next-method class
			   :direct-superclasses (append direct-superclasses (list root-class))
			   all-keys))))

(setf hypertext-class-metaobject (find-class 'hypertext-node))

(sb-mop:class-direct-slots hypertext-class-metaobject)
(sb-mop:class-precedence-list hypertext-class-metaobject)

(defmethod sb-mop:validate-superclass
	((class persistent-metalevel-class) (superclass standard-class))
  t)

;;; A class that will facilititate the serialization of its instances
;;; from lisp to some other language.
(defclass lisp-to-x-metalevel-class (standard-class)
  ((target-lang-attrs :initform nil :reader class-target-lang-attrs)))

(defmethod sb-mop:validate-superclass ((class lisp-to-x-metalevel-class)
									   (superclass standard-class))
  t)

(defclass lisp-to-java-test-class ()
  ((x :reader get-x))
  (:metaclass lisp-to-x-metalevel-class))


  t)
