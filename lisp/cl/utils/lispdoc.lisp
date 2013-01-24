;;;; A web app to find documentation for the libs installed locally.
;;;; Workflow:
;;;; 1. Enter a name of the lib/component - or the nearest identifiable (and
;;;; preferably unique) approximation of it - in the url after the name of the
;;;; app. For example:
;;;; lispdoc/slime or lispdoc/alexand
(if (a-unique-lib-name-can-be-deduced-from-the-url)
    (present-a-canonical-help-page-for-that-lib)
    (error "We can't deduce the name of the lib from url!"))

(defun present-a-canonical-help-page-for-that-lib (lib-name)
  (cond
    ((lib-doc-dir)                      ; get the doc dir for this lib
     (if (doc-dir-has-an-index-page-p)
         (render (get-doc-index-page lib)) ; render the doc/index.html page for
                                        ; this lib
         (render (get-doc-dir lib))))                           ; else, present the web view of the doc dir
    (t
     (render (lib-dir lib)))))                              ; there is no lib/doc/ dir, so just
                                        ; render the ./lib/ dir itself

