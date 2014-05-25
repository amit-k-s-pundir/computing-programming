(in-package :utils)

(defun insert-throughout (l s)
  (let ((lcar (car l))
	(lcdr (cdr l)))
    (if (null lcdr)
	l
	(cons lcar (cons s (f lcdr))))))
