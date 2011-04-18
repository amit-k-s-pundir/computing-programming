(defclass test-class (standard-class) ())

(defmethod validate-superclass
           ((class test-class)
            (superclass standard-class))
  t)

(acknowledge-function "COMPUTE-CLASS-PRECEDENCE-LIST")

(defmethod compute-class-precedence-list :after
  ((class test-class))
  (acknowledge :finalize-inheritance-calls-compute-class-precedence-list))

(when (mop-function-p "COMPUTE-DEFAULT-INITARGS")
  #+allegro
  (acknowledge :compute-default-initargs-allegro)
  #-allegro
  (acknowledge :compute-default-initargs)
  #-allegro
  (defmethod compute-default-initargs :after
    ((class test-class))
    (acknowledge :finalize-inheritance-calls-compute-default-initargs))
  #+allegro
  (defmethod compute-default-initargs :after
    ((class test-class) (cpl t) (direct t))
    (acknowledge :finalize-inheritance-calls-compute-default-initargs)))

(defclass test-object (standard-object) ()
  (:metaclass test-class))

(unless (class-finalized-p (find-class 'test-object))
  (finalize-inheritance (find-class 'test-object)))
