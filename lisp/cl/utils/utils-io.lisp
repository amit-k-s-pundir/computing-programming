(in-package :utils)

;; Writes string to a file.
(defun s> (string file)
  (with-open-file (s file :direction :output)
    (format s "~%~A~%" string)))

(defun s>> (string file)
  (with-open-file (s file :direction :output :if-exists :append)
    (format s "~%~A~%" string)))
