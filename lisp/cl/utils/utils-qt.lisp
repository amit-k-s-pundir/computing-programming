(in-package :utils)

(defmethod setup ((p qt-project) &optional dir-tree)
  (let ((f (p-))))
  )

(defclass qt-project (project)
  ((qmake :initarg :qmake :initorm nil :documentation "A qmake object
  encapsulating  the qmake options")))

(defclass qmake ()
  ((project :initarg :project)
   (sources :initarg :sources)
   (headers :initarg :headers)
   (target :initarg :target :initform (project-name project))))
