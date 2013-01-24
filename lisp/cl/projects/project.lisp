(defpackage #:project
  (:use :cl :sonu-dir-utils))
(in-package #:project)

(defclass project ()
  ((name :initarg :name)
   (base-dir :initarg :base-dir :initform (cwd))
   (dir-tree :initarg :dir-tree :initorm `(project-name "package.lisp"
                                                        (,src) (,lib)
                                                        (,test) (,build)
                                                        (,doc)) nil)
   ))

(defmethod create-project (project project)
  (with-dir (project-base-dir project)
    (unless (null project-dir-tree)
      (create-dir-tree project-dir-tree)
      )))
