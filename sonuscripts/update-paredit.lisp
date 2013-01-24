(in-package :utils)

;(ql:quickload "drakma")

;(setq *header-stream* *standard-output*)

(defvar *paredit-stable-url*
  "http://mumble.net/~campbell/emacs/paredit.el")

(defvar *paredit-dev-url*
  "http://mumble.net/~campbell/emacs/paredit-beta.el")
(defvar *install-dir* "/home/sonu/.emacs.d/site-lisp/")
(defvar *download-dir* "/opt/downloads/")

(install 'paredit-stable *paredit-stable-url* *install-dir* *download-dir*)
(defmethod install ((x (eql 'paredit-stable)) &optional
						(paredit-stable-url
						 *paredit-stable-url*
						 paredit-stable-url-p)
						(install-dir
						 *install-dir*
						 install-dir-p)
						(download-dir
						 *download-dir*
						 download-dir-p))
  (let ((download-cmd (format nil "wget -N -c ~A"
			      paredit-stable-url)))
    (utils::with-dir download-dir
      (utils::! download-cmd)  ;; (utils::run-shell-cmd download-cmd)
      (utils::rsync `("./paredit.el" ,install-dir)))
    (with-open-file (s "~/.emacs" :direction :output :if-exists
		       :append )
      (format s "~%~A" "(autoload 'paredit-mode \"paredit\"
      \"Minor mode for pseudo-structurally editing Lisp code.\" t)
    (add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
    (add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
    (add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
    (add-hook 'scheme-mode-hook           (lambda () (paredit-mode
+1)))"))))
    
