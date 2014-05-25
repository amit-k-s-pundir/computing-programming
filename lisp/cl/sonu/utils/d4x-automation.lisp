(defpackage :downloader
  (:use :cl :alexandria :cl-ppcre))

(in-package :downloader)

(defvar *work-dir* #p "/opt/.dwhelper/data/")

(defvar *urls-file* (merge-pathnames  #p "d4x_list.lisp" *work-dir*))

(defun download (&optional (urls-file *urls-file*))
  )
