#!/opt/bin/sbcl --script
(load "build-abcl.lisp")
(build-abcl:build-abcl :clean t :full t)
