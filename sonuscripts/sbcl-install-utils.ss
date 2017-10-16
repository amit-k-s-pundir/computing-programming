(use-modules (ice-9 regex))
(use-modules (ice-9 format))

(define sbcl-version (lambda ()))

(define gen-sbcl-dist-url (#:optional url (version 'latest))
(or url (and version 



(define install-stable-sbcl (lambda* (#:optional (install-dir
						  "/opt/sbcl-stable")
						 (dist-url
						  "http://prdownloads.sourceforge.net/sbcl/sbcl-1.3.1-x86-64-linux-binary.tar.bz2")
						 (download-dir
						  "/opt/downloads/sbcl-stable")
						 version)

(with-dir download-dir
(let ((dist-url (or dist-url (format #f
				     "http://prdownloads.sourceforge.net/sbcl/sbcl-~a-x86-64-linux-binary.tar.bz2"
				     (sbcl-version)))))

(let ((shell-cmd (format nil "wget ~a" dist-url)))
(system shell-cmd)
(and (setq sbcl-dist-url (extract-sbcl-dist-url)) (install-sbcl
						   install-dir)))))

 
