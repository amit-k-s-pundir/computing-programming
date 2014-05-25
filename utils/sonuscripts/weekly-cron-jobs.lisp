;#!/opt/sbcl/bin/sbcl --core /opt/sbcl-sonu.core --script

;(load "~/.sbclrc")

;; (defpackage #:utils-cron
;;   (:use :cl :cl-fad :cl-ppcre))

;; (in-package #:utils-cron)

;; Saved the core therefore don't need the following:
;; #-quicklisp
;; (let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
;;                                        (user-homedir-pathname))))
;;   (when (probe-file quicklisp-init)
;;     (load quicklisp-init)))


;;; Check for --no-linedit command-line option.
;; (if (member "--no-linedit" sb-ext:*posix-argv* :test 'equal)
;;   (setf sb-ext:*posix-argv* 
;;         (remove "--no-linedit" sb-ext:*posix-argv* :test 'equal))
;;   (when (interactive-stream-p *terminal-io*)
;;     (require :sb-aclrepl)
;;     (ql:quickload "linedit")
;;     (funcall (intern "INSTALL-REPL" :linedit)
;;              :wrap-current t)))

;(load
;"/home/sonu/workspace/programming/lisp/cl/utils/utils-string.lisp")

(in-package :utils)


;(load "/home/sonu/.sbclrc")

;; (dolist (package '("UTILS" "CL-FAD"))
;;   (if (not (find-package) package)
;;       (ql:quickload package)))

;(ql:quickload "cl-fad")

(defun update-repo (repo-dir)
  "Finds out whether the repo-dir is git or svn repo and if it is, it
updates the repo appropriately"
  (let* ((children
          (mapcar
           #'directory-namestring
           (cl-fad::list-directory
            repo-dir))))
    (dolist (child children)
      (multiple-value-bind (match registers) (cl-ppcre:scan-to-strings
                                              "(\\.svn)|(\\.git)"
                                              child)
        (cond ((string= match ".git")
               (utils::with-dir repo-dir
                 (utils::run-shell-cmd
                  "git pull")))
              ((string= match ".svn")
               (utils::with-dir repo-dir
                 (utils::run-shell-cmd
                  "svn update"))))))))

(defun update-repos (repos)
  (dolist (repo repos)
    (update-repo repo)))

(defun run (jobs)
  (dolist (job jobs)
    (funcall job)
;    (format t "Job is : ~A" job)
    ))

;; (defgeneric run (job))
;; (defun build (build-job))

(defvar *repos* (mapcar (lambda (dir)
                                (concatenate 'string "/opt/sources/"
                                             dir))
                              '("apache/httpd_trunk/" "boost-trunk."
                                "cedet/" "curl/"
                                "emacs_dev_git_depth_1/" "gcc/"
                                "lisp/cl/sbcl/" "lisp/cl/ecls/ecl/"
                                "lisp/cl/ecls/ecl-doc"
                                "scheme/chicken-core/"
                                "scheme/guile/" "scheme/kawa/" "plt"
                                "swig/trunk")))


;; (defvar *daily-build-jobs* '(#'build-emacs ) "A list of jobs - as
;; functions - to be run by (f)cron")

;; make as the the build back end.
;; (defvar *config-options* '(("prefix" "/opt/emacs_dev")))
;; (defvar *build-targets* '("bootstrap" "make"))
;; (defvar *install-targets* '())
;; (defvar *clean-targts* '("distclean"))
;; (build-emacs *config-optionns* *build-targets* *install-targets*)
 ;; Define a build-emacs function using
(defmacro defbuildjob-make (job-name)
  `(defun ,job-name (config-options build-targets install-targets
		     &optional clean-targets autogen-p additional-config-args
		       additional-build-args
		       additional-install-args)
     (let* ((config-cmd (apply #'utils::s+ "./configure " (mapcar (lambda (item)
								    (destructuring-bind
									  (option
									   value)
									item
								      (utils::s+
								       "--" option
								       "=" value))) config-options)))
	    (build-cmd (reduce (lambda (x y) (utils::s+ x " && " y)) (mapcar (lambda (x) (utils::s+
											  "make " x)) build-targets)))
	    (install-cmd "make install")
	    (clean-cmd (format nil "~{make ~A ~^&& ~}" clean-targets))
	    (autogen-cmd (if autogen-p
			     (format nil "./autogen.sh ")
			     nil))
	    (cmd (format nil "~A && ~:[~;~:*~A && ~] ~A && ~A && ~A"
			 clean-cmd autogen-cmd config-cmd build-cmd
			 install-cmd))
	    )
					;       (format t "~A" config-cmd)
					;      (utils::! config-cmd)
       (format t "~A" cmd)
					;       (utils::! cmd)
       )))

(defbuildjob-make build-emacs)
							
     
(setq *build-jobs* `(,(lambda ()
			 (utils::with-dir "/opt/sources/emacs_dev_git_depth_1/"
			   (utils::build-emacs '(("prefix" "/opt/emacs_dev/"))
					       '("bootstrap" "") '("install")
					       '("distclean") t)))
					;#'build-sbcl #'build-chicken #'build-ecl
					;      #'build-guile
		       ))

(update-repos *repos*)

(run *build-jobs*)
