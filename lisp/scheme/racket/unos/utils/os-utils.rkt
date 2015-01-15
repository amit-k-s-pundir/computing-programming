(module os-utils racket
  (provide mount
	   !
	   !/sudo
	   with-dir
           with-dir/ensure)
  
  (define-syntax-rule (with-dir dir body ...)
    (let ((original-dir (current-directory)))
      (current-directory dir)
      body ...
      (current-directory original-dir)))

  (define-syntax-rule (with-dir/ensure dir body ...)
    (begin
      (if (not (directory-exists? dir))
          (! mkdir dir)
          dir)
      (with-dir dir body ...)))

  (define (mount source dest . options)
    (let ((cmd (~a 'mount  (apply ~a "" options #:separator " --")
                   source dest #:separator " ")))
      (process cmd)))

;; (define (! cmd options . args)
;;   (let ((real-cmd (~a cmd options (apply ~a args #:separator " ")
;; 		      #:separator " ")))
;; ;    real-cmd
;;     (process real-cmd)
;; ))

(define-syntax (! stx)
  (syntax-case stx ()
    ((_ cmd args ...)
     #'(let ((real-cmd (~a  'cmd 'args ... #:separator " ")))
         (process real-cmd)))))

(define (!/sudo cmd options . args)
  (let ((real-cmd (~a "echo sonu | sudo -S " cmd options (apply ~a
								args
								#:separator
								" ")
		      #:separator " ")))
;    real-cmd
    (process real-cmd)
)))
