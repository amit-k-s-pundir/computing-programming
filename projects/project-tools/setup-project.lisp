;(require 'cl-lib)
(in-package :sonu-utils)

(defmacro with-dir (dir &rest body)
  `(let ((orig-dir (sb-posix:getcwd))
	 (new-dir (if (and (symbolp ',dir) (boundp ',dir))
		      (eval ',dir)
		      ,dir )))
     (sb-posix:chdir new-dir)
     ,@body
     (sb-posix:chdir orig-dir)))

(defmacro defprog (prog-name)
  `(defmacro ,prog-name (&rest args)

     `(! (format nil "~a ~{~a ~}" (string-downcase (symbol-name
						   ' ,',prog-name))
		 (mapcar (lambda
			     (x)
			   (string-downcase
			    (symbol-name
			     x))) ',args)))))

(defprog touch)
(defprog mkdir)

(defun setup-dirtree (dirtree dir)
  (if (null dir)
      (setq dir (sb-posix:getcwd)))
  (with-dir dir
    (cond ((stringp dirtree)
	   (! (format nil "touch ~a" dirtree)))
	  ((listp dirtree)
	   (let ((dirtree-root (car dirtree))
		 (children (cdr dirtree)))
	     (! (format nil "mkdir ~a " dirtree-root))
	     (setq dir dirtree-root)
	     (dolist (child children)
	        (setup-dirtree child dir)))))))

(defun setup-project (name &optional (dirtree '(name notes.org (src)
						      (lib))))
  (setup-dirtree dirtree)
  (let ((project-root-dir (car dir-tree))
	(children (cdr dir-tree)))
    ((dolist (child children)
       (setup-project child)))))

