;;(in-package :asdf)

(defpackage :sample-asdf
  (:use :cl :asdf))

(in-package :sample-asdf)

(defsystem "hello-lisp"
    :description "hello-lisp: a sample Lisp system."
    :version "0.2.1"
    :author "Joe User <joe@example.com>"
    :licence "Public Domain"
    :components ((:file "packages")
                 (:file "macros" :depends-on ("packages"))
                 (:file "hello" :depends-on ("macros"))))
