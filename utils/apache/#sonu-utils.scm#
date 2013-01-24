(module sonu-utils
  *
;  (provide all-defined-out)
;  (provide cd configure make)
  (import scheme chicken posix irregex)

  (define (cd dir)
    (current-directory dir))

  (define (configure #!optional (options ""))
    (system (string-append "./configure " options)))

  (define (make #!optional (options ""))
    (system (string-append "make " options)))
  )
