(dolist (x '(:cl-who :cl-fad :hunchentoot :parenscript))
  (ql:quickload x))

(defpackage "HTML-UTILS"
  (:use "COMMON-LISP" "CL-FAD" "CL-WHO" "HUNCHENTOOT" "PARENSCRIPT"))

(in-package "HTML-UTILS")

(defun gen-table (rows cols &optional id caption)
  (with-html-output (*http-stream*)
    (loop for row from 0 to rows
         do (htm (
