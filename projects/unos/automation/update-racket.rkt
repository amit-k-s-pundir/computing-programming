(module update-racket racket
  (require (file
	    "/home/sonu/workspace/programming/lisp/scheme/racket/unos/utils/os-utils.rkt"))
;  (provide update-racket)
  

  ;; (define *download-url* (make-parameter
  ;;       		  "http://mirror.racket-lang.org/installers/6.1/racket-6.1-x86_64-linux-ubuntu-precise.sh"))
  ;; (define *version* (make-parameter "6.1"))
  ;; (define *platform* (make-parameter "x86_64"))
  ;; (define *os* (make-parameter "linux-ubuntu-precise"))
  ;; (define *download-dir* (make-parameter "/opt/downloads/t"))
  ;; (define *install-dir* (make-parameter "/opt/racket/"))
  
  
					;  (parameterize ((*download-url*
					;		  )
  ;; (parameterize ((*download-url*
  ;;       	  "http://mirror.racket-lang.org/installers/6.1/racket-6.1-x86_64-linux-ubuntu-precise.sh")
  ;;       	 (*version* "6.1") (*platform* "x86_64") (*os* "linux-ubuntu-precise")
  ;;       			(*download-dir* "/opt/downloads/t")
  ;;       			(*install-dir* "/opt/racket"))

  
  (define (update-racket download-url (download-dir
                                       "/opt/downloads/t/racket-install-download")
                         (install-dir (~a "/opt/racket-" version)))
    (let ((download-file-name (last (regexp-split #rx"/"
                                                 download-url))))
      (with-dir/ensure download-dir
                       (! wget -c download-url)
                       (! chmod +x download-file-name)
                       (! download-file-name ""))))
  
  (define (update-racket/ver+plat+os  version platform os
                          download-dir install-dir) 
    (let* ((download-file-name (~a "racket-" version "-" platform
                                   "-linux-" os ".sh"))
           (download-url (~a
                          "http://mirror.racket-lang.org/installers/" 
                          version "/" download-file-name)))
      (update-racket download-url download-dir install-dir)))

  (define (gen-download-url)
    (let ((download-dir "/opt/downloads/t/racket-install-download")
          (url "download.racket-lang.org"))
      (with-dir/ensure download-dir
                       (! wget -c url)
                       (call-with-input-file
                           (~a download-dir "/download.racket-lang.org.htm")
                         ;;                   "/home/sonu/workspace/programming/projects/unos/automation/download.racket-lang.org.htm"
                         (lambda (in) (for ((l (in-lines in)))
                                        (let ((result (regexp-match #px"http://mirror\\.racket-lang\\.org/installers/(\\d+\\.\\d+)/racket-\\1-x86_64-linux-ubuntu-(.*)\\.sh" l)))
                                          (and result (displayln
                                                       (list-ref
                                                        result
                                                        1))))))))))
  (define (f)
    'pundir))


