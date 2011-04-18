(defun slime-start-to-regex-eval-region (&optional regex)
  (let ((start (point-min))
		(end (progn (re-search-forward regex)
				  (forward-line -1)
				  (end-of-line)
				  (point))))
;	(princ start)
;	(princ end)
	(slime-eval-region start end)
	)
  )
  
