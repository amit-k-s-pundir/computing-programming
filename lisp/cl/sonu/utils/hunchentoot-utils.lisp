;;;; Utilities for automating the task of deploying hunchentoot web server.
(ql:quickload "cl-fad")

(defpackage :utils-hunchentoot
  (:use :cl :cl-fad))

(in-package :utils-hunchentoot)

;; Generate an appropriate apache.conf file.
;; (gen-apache-conf-file &optional (file-name "apache.conf") (dir #p "./") ->
;; apache-conf-file
;; file-name: (pathname?) : the name of the conf file to be generated.
;; dir : (pathname?) : the dir where the generated conf file is to be
;; placed. Defaults to the current directory.
;; apache-conf-file : (string?) : the name of the file generated
(defun gen-apache-conf-file (&optional (filename "apache.conf") (dir-pathname #p "./"))
  (with-dir dir
    (let ((file (merge-pathnames (pathname filename) dir-pathname))))
    (with-open-file (s file :direction :output :if-exists :append
                       :if-does-not-exist :create)
      ))
  )
