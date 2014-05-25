(in-package :utils)

(defclass doc ()
  ((download-url :initform nil :initarg :download-url :accessor download-url)
   (base-dir :initform nil :initarg :base-dir :accessor base-dir)
   (install-dir :initform nil :initarg :install-dir :accessor install-dir)
   (cmd :initform :cmd :initarg :cmd :accessor cmd)))

(defmethod update ((x (eql :docs)) (doc doc))
  (let* ((download-url (download-url doc))
	(install-dir (install-dir doc))
	(base-dir (base-dir doc))
	 (cmd (or (cmd doc)
		  (format nil "wget -EN -ckp ~a" download-url))))
    (with-dir base-dir
      (format t "In dir ~a ~%" base-dir)
      (format t "cmd is ~a ~%" cmd)
      (! cmd))))

;; (defclass boost-doc (doc)
;;   ((base-dir #p "/home/sonu/programming_docs/candcpp/boost/")))

(setf spirit-doc (make-instance 'doc :download-url
				"http://boost-sandbox.sourceforge.net/libs/spirit/doc/html/"
				:base-dir #p
				"/home/sonu/programming_docs/candcpp/boost/spirit/"
				:install-dir nil
				:cmd (format nil "wget -EN -ckpr -l1 \\
-np http://boost-sandbox.sourceforge.net/libs/spirit/doc/html/")))

(setf xpressive-doc (make-instance 'doc :download-url
				   "http://boost-sandbox.sourceforge.net/doc/html/xpressive.html"
				   :base-dir #p
				   "/home/sonu/programming_docs/candcpp/boost/xpressive/"
				   :install-dir nil
				   :cmd (format nil "wget -EN -ckpr \\
-l1 -np http://boost-sandbox.sourceforge.net/doc/html/xpressive.html")))

;; (defclass spirit-doc (boost-doc)
;;   ((base-dir :initform (merge-pathnames base-dir "spirit/"))
;;    (install-dir :initform nil)
;;    (download-url :initform
;; 		 "http://boost-sandbox.sourceforge.net/libs/spirit/doc/html/"
;; 		 :initarg :download-url)
;;    (cmd :initform (format nil "wget -EN -ckpr -l1 -np ~a"
;; 			  download-url) :initarg :cmd)))

;; (defclass xpressive-doc (boost-doc)
;;   ((base-dir :initform (merge-pathnames base-dir "xpressive/"))
;;    (install-dir nil)
;;    (download-url :initform
;; 		 "http://boost-sandbox.sourceforge.net/doc/html/xpressive.html"
;;   :initarg :download-url)
;;    (cmd :initform (format nil "wget -EN -ckpr -l1 -np ~a"
;; 			  download-url) :initarg :cmd)))

