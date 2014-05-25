;;;; init-sbcl.asd

(asdf:defsystem #:init-sbcl
  :serial t
  :description "Describe init-sbcl here"
  :author "sonu pundir"
  :license "Specify license here"
  :depends-on (#:sonu.utils
               #:alexandria
               #:cl-fad
               #:cl-ppcre
               #:cl-who
               #:cxml
               #:drakma
               #:hunchentoot
               #:optima
               #:osicat
               #:parenscript)
  :components ((:file "package")
               (:file "init-sbcl")))

