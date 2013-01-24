;;;; Some utilities for setting up and then maintaing a new project.

(defpackage :project
  (:use :common-lisp :sonu-utils))

(in-package :project)

(defmethod setup (proj project)
  (with-dir (project-dir proj)
    (create-dir-tree proj-dir-tree)))

(defclass project ()
  ((name :initarg name)
   (dir :initarg dir :initform nil)
   (url :initarg url :initform nil)
   (dir-tree :initarg dir-tree :initform nil)))
