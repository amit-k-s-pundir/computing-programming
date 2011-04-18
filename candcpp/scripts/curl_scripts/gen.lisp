(defpackage :gen
  (:use :common-lisp))

(defun gen-cpp-program (includes functions types main)
  (gen-includes includes)
  (gen-functions functions)
  (gen-types types)
  (gen-main main))

(defmacro gen-looper (name &rest args)
  `(defun ,name ,args
	 (dolist (arg args)
	   )))
