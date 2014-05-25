(in-package :utils)

(defvar *url*
  "http://www.w3.org/html/wg/drafts/html/master/single-page.html")

(defvar *work-dir* #p "/home/sonu/programming_docs/html")

(defmethod update-html (&optional (url *url*)  (work-dir  *work-dir*))
  (let ((cmd (format nil "wget -EN -ckp ~a" url)))
    (with-dir work-dir
      (! cmd))))
