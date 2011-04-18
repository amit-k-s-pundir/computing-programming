#lang scheme

(define-syntax (define-getter+setter stx)
(define (symbol-append . syms)
(string->symbol
(apply string-append (map symbol->string syms))))
(syntax-case stx ()
[(define-getter+setter name init-value)
(unless (identifier? #'name)
(raise-syntax-error 'define-get+set
"expected identifier" #'name))

(with-syntax
([getter
(datum->syntax-object
#'name (symbol-append 'get- (syntax-object->datum #'name)))]
[setter
(datum->syntax-object #'name (symbol-append 'set- (syntax-object->datum #'name) '!))])
#'(define-values (getter setter)
(let ([name init-value])
(values (lambda () name)
(lambda (new-value)
(set! name new-value))))))]))

