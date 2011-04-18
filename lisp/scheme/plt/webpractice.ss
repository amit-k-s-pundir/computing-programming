#lang web-server/insta

(provide/contract
 [blog (list-of post?)]
 [struct post ((title string?) (body string?))] 
(define (start request)
  '(html
    (head (title "My Blog"))
    (body (h1 "Under Construction"))))
