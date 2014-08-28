(in-package :cl-user)

 (defpackage :sonu-utils-asd
   (:use :cl :asdf))

 (in-package :sonu-utils-asd)

(defsystem :sonu-utils
  :description "General *essential* utilities used by sonu (me)"
;  :serial t
  :depends-on (:alexandria
	       :cl-fad
	       :cl-ppcre
	       :cl-who
	       :cxml
	       :drakma
	       :hunchentoot
	       :iolib
	       :optima
	       :osicat
	       :parenscript
	       :postmodern)
  :components ((:file "packages")
	       (:file "file-utils")
	       (:file "os-utils")
	       (:file "project-utils")
	       (:file "sbcl-utils")
	       (:file "shell-utils")
	       (:file "string-utils")
	       ))
