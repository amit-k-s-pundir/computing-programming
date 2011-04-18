(use regex) 
(define (process-line line re rplc) 
  (string-substitute re rplc line 'all))
(define (quickrep re rplc) 
  (let ((line (read-line)))
    (if (not (eof-object? line))
        (begin 
          (display (process-line line re rplc))
          (newline)
          (quickrep re rplc)))))
;;; Does a lousy job of error checking!
(define (main args)
  (quickrep (regexp (car args)) (cadr args)))
