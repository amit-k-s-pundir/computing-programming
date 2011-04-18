(defpackage :timesheet
  (:use :cl :cl-who :hunchentoot :parenscript))

(in-package :timesheet)

(with-html-output (*standard-output* nil :indent t)
  (:html
   (:head
	(:title "Timesheet"))
   (:body
	(:p "This is a generic Timesheet."))))

(defmacro standard-page ((&key title) &body body)
  `(with-html-output-to-string (*standard-output* nil :prologue t :indent t)
	 (:html :xmlns "http://www.w3.org/1999/xhtml"
			:xml\:lang "en"
			:lang "en"
			(:head
			 (:meta :http-quiv "Content-Type" :content "text/html;charset=utf-8")
			 (:title ,title)
			 (:link :type "text/css" :rel "stylesheet" :href "/blueprint.css"))
			(:body
			 (:div :id "header"
				   (:img :src "/logo.jpg" :alt "Timesheet" :class "logo")
				   (:span :class "strapline" "Edit the Timesheet if you need to."))
			 ,@body))))

;; (ps
;;   (defun foobar (a b)
;; 	(return (+ a b))))
(with-open-file (s #p "/home/sonu/workspace/programming/web/webapplications/test_app/temp.html"
				   :direction :output :if-exists :overwrite :if-does-not-exist :create )
  (let ((html (astring :fill-pointer 0)))
	(format html 
			(standard-page ( :title "timesheet")))))

(defun astring (&optional str length &rest keys)
  (apply  #'make-array length :element-type 'character keys))

