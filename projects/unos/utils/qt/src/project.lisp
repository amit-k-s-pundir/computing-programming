(defpackage :utils.qt
  (:use :utils))

(in-package :utils-qt)

(defclass qt-project (project))

(defmethod setup ((project qt-project))
  (let* ((pro-file (utils::s+ (project-name project) ".pro"))
	 )))

(defclass qmake-file ()
  ((sources :initform nil :initarg :sources :accessor sources)
   (headers :initform nil :initarg :headers :accessor headers)
   (target :initform nil :initarg :target :accessor target)
   (config :initform nil :initarg :config :accessor config)))


