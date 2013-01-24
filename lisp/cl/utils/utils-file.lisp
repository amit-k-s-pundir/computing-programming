;(defpackage :utils)

(in-package :utils)

;; Returns T if the file-name exists.
(defun -e (file-name)
  (probe-file file-name))

;; Creates the file file-name if it doesn't already exist.
(defun -c (file-name)
  (with-open-file (s file-name :direction :output :if-exists :error)
    (format s "~%")))

(defmacro with-dir (dir &body forms)
  `(progn
     (pushd ,dir)
     ,@forms
     (popd)))

(defvar *dir-stack* '())

(defun pushd (dir)
  (let ((od (sb-posix:getcwd)))
    (push od *dir-stack*)
    (sb-posix:chdir dir)))

(defun popd ()
  (let ((dir (pop *dir-stack*)))
    (sb-posix:chdir dir)))
