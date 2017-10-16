(in-package #:shopping-list)

(defun display-shopping-list/web (shopping-list)
  (with-html-output (*http-stream*)
    (:table
         (:colgroup (:col) (:col))
         (:colgroup (:col) (:col) (:col) (:col) (:col))
         (dolist (request shopping-list)
           (htm (:tr (str (display-request/web request))))))))

(defun display-request/web (request)
  (with-html-output (*http-stream*)
    
    )
  )
