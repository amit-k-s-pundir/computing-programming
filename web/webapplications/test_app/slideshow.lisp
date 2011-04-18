(dolist (x '(:hunchentoot :cl-ppcre :cl-who :parenscript :cl-fad))
  (asdf:oos 'asdf:load-op x))

(defpackage "ps-tutorial"
  (:use "COMMON-LISP" "HUNCHENTOOT"  "CL-PPCRE" "CL-WHO" "PARENSCRIPT" "CL-FAD"))

(in-package "ps-tutorial")

(setf *js-string-delimiter* #\")

(setq *server* (make-instance 'acceptor :port 8080))
(start *server*)

(define-easy-handler (turtorial1 :uri "/tutorial1") ()
  (with-html-output-to-string (s)
	(:html
	 (:head (:title "Parenscript tutorial: First example"))
	 (:body (:h2 "Parenscript tutorial: First example")
			"Please click the link below." :br
			(:a :href "#" :onclick (ps (alert "Hello World"))
				"Hello World")))))

(define-easy-handler (tutorial2 :uri "/tutorial2") ()
  (with-html-output-to-string (s)
	(:html
	 (:head
	  (:title "Parenscript tutorial: Second examle")
	  (:script :type "text/javascript"
			   (str (ps
					  (defun greeting-callback ()
						(alert "Hello World."))))))
	 (:body
	  (:h2 "Parenscript Tutorial: Second example")
	  (:a :href "#" :onclick (ps (greeting-callback))
		  "Hello World.")))))
