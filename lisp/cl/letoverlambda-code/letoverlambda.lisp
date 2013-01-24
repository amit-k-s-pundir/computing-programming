(defpackage #:lol)
(in-package #:lol)

;; Lisp implementation of Perl's heredoc (<<) syntax.
(defun |#>-reader| (stream sub-char numarg)
  (declare (ignore sub-char numarg))
  (let (chars)
    (do ((curr (read-char stream)
	       (read-char stream)))
	((char= #\newline curr))
      (push curr chars))
    (let* ((pattern (nreverse chars))
	   (pointer pattern)
	   (output))
      (do ((curr (read-char stream)
		 (read-char stream)))
	  ((null pointer))
	(push curr output)
	(setf pointer
	      (if (char= (car pointer) curr)
		  (cdr pointer)
		  pattern))
	(if (null pointer)
	    (return)))
      (coerce (nreverse
	       (nthcdr (length pattern) output))
	      'string))))

(set-dispatch-macro-character
 #\# #\> #'|#>-reader|)
