(in-package :sonu-utils)

;; (setf asdf:*central-registry*
;; 	  (list* '*default-pathname-defaults*
;; 			 #p "/opt/lisp/cl/clbuild/systems/"
;; 			 #p "/home/sonu/cl/systems/"
;; 			 #p "/usr/share/common-lisp/systems/"
;; 			 asdf:*central-registry*))

;; (asdf:oos 'asdf:load-op :asdf-binary-locations)

;; (defun asdf-load-packages (packages)
;;   (loop for package in packages
;; 	 do (asdf:oos 'asdf:load-op package) ))

;; (asdf-load-packages '(:asdf-binary-locations :cl-who :cl-ppcre :parenscript :cl-fad))
;(asdf-load-packages '(:asdf-binary-locations :cl-who :cl-ppcre :parenscript :cl-fad :mcclim ))

;; (defpackage :utils-project
;; ;  (:use :cl :asdf :parenscript :cl-who :cl-ppcre :cl-fad :clim :clim-lisp)
;;   (:use :cl :alexandria :cl-fad :cl-ppcre :utils-sbcl)
;;   ;  (:export #:app-main)
;;   )

;(in-package :utils-project)

(defclass project ()
  ((name :initform nil :accessor project-name
		 :initarg :name)
   (base-dir :initform nil :accessor project-base-dir
			 :initarg :base-dir)
   (dir-tree :initform nil :initarg
      :dir-tree :accessor project-dir-tree)))
 
(defmethod setup ((project project))
  (make-dir-tree  (or (project-dir-tree project)
                            `(,(project-name project) "notes.org" "README"("src") ("doc")
                                ("examples")
                                ("test") ("conf"))) (project-base-dir project)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq x (make-instance 'tc-project )))
;; (project-base-dir x)
;; (setq y (make-instance 'project))
;; (project-base-dir y)
;; (slot-value x 'base-dir)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
