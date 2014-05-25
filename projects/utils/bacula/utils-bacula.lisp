(defpackage :utils-bacula
  (:use :cl))

(in-package :utils-bacula)

(defclass bacula ()
  ((config-dir :initform #p "/etc/bacula/" :initarg nil)
   (dir :initarg :dir)
   (fd :initarg :fd)
   (sd :initarg :sd)
   (config-file :initarg :config-file)))

(defclass bacula-dir (bacula)
  ((config-file :initform "bacula-dir.conf")))
(defclass bacula-fd (bacula)
  ((config-file "bacula-fd.conf")))
(defclass bacula-sd (bacula)
  ((config-file "bacula-sd.conf")))
(defclass bacula-console (bacula)
  ((config-file :initform "bconsole.conf")))



(defvar *dir* (make-instance 'bacula-dir))
(defvar *fd* (make-instance 'bacula-fd))
(defvar *sd* (make-instance 'bacula-sd))

(defvar *bacula* (make-instance 'bacula :dir *dir* :fd *fd* :sd *sd*))


(defmethod setup ((dir bacula-dir)))
(defmethod setup ((fd bacula-fd)))
(defmethod setup ((sd bacula-sd)))

(defmethod setup ((bacula bacula))
  (let ((dir (bacula-director bacula))
	(fd (bacula-fd bacula))
	(sd (bacula-sd bacula)))
    (and (setup director)
	 (setup fd)
	 (setup sd))))

(defmethod setup )
