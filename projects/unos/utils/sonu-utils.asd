(in-package :cl-user)

(defpackage :sonu-utils-asd
  (:use :cl :asdf))

(in-package :sonu-utils-asd)

(defsystem :sonu-utils
  :serial t
  :version "1.0"
  :description "General utilities that will be used by sonu (me) for
  use in my *personal* code."
  :depends-on (:sonu
	       :alexandria
	       :cl-fad
	       :cl-ppcre
	       :hunchentoot
	       :optima))
