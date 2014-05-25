;; (defpackage :utils
;;   (:use :cl))

(in-package :sonu-utils)

;; (defmacro defprog (util &rest keys)
;;   `(defun ,util (args &rest keys)
;; 	 (sb-ext:run-program (symbol-name ',util)
;; 						 args :search t :wait
;;   t :output *standard-output*)))

;; ;; Goes in the dir, executes the shell cmd and then returns to the original dir.
;; (defmacro with-dir-shell-cmd (dir cmd)
;;   (let ((od (sb-posix:getcwd)))
;;     (unwind-protect
;;          (progn
;;            (sb-posix:chdir dir)
;;            (run-shell-cmd cmd))
;;       (sb-posix:chdir od))))

;; ;; (run-shell-cmd "gvim")
;; (defun run-shell-cmd (cmd)
;;   (let ((prog "/bin/bash")
;;         (args  `("-c" ,cmd)))
;;     (sb-ext:run-program prog args  :search t :wait t :output
;;                         *standard-output*)))
;; Alias for (run-shell-cmd cmd)
(defun ! (cmd)
  (sonu-utils::run-shell-cmd cmd))


