(in-package :cl-user)

(defpackage :utils-cpp-asd
  (:use :cl :asdf))

(defsystem :utils-cpp
  :version "1.0"
  :description "Utilities to help generate cpp code"
  :serial t
  :components ((:file "packages")
	       (:file "general")))
