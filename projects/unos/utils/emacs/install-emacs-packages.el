(use 'cl-lib)
(use 'sonu-utils)

;; An association list of (package default-package-install-fn). When
;; the user doesn't provide an *install-fn* for a *package* then the
;; *install-package* function looks into this table for a
;; *default-package-install-fn* before giving up.
(defvar *package-install-fn-tbl*)

(defvar *source-install-dir* "/opt/sonu/emacs-packages")

(cl-pushnew '(emacs-helm #'install-emacs-helm) *package-install-fn-tbl*)
 
(defun install-packages (packages)
  (dolist (package packages)
    (install-package package)
    ))

(defun install-package (package)
  (cond ((functionp package)
	 (funcall package))
	((symbolp package)
	 (let ((default-pkg-install-fn (cadr (assoc symbol
						    *package-install-fn-tbl*))))
	   (funcall default-pkg-install-fn)))
	(t
	 (error "No default function is known to install the package
  %s" (symbol-name package)))))

(defun install-package/git (&optional dir &key git-repo-addr)
  "Clones the repo from given *git-repo-addr* into *dir*"
  )

(defun install-emacs-helm (&optional helm-git-dir helm-git-repo-url
   async-git-dir async-git-repo-url)
  (unless (git-repo? helm-git-dir)
    (git/clone  helm-git-repo-url helm-git-dir))
  (unless (git-repo? async-git-dir)
    (git/clone async-git-repo-url async-git-dir))
  (let ((text (format "(add-to-list 'load-path %s)
	      (add-to-list 'load-path %s)
(require 'helm-config)" async-git-dir helm-git-dir)))
  (append-to-file text nil "/home/sonu/.emacs")))

(defun git-repo? (dir)
  (file-exists-p (concat dir "/.git")))

(defun git/clone (repo &optional dir)
  (flet ((git/clone0 (repo-url install-dir)
		     (with-dir install-dir
			       (! (format "git clone %s" repo-url)))))
    (let ((repo-url)
	  ((install-dir (or dir default-directory))))
      (cond ((symbolp repo)
	     ;;When *rep* is a symbol, we construct a default url - a
	     ;;github url derived naturally from the *rep*'s symbol-name
	     (setq repo-url (format "https://github.com/%s" (symbol-name
  							     repo)))
					;	   (setq install-dir (or dir 
	     (git/clone0 repo-url install-dir))
	    (t ; The default case assumes that *repo* is a valid url;
					; it is the duty of the user to ensure that *repo* is
					; indeed a valid url!
	     (git/clone0 repo install-dir))))))


(defvar *packages-to-be-installed*)

(setq *packages-to-be-installed* '(slime paredit geiser async
					 emacs-helm))

(defun install-slime ()
  

	    
	
  (! "git clone 
