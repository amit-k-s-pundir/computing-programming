(defpackage :emacs-utils
  (:use :cl :cl-ppcre :cl-fad :cl-who ))

(in-package :emacs-utils)

(defun ql-load-packages (packages)
  (loop for package in packages
       do (ql:quickload package)))
