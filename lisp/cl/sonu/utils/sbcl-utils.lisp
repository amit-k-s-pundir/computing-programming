;(asdf-load-packages '(:asdf-binary-locations :cl-who :cl-ppcre :parenscript :cl-fad :mcclim ))

;; (defpackage :utils
;; ;  (:use :cl :asdf :parenscript :cl-who :cl-ppcre :cl-fad :clim :clim-lisp)
;; ;  (:use  :parenscript :cl-who :cl-ppcre :cl-fad )
;;   (:use :cl )
;; ;  (:export #:app-main))
;;   ;(:export #:app-main)
;;   )

(in-package :sonu-utils)

;; Defines a lisp utility ( a function) that is a wrapper for a native program
;; of the same name.
;; For instance, (wget '("c" "N" "http://www.google.com")) would be same as
;; running 'wget -Nc http://www.google.com' from the terminal.mb  
(defmacro defprog (util &rest keys)
  `(defun ,util (args &rest keys)
     (sb-ext:run-program (string-downcase (symbol-name ',util))
			 args :search t :wait t :output *standard-output*)))

;; (defun make-directory-tree (base-dir dir-tree)
;;   (if (not (directory-p base-dir))
;; 		(error "~<The first argument ~S should be a valid pathname specifier for a ~
;; directory:>" '( base-dir)))
;;   (if (or (symbolp dir-tree)
;; 		  (stringp dir-tree))
;; 		(create-file (join-dir-file base-dir dir-tree))
;; 		(let ((base-dir (join-dir-dir base-dir (car dir-tree))))
;; 		  (ensure-directories-exist base-dir)
;; 		  (if (not (null (cdr dir-tree)))
;; 			  (mapcar (lambda (x)
;; 						(make-directory-tree
;;   base-dir x)) (cdr dir-tree))))))
(defun make-dir-tree (dir-tree &optional (base-dir "."))
  (cond ((stringp dir-tree)
         (let* ((pathname (concatenate 'string
                                       (or
                                        (cl-fad::directory-pathname-p
                                         base-dir)
                                        (concatenate 'string base-dir "/")) dir-tree)))
           (create-file pathname)))
        ((listp dir-tree)
         (let* ((pathname (concatenate 'string (or
                                                (cl-fad::directory-pathname-p
                                                 base-dir)
                                                (concatenate 'string
                                                             base-dir "/")) (dirname (car dir-tree))))
                (base-dir pathname))
           (ensure-directories-exist pathname)
           (mapcar (lambda (dir-child)
                     (make-dir-tree dir-child pathname)) (cdr
                                                          dir-tree))))))

(defun dirname (string)
  (or (cl-fad::directory-pathname-p string)
      (concatenate 'string string "/")))

(defun create-file (namestring)
  (with-open-file (s namestring :direction :output :if-exists :append
					 :if-does-not-exist :create)))
(defun touch (file)
  (create-file file))

(defun directory-p (directory)
  (and (pathname directory) 
	   (not (string= (directory-namestring directory) ""))))

(defun join-dir-file (dir file)
  (pathname (concatenate 'string (namestring dir) (namestring file))))

(defun join-dir-dir (base-dir rel-dir)
  (pathname (concatenate 'string (namestring base-dir) (namestring rel-dir))))

;; Goes in the dir, executes the shell cmd and then returns to the original dir.
(defmacro with-dir-shell-cmd (dir cmd)
  (let ((od (sb-posix:getcwd)))
    (unwind-protect
         (progn
           (sb-posix:chdir dir)
           (run-shell-cmd cmd))
      (sb-posix:chdir od))))

;; (run-shell-cmd "gvim")
(defun run-shell-cmd (cmd)
  (let ((prog "/bin/bash")
        (args  `("-c" ,cmd)))
    (sb-ext:run-program prog args  :search t :wait t :output
                        *standard-output*)))

(defmacro define-lisp-shell-util (util &rest keys)
  `(defun ,util (args &rest keys)
     (sb-ext:run-program (string-downcase (symbol-name ',util)) args
                         :search t :wait t :output
  *standard-output*)))

;; (define-lisp-shell-util ls )
;; (define-lisp-shell-util wget )
;; (define-lisp-shell-util aptitude)
;; (define-lisp-shell-util touch)
;; (define-lisp-shell-util mkdir)
;; (define-lisp-shell-util rsync)

