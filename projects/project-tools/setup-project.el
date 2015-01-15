(require 'cl-lib)

(defmacro with-dir (dir &rest body)
  `(let ((orig-dir default-directory)
	(new-dir (if (and (symbolp ,dir) (boundp ',dir))
		   (eval ',dir)
		   ,dir )))
     (cd new-dir)
     ,@body
     (cd orig-dir)))

(defmacro defprog (prog-name)
  `(defmacro ,prog-name (&rest args)

     
     `(shell-command ,(concat (symbol-name ',prog-name) " "
							  `,(mapconcat
							   'symbol-name
							  args " ")))))

(defprog touch)
(defprog mkdir)

(defun setup-dirtreew (dirtree dir)
  (if (null dir)
      (setq dir default-directory))
  (with-dir dir
	    (cond ((stringp dirtree)
		   (shell-command (concat "touch " dirtree))
		  ((listp dirtree)
		   (let ((dirtree-root (car dirtree))
			 (children (cdr dirtree)))
		     (shell-command (concat "mkdir " dirtree-root))
		     (setq dir dirtree-root)
		     (dolist (child children)
		       (setup-dirtree child dir))))))))

(defun setup-project (name &optional (dirtree '(name notes.org (src)
						      (lib))))
  (setup-dirtree dirtree)
  (let ((project-root-dir (car dir-tree))
	(children (cdr dir-tree)))
    ((dolist (child children)
       (setup-project child)))))
