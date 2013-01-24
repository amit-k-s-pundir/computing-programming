(defun ql-load (&rest systems)
  (dolist (system systems)
    (ql:quickload system)))

(ql-load "alexandria" "cl-ppcre")

(defpackage :utils-quickload
  (:use :cl :alexandria :cl-ppcre))

(in-package :utils-quickload)
