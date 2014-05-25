(defpackage :com.pundir.sonu.automation.web
  (:use :cl :cl-ppcre))

(in-package :com.pundir.sonu.automation.web)

(defclass wget-download ()
  ((request :initarg :request :accessor :request)
   (response :initarg :response :accessor :response)
   (download-name :acessor :download-name)
   (url :initarg :url :accessor :url)
   (storage-file-path :accessor :storage-file-path)
   (line-number :accessor :line-number)
   (download-size :accessor :download-size)
   (downloaded-size :accessor :downloaded-size)))

(defvar *wget-downloads* '())

(defun finish-downloads (downloads)
  (loop for download in downloads
       do (finish-download download)))

(defmethod finish-download ((download wget-download))
  (if (< (downloaded-size download) (download-size download))
      (download-cmd download)))

(defun iterator (&optional (wget-logfile *wget-logfile*))
  )
(defun next-download (&optional (wget-logfile *wget-logfile*))
  
  )
