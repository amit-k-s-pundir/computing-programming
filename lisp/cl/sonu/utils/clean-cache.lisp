(setq the-cache-dir #p "/home/sonu/.cache/")

(defvar *cache-dirs* '(#p "/home/sonu/.cache/"))

(defun clean-the-cache-dir (&optional (cache-dir the-cache-dir))
  (let ((cl-cache-dir (merge-pathnames #p "common-lisp/" the-cache-dir)))
    ))
