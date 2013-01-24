(module sonu-utils racket
  (provide all-defined-out)
;  (provide cd configure make)
  
  (define (cd dir)
    (current-directory dir))

  (define (configure (options ""))
    (system (string-append "./configure " options)))

  (define (make (options ""))
    (system (string-append "make " options)))
  )
