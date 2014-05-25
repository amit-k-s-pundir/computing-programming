 (in-package :sonu-utils)

(defun s+ (&rest args)
  (apply #'concatenate 'string args))

;; (defun l->s (l)
;;   "Transforms a list of symbols into a string with those symbols as
;; its word constituents.  The default is to lower-case the symbols, when
;;   converted to words"
;;   )

(defun join (string-list &optional (field-separator ""))
  "Joins the elements of a list of strings to form a new string which
  is returned.  The word is used as the field separatar."
  (reduce (lambda (x y) (concatenate 'string x field-separator y))
  string-list))

(defun l->s (l)
  "Returns the string *equvalent* of the symbol l."
  (symbol-name l))

(defun join/ls (ls &optional (field-separator ""))
  "Joins the symbols in a list (of symbols) to form the equivalent
  string which is returned.")
