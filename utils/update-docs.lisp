;; (defpackage :l
;;   (:use :cl :cl-ppcre :drakma))

(in-package :l)
  
;(defun update-programming-doc )

;(load "~/init.lisp")

(defgeneric update (doc)
  :documentation "Given an instance of doc class it updates the local
  installation by fetching and installing those docs"
  )

(defclass doc ()
  ((local-repo :initform nil :initarg :local-repo)
   (remote-urls :initform nil :initarg :remote-urlsb c)))

(defparameter *cl-doc-urls* '("ftp://ftp.lispworks.com/pub/software_tools/reference/HyperSpec-7-0.tar.gz"
                              "onlisp"
                              "http://www.cs.cmu.edu/afs/cs.cmu.edu/project/ai-repository/ai/lang/lisp/doc/cltl/cltl_ht.tgz"
                              (lambda () (let* ((url
                                                 "http://letoverlambda.com/index.cl/toc")
                                                (cmd (format nil "wget
-EN -ckpr -l1 -np ~A" url)))
                                           (utils::run-shell-cmd
                                            cmd))) 
                              (lambda ()
 .                                (let* ((urls
                                        '("http://www.alu.org/mop/contents.html"
                                          "http://www.alu.org/mop/concepts.html"
                                          "http://www.alu.org/mop/dictionary.html"
                                          )))
                                  (dolist (url urls)
                                    (utils::run-shell-cmd
                                     (format nil "wget -En -ckp
~A" url)))))
                                        ;"ecoop"
                              "http://www.sbcl.org/manual/"))

(defclass cl-doc (doc)
  ((local-repo :initform "/home/sonu/programming_docs/lisp/cl/"
  :initarg :local-repo)
   (remote-urls :initform *cl-doc-urls*
   :initarg :remote-urls)))

(defmethod update ((doc cl-doc))
  (with-dir doc-repo-dir
    (let* ((remote-urls doc-remote-urls))
      (dolist (url remote-urls)
        (cond ((functionp url)
               (funcall ))
              ((stringp url)
               (let ((cmd (format nil "wget -EN -ckp ~A" url)))
                 (utils::run-shell-cmd cmd)))
              )))))

(defparameter *scheme-doc-urls* '((lambda ()
                                    (let* ((url "http://www.scheme.com/tspl4/index.html")
                                           (cmd (format nil
                                                        "wget -EN -ckp -r -l2 ~A"
                                                        url)))
                                      (utils::run-shell-cmd
                                       cmd)))
				  (lambda ()
				    (let*
					((url
					  "http://mitpress.mit.edu/sicp/full-text/book/book.html")
					 (cmd (format nil "wget
                                            -EN -ckp -r -l2 ~A" url)))
				      (utils::run-shell-cmd
				       cmd)))
                                        ;"racket-docs" ; Updated
                                        ; through racket installation. 
                                        ; "chicken-docs" ; Updated through
                                        ; chicken installation.
                                        ; "r6rs" ; No need to update really!
                                        ;"gambit-docs" ; No need to update really!
                                  ))
(defclass scheme-doc (doc)
  ((local-repo :initform "/home/sonu/programming_docs/lisp/scheme/"
  :initarg :local-repo)
   (remote-urls :initform *scheme-doc-urls* :initarg :remote-urls)))

(defmethod update ((doc scheme-doc))
  (with-dir doc-repo-dir
    (let* ((remote-urls doc-remote-urls))
      (dolist (url remote-urls)
        (cond ((functionp url)
               (funcall ))
              ((stringp url)
               (let ((cmd (format nil "wget -EN -ckp ~A" url)))
                 (utils::run-shell-cmd cmd)))
              )))))

(defmethod update ((doc cl-doc) &optional base-dir)
  (with-dir base-dir
    (let ((urls (doc-remote-urls cl-doc )))
      (loop for url in urls
         do (get-install url)))))

(defun get-install (url &optional base-dir)
  (let ((base-dir (or base-dir ".")))
    (with-dir base-dir
      (let ((cmd (format nil "wget -Ncp ~A")))
        (! cmd)))))
