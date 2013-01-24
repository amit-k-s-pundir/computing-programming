(defpackage :utils-sonu
  (:use :cl :cl-ppcre))

(in-package :utils-sonu)

(defmethod clean ((tag eql :head) (header))
  (let ((fb-s "xmlns:fb=\"http://www.facebook.com/2008/fbml\"")
	(og-s "xmlns:og=\"http://ogp.me/ns#\""))
    ))
