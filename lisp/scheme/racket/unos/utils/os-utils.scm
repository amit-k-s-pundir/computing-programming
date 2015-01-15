(define-module (sonu os-utils)
  #:use-module (ice-9 format))

(export ! !/sudo with-dir)

(define-syntax-rule (with-dir dir body ...)
    (let ((original-dir (getcwd)))
      (chdir dir)
      body ...
      (chdir original-dir)))

(define-syntax !
  (syntax-rules ()
    ((_ cmd args ...)
     (let ((real-cmd-string (list 'cmd 'args ...)))
       (system (string-join (map symbol->string real-cmd-string)))))))

(define (mount source dest . options)
  (! mount dest options))


(define-syntax !/sudo
  (syntax-rules ()
    ((_ cmd args ...)
     (system (string-concatenate "echo sonu | sudo -S " (string-join
							 (map
							  symbol->string
							  (list 'cmd
								'args
								...))))))))
