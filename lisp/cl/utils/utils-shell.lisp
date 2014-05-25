(defpackage #:sonu.utils.shell
  (:nicknames "utils-shell")
  (:use :cl))

(in-package "utils-shell")

(defgeneric gen-file (file-type))

(defgeneric update (update-type doc))

(defclass document ()
  ((base-dir
    :initarg :base-dir
    :initform "."
    :accessor base-dir
    :documentation "The base directory where the document is
located.")
   (name
    :initform (error "The document name must be supplied.")
    :accessor name
    :documentation "The name of the document file to be updated.")
   (url
    :initform (error "The url to fetch the document has to be
supplied."))
   (target-dir
    :initarg :target-dir
    :initform "."
    :documentation "The directory where the document has to be
installed - if different from the base-dir")))

(use-package :cl-ppcre :utils)

(defmethod update ((x (eql :document)) (doc document))
  (with-dir (base-dir doc)
    (let* ((tmp-dir (make-unique-tmp-dir)))
      (and 
       (with-dir tmp-dir
	 (let* ((wget-options (format nil "-Nc -o ~A" logfile))
		(url (document-url doc)))
	   (wget wget-options url)
	   (if (compressed? url)
	       (decompress url))
	   (install doc)))))))

(defmethod install ((doc document))
  (let ((dir (install-dir doc)))
    (rsync '("-avz") '(dir))))

(defun compressed? (url)
  (if (cl-ppcre:scan "\.(tgz|gzip)" url)
      t
      nil))

(defun make-unique-tmp-dir (&optional (dir-name (symbol-name
  (gensym))))
  (and (mkdir dir-name)
       dir-name))

