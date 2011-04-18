(defpackage "test" (:use :cl :asdf))
(in-package "test")
(defun fun1 ()
  (+ (fun2) 5))

(defun fun2 ()
  2)


