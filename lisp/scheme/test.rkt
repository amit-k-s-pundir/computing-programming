#lang racket/gui

(require framework)
(application:current-app-name)

(define frame (new frame% (label "Example")))
(send frame show #t)