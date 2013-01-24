(define update-docs-scheme (#!optional urls (download-dir
                                             "/opt/downloads")
                                       (install-dir
                                        "/home/sonu/programming_docs/lisp/scheme"))
  (update-tspl-book)
  (update-docs-scheme-chicken)
  (update-docs-scheme-guile)
  (update-docs-scheme-racket)
  )
  
