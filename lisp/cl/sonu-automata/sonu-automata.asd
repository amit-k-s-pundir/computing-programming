;;;; sonu-automata.asd

(asdf:defsystem #:sonu-automata
  :serial t
  :description "Describe sonu-automata here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :depends-on (#:drakma
               #:cl-ppcre
               #:cl-fad
               #:alexandria)
  :components ((:file "package")
               (:file "sonu-automata")))

