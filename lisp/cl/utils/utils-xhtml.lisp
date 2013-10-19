(defpackage :html-utils
  (:use  :cl :cl-ppcre :cl-who))

(in-package :html-utils)

(defclass table (element)
  ((rows :initform nil :initarg :rows)
   (columns :initform nil :initarg :columns))
  )

(defmethod gen ((table table))
  (with-html-output (*http-stream*))
  )
