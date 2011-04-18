(require net/url xml)
(string->url "http://www.google.com")
(xexpr->string '(html (head (title "Hello")) (body "Hi!")))
