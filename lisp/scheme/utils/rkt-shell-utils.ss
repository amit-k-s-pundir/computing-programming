(module rkt-shell-utils racket
;  (require (for-syntax racket))
  (provide def-shell-cmd)
;  (provide (all-defined-out))
  ;; (define-syntax-rule (def-shell-cmd cmd-str)
  ;;   (define cmd (lambda (args)
  ;;                (system (string-append cmd-str " " args)))))
  (define-syntax (def-shell-cmd stx)
    (syntax-case stx ()
      ((_ cmd cmd-str) #'(define cmd (lambda (args)
                                   (system (string-append cmd-str " "
                                                          args))))))))

