;;;; This module runs daily to synchronize (currently using rsync) the
;;;; relevant directories with those on some backup volume(s).

(in-package :utils)

(defclass syncable ()
  ((source :initform nil :initarg :source)
   (target :initform nil :initarg :target)))

(defmethod sync ((x syncable))
  (let ((source (syncable-source x))
	(target (syncable-target x)))
    (! (format nil "rsync -avz ~a ~a" source target))))

(defun sync (syncables)
  (loop
       for syncable in syncables
       do (sync syncable)))
