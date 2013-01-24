(defpackage #:utils-apache
  (:use :cl))

(in-package #:utils-apache)

(defgeneric sanitize (tag tag)
  (:documentation "Sanitizes the given tag."))

(defmethod sanitize ((html (eql 'link)))
  )
