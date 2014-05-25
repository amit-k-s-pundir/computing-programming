(in-package :cl-user)

(defpackage :shopping-list
  (:use :cl :cl-ppcre :cl-who :optima :parenscript :postmodern)
  (:export #:add-shopping-request
	   #:remove-shopping-request
	   #:get-shopping-list
	   #:register-shopping-item
	   #:remove-shopping-item))
