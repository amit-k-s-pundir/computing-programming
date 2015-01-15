;(load
;"/home/sonu/workspace/programming/lisp/scheme/racket/unos/utils/os-utils.ss")
(use-modules (sonu os-utils))


;; (define *download-url* (make-parameter
;; 			"http://mirror.racket-lang.org/installers/6.1/racket-6.1-x86_64-linux-ubuntu-precise.sh"))
;; (define *version* (make-parameter "6.1"))
;; (define *platform* (make-parameter "x86_64"))
;; (define *os* (make-parameter "linux-ubuntu-precise"))
;; (define *download-dir* (make-parameter "/opt/downloads/t"))
;; (define *install-dir* (make-parameter "/opt/racket/"))
  
(defprog make)
(defprog git)
(defprog config)

(use-modules (ice-9 peg))

(define-peg-string-patterns
  "download-url <- 'http://mirror.racket-lang.org/installers/' ver '/racket-' ver '-' arch '-' os '.sh'~
ver <- [0-9]+ '.' [0-9]+
arch <- ")

(defne (update-racket/stable download-url (download-dir
                                           "/opt/downloads/t/racket-install-download")
                             (install-dir)))

(define (update-guile/stable download-url (download-dir
                                       "/opt/downloads/t/guile-stable-install-download")
                         (install-dir (format nil "/opt/guile-stable-~a" version)))
    (let ((download-file-name (last (regexp-split #rx"/"
                                                 download-url))))
      (with-dir/ensure download-dir
                       (! wget -c download-url)
                       (! chmod +x download-file-name)
                       (! download-file-name ""))))
(define (update-guile-stable download-url version platform os
                             download-dir install-dir))

(define (update-guile-dev  (download-url (*download-url*)) (version
							 (*version*))
			  (platform (*platform*)) (os (*os*))
			  (download-dir (*download-dir*)) (install-dir
							 (*install-dir*)))
  (with-dir source-dir
            (& (make distclean) (git pull) (config) (make) (make install))))
   
      (let* ((download-file-name (~a "racket-" version "-" platform
				     "-linux-" os ".sh"))
	   (download-url (~a
			    "http://mirror.racket-lang.org/installers/" 
			    version "/" download-file-name)))
	(displayln download-url)
	(displayln "sonu")
	(with-dir downlo2ad-dir
		  (! 'wget "-c" download-url)
		  (! 'chmod "+x" download-file-name)
		  (! download-file-name "")))
;    (update-racket)

					;)
  

(use-modules (sxml simple))
(xml->sxml "<foo/>")
