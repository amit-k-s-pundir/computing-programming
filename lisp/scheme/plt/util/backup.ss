(module backup scheme
  (require net/smtp
           net/head
           openssl
           (file "~/workspace/programming/lisp/scheme/plt/util/util.ss")
           ;(planet dherman/java:1:5/java)
           ;(planet "java.ss" ("dherman" "java.plt" 1 5 ))
           )
  (provide/contract
   [config-file-path-list (listof path?)])

  (define config-file-path-list '()))
