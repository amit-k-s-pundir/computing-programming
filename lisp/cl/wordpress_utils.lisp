(defun asdf-load-packages (packages)
  (loop for package in packages
	 do (asdf:oos 'asdf:load-op package) ))

(asdf-load-packages '("common-lisp" "project-utils"
										;					  :cl-who :cl-ppcre :parenscript :cl-fad :hunchentoot
					  ))

(defpackage "wp-utils"
  (:use "common-lisp" "project-utils"))

(defun set-up-wordpress-project (base-dir name)
  (set-up-project wp))
