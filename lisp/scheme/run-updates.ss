#lang racket

(define update-scripts ("updategdbdocs.sh" "updateecls.sh" "updateschemebook.sh"
                        "updateclcookbook.pl" "update_sbcl.sh"
                        "updatetspl.sh" "updateclbuild.sh" "updatejquery_minified.sh"
                        "updatenginx.sh" "updatespring.sh" "updateabsguide.sh"
                        "update_scheme_books.pl" "update-spawn-fcgi.sh"
                        "updateCatalystTutorials.sh" "updatehaskell.sh"
                        "update_chicken.sh" "updatejbossdocs.sh"
                        "updatefastcgi.sh" "update_linux_docs.sh" "updateecl.sh"
                        "update_php_fpm.sh" "update_practical_common_lisp_book_site.pl"
                        "update_pde.el" "updatewordpress.pl"
                        "updategccdocs.sh" "updatestruts.sh"
                        "updateseamdocs.sh" "updatesjswsdocs.sh" "update_svn_book.sh"
                        "updatenginx.pl" "updateabcl.sh"
                        "updatecppreferencesite.sh" "update_js_docs.pl")

(define (run-updates update-scripts)
  (for ((script update-scripts))
       (system (path->string (build-path "/home/sonu/sonuscripts/" script)))))
      

(display "sonu")
(expand-user-path (string->path "~/.emacs.d"))
(current-directory)
