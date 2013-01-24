(dolist (x `(:hunchentoot :cl-who :parenscript :cl-fad))
  (ql:quickload x))

(defpackage :gen-view
  (:use :common-lisp :hunchentoot :cl-who :parenscript :cl-fad))

(in-package :gen-view)

(setf *js-string-delimiter*  #\")

;(setq file-path (merge-pathnames 
