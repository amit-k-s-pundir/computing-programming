(defpackage :utils-perl
  (:use :cl :cl-ppcre))

(in-package :utils-perl)

;(defgeneric gen-perl (x &optional includes script?))
(defgeneric gen-perl (x))

(defun gen-default-include-str (includes)
  (let ((include-str ""))
    (loop for included in includes
       do (setq include-str (concatenate 'string include-str (format
  nil
  "use ~A;~%" included))))
    include-str))

(defmethod gen-perl ((x (eql :header)) &optional (includes '())
					 (script? t))
  (let* ((include-str (gen-default-include-str includes))
	 (header (format nil "~@[#!/usr/bin/perl -w; ~%~A~& ~]"
			 script? include-str)))
    header))

(defmethod gen-perl ((x (eql :footer))))
