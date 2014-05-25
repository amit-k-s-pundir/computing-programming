(in-package :cl-user)

;; (setf asdf:*central-registry*
;; 	  (list* '*default-pathname-defaults*
;; 			 #p "/opt/lisp/cl/clbuild/systems/"
;; 			 #p "/home/sonu/cl/systems/"
;; 			 #p "/usr/share/common-lisp/systems/"
;; 			 #p "/home/sonu/workspace/programming/lib/cl/"
;; 			 asdf:*central-registry*))

;; ;;(asdf:oos 'asdf:load-op :asdf-binary-locations)

;; (defun asdf-load-packages (packages)
;;   (loop for package in packages
;; 	 do (asdf:oos 'asdf:load-op package) ))

;; (asdf-load-packages '(:cl-who :cl-ppcre :parenscript :cl-fad :hunchentoot))

(defun ql-load-packages (packages)
  (loop for package in packages
	 do (ql:quickload package) ))

(ql-load-packages '( "cl-ppcre" "cl-fad" "cl-who" "parenscript" "hunchentoot"))

;; Here is another approach for loading libraries and defining a package to use
;; those libraries.  This is taken from the *Official Parenscript Tutorial*.

;;  After installing the prerq equisite libraries, let's load them.

;; (dolist (x '(:hunchentoot :cl-who :parenscript :cl-fad))
;;   (asdf:oos 'asdf:load-op x))
    

;; Next let's define a package to hold the example code

;; (defpackage "PS-TUTORIAL"
;;   (:use "COMMON-LISP" "HUNCHENTOOT" "CL-WHO" "PARENSCRIPT" "CL-FAD"))

;; (in-package "PS-TUTORIAL")
    

