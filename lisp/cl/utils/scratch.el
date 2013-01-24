(defun copy-fn-to-file (file)
  (save-excursion 
    (let ((beg (beginning-of-defun))
	  (end (end-of-defun))
	  (reg (copy-region-as-kill beg end)))
      (goto-line (+1 end))
      (yank))))
