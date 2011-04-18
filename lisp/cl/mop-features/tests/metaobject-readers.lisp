(defclass test-super ()
  (a b)
  (:default-initargs :a 'foo :b 'bar))

(defclass test-sub (test-super)
  (c)
  (:default-initargs :b 'baz))

(unless (class-finalized-p (find-class 'test-sub))
  (finalize-inheritance (find-class 'test-sub)))

(ignore-errors
  (loop for default-initarg in (class-default-initargs (find-class 'test-sub))
        when (member (first default-initarg) seen-initargs) return nil
        collect (first default-initarg) into seen-initargs
        if (eq (first default-initarg) :a) do
        (unless (and (equal (second default-initarg) '(quote foo))
                     (eq (funcall (third default-initarg)) 'foo))
          (return))
        else if (eq (first default-initarg) :b) do
        (unless (and (equal (second default-initarg) '(quote baz))
                     (eq (funcall (third default-initarg)) 'baz))
          (return))
        finally (when (subsetp '(:a :b) (print seen-initargs))
                  (acknowledge :class-default-initargs))))

(ignore-errors
  (loop for default-initarg in (class-direct-default-initargs (find-class 'test-super))
        when (member (first default-initarg) seen-initargs) return nil
        collect (first default-initarg) into seen-initargs
        if (eq (first default-initarg) :a) do
        (unless (and (equal (second default-initarg) '(quote foo))
                     (eq (funcall (third default-initarg)) 'foo))
          (return))
        else if (eq (first default-initarg) :b) do
        (unless (and (equal (second default-initarg) '(quote bar))
                     (eq (funcall (third default-initarg)) 'bar))
          (return))
        finally (when (subsetp '(:a :b) (print seen-initargs))
                  (acknowledge :class-direct-default-initargs))))

(ignore-errors
  (loop for direct-slot in (class-direct-slots (find-class 'test-sub))
        count (eq (slot-definition-name direct-slot) 'c) into slot-count
        count t into slot-total-count
        finally (when (<= 1 slot-count slot-total-count 1)
                  (acknowledge :class-direct-slots))))

(ignore-errors
  (loop for subclass in (class-direct-subclasses (find-class 'test-super))
        count (eq (class-name subclass) 'test-sub) into subclass-count
        count t into total-subclass-count
        finally (when (<= 1 subclass-count total-subclass-count 1)
                  (acknowledge :class-direct-subclasses))))

(ignore-errors
  (loop for subclass in (class-direct-superclasses (find-class 'test-sub))
        count (eq (class-name subclass) 'test-super) into superclass-count
        count t into total-superclass-count
        finally (when (<= 1 superclass-count total-superclass-count 1)
                  (acknowledge :class-direct-superclasses))))

(ignore-errors
  (when (class-finalized-p (find-class 'test-sub))
    (acknowledge :class-finalized-p)))

(ignore-errors
  (when (member (find-class 'test-super)
                (member (find-class 'test-sub)
                        (class-precedence-list (find-class 'test-sub))))
    (acknowledge :class-precedence-list)))

(ignore-errors
  (when (typep (class-prototype (find-class 'test-sub)) 'test-sub)
    (acknowledge :class-prototype)))

(ignore-errors
  (loop for slot in (class-slots (find-class 'test-sub))
        when (member (slot-definition-name slot) seen-slots) return nil
        collect (slot-definition-name slot) into seen-slots
        finally (when (subsetp '(a b c) seen-slots)
                  (acknowledge :class-slots))))

(defgeneric test (a b c)
  (:argument-precedence-order c b a)
  (declare (optimize (speed 3)))
  (:generic-function-class standard-generic-function))

(defparameter *the-method*
  (defmethod test :around (a b c)
    (print 'test)))

(ignore-errors
  (when (equal (generic-function-argument-precedence-order #'test)
               '(c b a))
    (acknowledge :generic-function-argument-precedence-order)))

(ignore-errors
  (when (equal (generic-function-declarations #'test)
               '((optimize (speed 3))))
    (acknowledge :generic-function-declarations)))

(ignore-errors
  (when (equal (generic-function-lambda-list #'test)
               '(a b c))
    (acknowledge :generic-function-lambda-list)))

(ignore-errors
  (when (eq (generic-function-method-class #'test)
            (find-class 'standard-method))
    (acknowledge :generic-function-method-class)))

(ignore-errors
  (when #-ecl (typep (generic-function-method-combination #'test)
                     'method-combination)
    #+ecl (equal (generic-function-method-combination #'test) '(standard))
    (acknowledge :generic-function-method-combination)))

(ignore-errors
  (let ((methods (generic-function-methods #'test)))
    (when (and (eq (first methods) *the-method*)
               (null (cddr methods)))
      (acknowledge :generic-function-methods))))

(ignore-errors
  (when (eq (generic-function-name #'test) 'test)
    (acknowledge :generic-function-name)))

(defgeneric test2 (a b c &optional o &rest d &key k1 k2)
  (:method (a b c &optional o &rest d) 'foo))

(ignore-errors
  (when (equal (generic-function-argument-precedence-order #'test2)
	       '(a b c))
    (acknowledge :generic-function-argument-precedence-order-returns-required-arguments)))

(defclass test ()
  ((a :reader a)))

(ignore-errors
  (when (typep (method-function (first (generic-function-methods #'a))) 'function)
    (acknowledge :method-function)))

(ignore-errors
  (when (eq (method-generic-function (first (generic-function-methods #'a))) #'a)
    (acknowledge :method-generic-function)))

(ignore-errors
  (when (equal (method-lambda-list *the-method*) '(a b c))
    (acknowledge :method-lambda-list)))

(ignore-errors
  (when (equal (method-specializers (first (generic-function-methods #'a)))
               (list (find-class 'test)))
    (acknowledge :method-specializers)))

(ignore-errors
  (when (equal (method-qualifiers *the-method*) '(:around))
    (acknowledge :method-qualifiers)))

(ignore-errors
  (when (eq (accessor-method-slot-definition (first (generic-function-methods #'a)))
            (find 'a (class-direct-slots (find-class 'test))
                  :key #'slot-definition-name))
    (acknowledge :accessor-method-slot-definition)))

(defclass slot-class ()
  ((a :allocation :instance :initarg :a :initform (+ 1 1)
      :type integer :documentation "a")
   (b :allocation :class :initarg :b :initform (+ 2 2) :type integer
      :reader getb :writer setb)))

(unless (class-finalized-p (find-class 'slot-class))
  (finalize-inheritance (find-class 'slot-class)))

(ignore-errors
  (defparameter *a* (find 'a (class-slots (find-class 'slot-class))
                          :key #'slot-definition-name))
  (defparameter *b* (find 'b (class-direct-slots (find-class 'slot-class))
                          :key #'slot-definition-name))
  (acknowledge :slot-definition-name))

(ignore-errors
  (when (eq (slot-definition-allocation *b*) :class)
    (acknowledge :slot-definition-allocation)))

(ignore-errors
  (when (equal (slot-definition-initargs *a*) '(:a))
    (acknowledge :slot-definition-initargs)))

(ignore-errors
  (when (equal (slot-definition-initform *a*) '(+ 1 1))
    (acknowledge :slot-definition-initform)))

(ignore-errors
  (when (eql (funcall (slot-definition-initfunction *a*)) 2)
    (acknowledge :slot-definition-initfunction)))

(ignore-errors
  (when (eq (print (slot-definition-type *b*)) 'integer)
    (acknowledge :slot-definition-type)))

(ignore-errors
  (when (equal (slot-definition-readers *b*) '(getb))
    (acknowledge :slot-definition-readers)))

(ignore-errors
  (when (equal (slot-definition-writers *b*) '(setb))
    (acknowledge :slot-definition-writers)))

(ignore-errors
  (when (string= #-ecl (documentation *a* 't)
                 #+ecl (first (documentation *a* 't))
                 "a")
    (acknowledge :slot-definition-documentation)))

(ignore-errors
  (when (typep (slot-definition-location *a*) 'integer)
    (acknowledge :slot-definition-location)))
