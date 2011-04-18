 ;#lang scheme
(module util scheme
(require scheme/file)
(require /home/sonu/workspace/programming/lisp/scheme/plt/util/sendmail.ss)
(define default-tc-workspace-path (build-path (find-system-path 'home-dir)
                                              "workspace" "projects" "tc" "dev"))

(make-directory default-tc-workspace-path)

(directory-list (build-path default-tc-workspace-path 'up))

(path-string? default-tc-workspace-path)

(directory-list default-tc-workspace-path))

;(define (create-txt-file dir name ext))
;(define (create-tc-dev-project project-home-dir-path ))
;(define (create-dir-tree dir-tree base-dir)
 ; (let [(base-dir (if (path? base-dir) base-dir (current-directory)))]
  ;  (cond ((symbol? dir-tree)
   ;        (make-directory (build-path base-dir dir-tree))
    ;       [(list? dir-tree)
     ;       (make-directory (build-path base-dir (car dir-tree)))
      ;      (let [(base-dir (build-path base-dir (car dir-tree)))]
       ;       )]
        ;   ))
;)
