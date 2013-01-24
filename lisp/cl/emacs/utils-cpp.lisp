(defpackage :utils-cpp
  (:use :cl :cl-ppcre))

(in-package :utils-cpp)

(defun parse-template (str)
  
  )

;; (template testTemplate (:s A :c B))
(defmacro template (type ; Class or a Function template?
		    name &rest args)
  (if (eq type "class")))
