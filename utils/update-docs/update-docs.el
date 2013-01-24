(defun gen-shell-prog (file-name prog-fn)
  (with-open-file file-name
		  (prog-fn)))
