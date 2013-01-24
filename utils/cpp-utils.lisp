(defpackage :cpp-utils)

(in-package :cpp-)

;;;; Defines an alias for a c type.        
(defmacro defctype (type-name c-type)
  `(defvar ,type-name ,c-type))

(defmacro defcclass (name (superclasses)
                    (slots))
  `(defclass ,name `(,@superclasses)
     `(,@slots)
     (:metaclass cpp-metalevel-class))
  )

(defmacro defcfun (name . args)
  )

(defclass cpp-metalevel-class (standard-class))
