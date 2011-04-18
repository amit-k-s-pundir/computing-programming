(in-package :cl-user)

(require 'asdf)
(require 'cmp)

(setf asdf:*central-registry*
	  (list* '*default-pathname-defaults*
			 #p "/opt/lisp/cl/clbuild/systems/"
			 #p "/home/sonu/cl'asdf:load-op package/systems/"
			 #p "/usr/share/common-lisp/systems/"
			 asdf:*central-registry*))

;;(asdf:make-build :asdf-binary-locations :type :fasl)

;;(asdf:oos 'asdf:load-op :asdf-binary-locations)
;;(asdf:oos 'asdf:load-fasl-op :cffi)

(defun asdf-load-packages (packages)
  (loop for package in packages
	 do (asdf:oos 'asdf:load-fasl-op package)))

;(defun asdf-load-packages (packages)
 ;(loop for package in packages
;	 do (asdf:make-build package :type :fasl)
;do (asdf:make-build package :type :program :epilogue-code )
	; do (load (concatenate 'string "/opt/lisp/cl/clbuild/source/"(string-downcase (symbol-name package)) ".fas"))
;))

(asdf-load-packages '(:cl-who :cl-ppcre :parenscript :cl-fad :cffi))

;; Here is another approach for loading libraries and defining a package to use
;; those libraries.  This is taken from the *Official Parenscript Tutorial*.

;;  After installing the prerequisite libraries, let's load them.

;; (dolist (x '(:hunchentoot :cl-who :parenscript :cl-fad))
;;   (asdf:oos 'asdf:load-op x))
    

;; Next let's define a package to hold the example code

;; (defpackage "PS-TUTORIAL"
;;   (:use "COMMON-LISP" "HUNCHENTOOT" "CL-WHO" "PARENSCRIPT" "CL-FAD"))

;; (in-package "PS-TUTORIAL")
    

(ps (defun greeting-callback ()
			   (alert "hello, world")))
