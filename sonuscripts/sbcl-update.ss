#!/opt/guile/bin/guile \
-e main -s
!#

;(define-module (sonu utils))


(define-syntax with-dir
  (syntax-rules ()
    ((with-dir dir body ...)
     (let ((orig-dir (getcwd)))
       (chdir dir)
       body ...
       (chdir orig-dir)))))

(define sbcl-update 
  (lambda* (#:key (source-dir "/opt/sources/lisp/cl/sbcl") (install-dir "/opt/sbcl-dev"))
    (let* ((update-cmd "git pull")
	  (build-cmd (string-append "sh make.sh --fancy --prefix=" install-dir))
	  (build-doc-cmd "pushd doc/manual && make && popd")
	  (install-cmd "sh install.sh")
	  (cmd (string-append update-cmd " && " build-cmd " && " build-doc-cmd " && " install-cmd)))
      (with-dir source-dir
		(system cmd)
		;(display cmd)
		))))
  
(define (main args)
  (sbcl-update))

