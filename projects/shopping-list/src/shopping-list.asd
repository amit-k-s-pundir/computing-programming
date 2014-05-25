(in-package :cl-user)

(defpackage :shopping-list-asd
  (:use :cl :asdf))

(in-package :shopping-list-asd)

(defsystem :shopping-list
  :serial t
  :version "1.0"
  :description "A shopping list to help manage the mine - and others - shopping."
  :components ((:file "packages")
		(:file "shopping-list"))
  :depends-on (:cl-ppcre
	       :cl-who
	       :hunchentoot
	       :optima
	       :parenscript
	       :postmodern))
