#lang racket

(require ffi/unsafe)

(define mkdir
  (get-ffi-obj "mkdir" #f (_fun _string _int -> _int)))

(define cd
  (get-ffi-obj "chdir" #f (_fun _string -> _int)))
(define cstruct 
(define stat
