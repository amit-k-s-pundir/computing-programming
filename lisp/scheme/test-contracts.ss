#lang scheme/load

(module test1 scheme
(define amount 150)
(define (canonize-defclass-options class-name options)
(print "hello"))
(provide/contract [amount (and/c number? positive?)]
[canonize-defclass-options (->d ((class-name symbol?)
(options (listof (symbols 'default-initargs 'documentation))))
()
(result any/c))]))

(module test2 scheme
(require 'test1)
(+ amount 10)
(define sonu 'sonu)
(canonize-defclass-options 'sonu '(default-initargs documentation))
)

(require 'test2)
