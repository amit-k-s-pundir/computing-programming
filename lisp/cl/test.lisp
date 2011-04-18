(defpackage "PS-TUTORIAL"
  (:use "COMMON-LISP" "CL-WHO" "PARENSCRIPT" "CL-FAD"))
(cl-who:with-html-output-to-string (str)
  (:html
   (:head (:title "Test page"))
   (:body
	(dotimes (x 10)
	  (cl-who:htm (:p "Text"))))))

(user-homedir-pathname)
(format t "~<~A~:>" '(sonu))
