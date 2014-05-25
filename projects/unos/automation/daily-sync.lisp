(in-package :cl-user)

(defpackage #:com.sonu.automation.sync
  (:use :cl :cl-ppcre))

(in-package #:com.sonu.automation.sync)

;; The main storage with all other storages (*storage-n* with n>0) will
;; send their data regularly (daily?) to it.
(defvar *storage-0*)

(defun sync-storage (storage-topography parent)
  (flet ((pull (storage-topography parent)
	   (let ((children (cdr storage-topography)))
	     (if (null children)
		 (let ((fn (cdar storage-topography)))
		   (funcall fn parent))
		 (let ((parent storage-topography))
		   (dolist (storage-topography children)
		     (sync-storage storage-topography parent)
		     (funcall fn parent))))))
	 (push (storage-topography parent)
	   (let ((src (caar storage-topography)))
	     (loop for tree in (cdr storage-topography)
		  with dest = (caar tree)
		  with children = (cdr tree)
		  do (progn (sync src dest)
			    (loop for child-tree in (cdr tree)
				 do (push child-tree))))))
		  
	   (mapcar (lambda (parent  ))

(defvar *storage-0* "/mnt/nas/storage-0")
(defvar *storage-1* "/")
(defvar *storage-2* "/mnt/nas/storage-2")
(defvar *fn-0* (lambda () t))
(defvar *fn-1* (function sync-filesytem/linux))
(defvar *fn-2* (function sync-filesytem/linux))

(defvar *storage-topography* '((storage-0 fn-0) ((storage-1 fn-1))
			     ((storage-2 fn-2))))

(sync-storage *storage-topography*)

(defun sync-filesytem/linux (dest)
  (sync ("/home/sonu/workspace") ("/home/sonu") ("/opt/downloads")
  ("/opt")))

(defun sync (&rest args)
  (loop for (source . dest) in args
       do (rsync options source dest))) 

(defun post-order-traverse (tree, visit)
  (

(defun sync-videos ()
  (let ((src-dir "/opt/downloads/latest/today/finished")
	(dest-dir "/mnt/nas1/opt/downloads/latest/today/"))
    (sync src-dir dest-dir)))

(defun sync (src-dir dest-dir) 
  (! rsync "-avz" src-dir dest-dir))

;;(defmethod sync ((
