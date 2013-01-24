;; (defpackage :utils
;;   (:use :cl :cl-ppcre))

(in-package :utils)

(defgeneric update (x))

(defclass target ()
  ((base-dir :initform "." :accessor base-dir :initarg :base-dir)
   (work-dir :initform "." :accessor work-dir :initarg :work-dir)
   (config-cmd :initform "./configure" :accessor config-cmd :initarg :config-cmd)
   (archive-update-cmd :initform "git pull" :accessor archive-update-cmd :initarg :archive-update-cmd)
   (build-cmd :initform "make" :accessor build-cmd)
   (install-cmd :initform "make install" :accessor install-cmd)))

(setq x1 5)

(defmethod update ((x target))
  (let* ((work-dir (work-dir x))
	 (archive-update-cmd (archive-update-cmd x))
	 (config-cmd (config-cmd x))
	 (build-cmd (build-cmd x))
	 (install-cmd (install-cmd x))
	 (cmd (format nil "~A ~ A ~A ~A" archive-update-cmd config-cmd
		      build-cmd install-cmd)))
    (break "The value of cmd is: ~A" cmd)
    (with-dir work-dir
      ;(utils::run-shell-cmd cmd)
      (format t "The command generated is the following: ~A" cmd)
      )))

(make-instance 'target)

(defmethod update ((x eql 'sbcl))
  (let ((work-dir (target-base-dir t)))
    (with-dir work-dir
      (let ((cmd (format nil "git pull && sh sb")))))))


(update 'sbcl)
