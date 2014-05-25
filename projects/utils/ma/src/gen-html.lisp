(ql:quickload "cl-who")
(ql:quickload "cl-fad")

(temporar)
(defvar *base-dir* #p "~/workspace/programming/projects/utils-mom/")

(with-open-file (*http-stream* #p "~/workspace/programming/"))
