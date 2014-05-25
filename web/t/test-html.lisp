(dolist (s '("cl-who" "cl-ppcre" "optima" "parenscript"))
  (ql:quickload s))

(defpackage :test-html
  (:use :cl :cl-who :cl-ppcre :optima :parenscript))

(in-package :test-html)

(defparameter *file* #p "/home/sonu/workspace/programming/web/t/test-html.html")

(with-open-file (s *file* :direction :output :if-exists :supersede
  :if-does-not-exist :create)
  (with-html-output (s nil :prologue t) (htm
			 (:html (:div) (:span))) ))

(defun shopping-list (&optional rows cols)
  (with-open-file (s *file* :direction :output :if-exists :supersede)
    (with-html-output (s nil :prologue "<!DOCTYPE html>" :indent t)
      (:html (:head
	      (:link :rel "stylesheet" :href "test-html-style.css"))
	     (:body
	      (:div :class "ViewPanel" "Testing"
		    (:table :class "TestTable")))))))


(shopping-list)
