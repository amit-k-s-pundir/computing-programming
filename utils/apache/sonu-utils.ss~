(module sonu-utils racket
  (provide all-defined-out)
  
  (define (cd dir)
    (current-directory dir))

  (define (configure (options ""))
    (system (string-append "./configure " options)))

  (define (make (options ""))
    (system (string-append "make " options)))
  )
