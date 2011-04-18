(load #p "/home/sonu/init_lisp.lisp")

(ql-load-packages '("proj-utils" "utils"))

(defpackage tc-utils
  (:use :proj-utils :util))

(in-package :tc-utils)


(defvar *proj* (make-instance 'tc-assembly-project :name :fall_plan_resource_tool))

;(setq *proj* (make-instance 'tc-assembly-project :name :fall_plan_resource_tool))
