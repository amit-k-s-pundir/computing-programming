(defpackage #:sonu-cron
  (:use :cl :sonu-utils))

(in-package :sonu-cron)

(defvar *job-list*)

(defun register-job (job spec)
  (add-job (job spec *job-list*)))
