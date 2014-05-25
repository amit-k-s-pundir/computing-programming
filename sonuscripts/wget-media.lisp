#!/opt/sbcl/bin/sbcl --script

(in-package #:cl-user)
(load "/home/sonu/.sbclrc")

;; (defpackage #:sonu-utils
;;   (:use :cl :cl-ppcre :cl-fad :optima :sonu.utils))

(in-package :sonu-utils)

(defmethod download ((tool (eql :wget)) (x (eql :media)) url &optional
							       download-name
							       download-dir
							       finished-downloads-dir
							       logfile-dir
							       logfile-name
							       user-agent)
  (let* (;(url (pop sb-ext:*posix-argv*))
	 (download-name (or download-name (car (last (cl-ppcre:split
						      "\\/"
						      url)))))
	 (logfile-dir (or logfile-dir "/opt/downloads/wget-log"))
	 (logfile-name (or logfile-name (concatenate 'string
						     "wget-log-" download-name ".log")))
	 (logfile (concatenate 'string logfile-dir "/" logfile-name))
	 (directory-prefix (or download-dir
			       "/mnt/nfs/opt/downloads/latest/today"))
	 (download (concatenate 'string directory-prefix "/"
							       download-name))
	 (finished-downloads-dir (or finished-downloads-dir
							       (concatenate
								'string
							       directory-prefix
							       "/" "finished")))
	 (user-agent (or user-agent "Mozilla/5.0 (X11; Linux i686; rv:26.0) Gecko/20100101Firefox/26.0"))
	 (cmd (format nil "wget -c -N -o ~a -U ~s -P ~a ~
--header=\"Accept: */*\" --header=\"Connection: Keep-Alive\" ~a && mv ~a ~a"
							       logfile
							       user-agent
							       directory-prefix
							       url
							       download
							       finished-downloads-dir
							       )))
    (format t "~a" cmd)
    (sonu-utils::! cmd)
					;    (when (download-finished-p)
					;      (sonu-utils::! (format nil "mv ~a ~a" download
					;							       finished-downloads-dir)))
    ))

(defun main (&optional (posix-argv sb-ext:*posix-argv*))
  (let ((url (cadr posix-argv)))
    (download :wget :media url)))

(main sb-ext:*posix-argv*)
