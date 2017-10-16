(define test (lambda (p)
               (let loop ((s (get-line p)))
                 (if (not s)
                     #f
                     (let ((m (string-match s-regex s)))
                       (if m
                           (match:substring m)
                           (loop (get-line p))))))))

(define test1 (lambda (p)
               (let ((s (get-line p)))
                 (if (not s)
                     #f
                     (let ((m (string-match s-regex s)))
                       (if m
                           (match:substring m)
                           (test1 p )))))))

(define test2 (lambda (p)
                (letrec ((s (get-line p))
                         (m (string-match s-regex s)))
                  (if m
                      (match:substring m)
                      (test2 p)))))

(define test1 (lambda (p)
                ))
