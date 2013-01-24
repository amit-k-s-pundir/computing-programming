(load #p "/home/sonu/workspace/programming/lisp/cl/init-sbcl.lisp")
(setq *default-pathname-defaults* #p "/home/sonu/")
;(setf asdf:*central-registry*
;(list* #p "/home/sonu/workspace/programming/lisp/cl/"))
(setq *cl-lib-dir* #p "~/workspace/programming/lisp/cl/")
(load  #p "/home/sonu/workspace/utils/utils.lisp") 

(defpackage project-utils
  (:utils))
