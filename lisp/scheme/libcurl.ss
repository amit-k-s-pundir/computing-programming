#lang racket
(require ffi/unsafe)

;(curl-global-init)
(define curl-global-init 
  (get-ffi-obj "curl_global_init" (ffi-lib "libcurl")
               (_fun _long -> _int)))

; (define (curl-easy-init))
(define curl-easy-init
  (get-ffi-obj "curl_easy_init" (ffi-lib "libcurl")
               (_fun -> _pointer)))

; (define (curl-easy-cleanup p-curl-handle))
(define curl-easy-cleanup
  (get-ffi-obj "curl_easy_cleanup" (ffi-lib "libcurl")
               (_fun _pointer -> _void)))

; CURLcode curl_easy_setopt(CURL* curl, CURLoption option, ...)
(define curl-easy-setopt (ffi-lib "libcurl")
  (_fun _pointer _int -> _int))

(define-syntax define-curl-options
  