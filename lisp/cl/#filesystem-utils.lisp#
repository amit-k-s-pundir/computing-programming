(defpackage :filesystem-utils
  (:use :cl-ppcre))

(in-package :filesystem-utils)

(defun append-to-file (file string)
  "Appends the string argument at the end of the given file. It creates the file
if it doesn't already exists."
  (with-open-file (s file :direction :output :element-type :default :if-exists
                     :append :if-does-not-exist :create)
    (format s "~&~A" string)))
