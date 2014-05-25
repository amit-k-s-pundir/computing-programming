(in-package :com.pundir.sonu.utils.cpp)

(defun headers (&rest args)
  (format nil "~{#include <~a>~%~}" args))

(defun usual-headers (&optional additional-headers)
  (let* ((usual-headers '()))))
