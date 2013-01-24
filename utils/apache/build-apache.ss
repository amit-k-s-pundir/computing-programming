;#lang racket
(module build-apache racket
  (require "sonu-utils.ss")
  (provide build-apache build-apache-debug-single-threaded)

  (define (build-apache (base-dir
                         "/home/sonu/workspace/programming/sources/apache/httpd-trunk"))
    (or 
     (and (cd base-dir)
          (configure) (make) (make "install"))
     (error "Unable to build apache!")))

  (define (build-apache-debug-single-threaded config-options src-dir)
    (and (cd src-dir) (configure config-options) (make) (make "install")))
  )

