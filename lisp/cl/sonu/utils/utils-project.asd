(asdf:defsystem #:utils-project
  :version "0.1"
  :serial t
  :components ((:file "utils-project.lisp"))
  :depends-on (:sb-posix))
