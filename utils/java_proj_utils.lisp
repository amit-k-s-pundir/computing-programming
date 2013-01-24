(defpackage java-proj-utils
  (:use :common-lisp :cl-ppcre :parenscript :cl-who :cl-fad))

(defclass project ()
  )

(defclass javaee-project (project)
  ((name :initarg :name)
   (base-dir :initform (current-dir) :initarg :base-dir)))

(defmethod setup-javaee-project (proj javaee-proj))
