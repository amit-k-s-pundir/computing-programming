(defun ! (cmdstring)
  (shell-command cmdstring))

(defmacro defshellcmd (cmd)
  `(defmacro ,cmd (&rest args)
     (let ((cmdstring (mapconcat #'symbol-name `(,',cmd ,@args) " ")))
       `(! ,cmdstring))))
     ;; (destructuring-bind (&optional arg1 arg2 arg3) ,',args
     ;; 			  (cond ((null arg1)
     ;; 				 `(! ,',@(symbol-name cmd))
     ;; 				 (null arg
				 

(defmacro gvim1 (&rest args)
  (let ((cmdstring (mapconcat #'symbol-name `(gvim ,@args) " ")))
    `(! ,cmdstring)))

(defun setup-emacs-system (repo)
  (cond ((local-gitrepo-p repo)
	 (with-dir base-dir
	 (rsync -avP repo)))
	((remote-gitrepo-p repo)
	 (git clone repo))
	(t (message "The repo url provided is neither a local nor a remote git repo. Use your local package manager to install the emacs package!")))
;	 (let ((cmd (format "rsync -av -P %s %s" (cadr repo) 
  )

(defun setup-cl-system ())
(defun setup-scheme-system ())

(defun setup-lisp-systems ()
  (setup-emacs-system)
  (setup-cl-system)
  (setup-scheme-system))
