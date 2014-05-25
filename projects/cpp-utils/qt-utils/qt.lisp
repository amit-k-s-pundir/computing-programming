(defpackage :qt
  (:use :cl))

(in-package :qt)

(defgeneric gen-source (source)
  "Generates the SOURCE from SOURCE."
  )

(defclass file (cpp::file)
  )
(defmethod gen-source ((file source))
  )

(defun gen-qt-skeletal-file )
(defun gen-panel ())
