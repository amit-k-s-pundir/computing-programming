;(asdf-load-packages '(:asdf-binary-locations :cl-who :cl-ppcre :parenscript :cl-fad :mcclim ))

(defpackage "utils"
;  (:use :cl :asdf :parenscript :cl-who :cl-ppcre :cl-fad :clim :clim-lisp)
;  (:use  :parenscript :cl-who :cl-ppcre :cl-fad )
  (:use :cl )
;  (:export #:app-main))
  (:export #:app-main))

(in-package "utils")

;; (define-application-frame superapp ()
;;   ()
;;   (:pointer-documentation t)
;;   (:panes
;;     (app :application :display-time t :height 300 :width 600)
;;     (int :interactor :height 200 :width 600))
;;   (:layouts
;;     (default (vertically () app int))))

;; (defun app-main ()
;;   (run-frame-top-level (make-application-frame 'superapp)))
;; (define-superapp-command (com-quit :name t) ()
;;   (frame-exit *application-frame*))
;; (define-presentation-type name-of-month ()
;;   :inherit-from 'string)
;; (define-presentation-type day-of-month ()
;;   :inherit-from 'integer)
;; (define-superapp-command (com-out :name t) ()
;;   (with-output-as-presentation (t "The third month" 'name-of-month)
;;     (format t "March~%"))
;;   (with-output-as-presentation (t 15 'day-of-month)
;;     (format t "fifteen~%")))
;; (define-superapp-command (com-get-date :name t)
;;     ((name 'name-of-month) (date 'day-of-month))
;;   (format (frame-standard-input *application-frame*)
;;   "the ~a of ~a~%" date name))

;; (app-main )

(defmacro define-lisp-shell-util (util &rest keys)
  `(defun ,util (args &rest keys)
	 (sb-ext:run-program (string-downcase (symbol-name ',util))
						 args :search t :wait t :output *standard-output*)))

(defun make-directory-tree (base-dir dir-tree)
  (if (not (directory-p base-dir))
		(error "~<The first argument ~S should be a valid pathname specifier for a ~
directory:>" '( base-dir)))
  (if (or (symbolp dir-tree)
		  (stringp dir-tree))
		(create-file (join-dir-file base-dir dir-tree))
		(let ((base-dir (join-dir-dir base-dir (car dir-tree))))
		  (ensure-directories-exist base-dir)
		  (if (not (null (cdr dir-tree)))
			  (mapcar (lambda (x)
						(make-directory-tree base-dir x)) (cdr dir-tree))))))

(defun create-file (namestring)
  (with-open-file (s namestring :direction :output :if-exists :append
					 :if-does-not-exist :create)))

(defun directory-p (directory)
  (and (pathname directory) 
	   (not (string= (directory-namestring directory) ""))))

(defun join-dir-file (dir file)
  (pathname (concatenate 'string (namestring dir) (namestring file))))

(defun join-dir-dir (base-dir rel-dir)
  (pathname (concatenate 'string (namestring base-dir) (namestring rel-dir))))


