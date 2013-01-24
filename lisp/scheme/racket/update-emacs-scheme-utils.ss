#lang racket
(define (update-quack-el-mode (url "http://www.neilvandyke.org/quack/quack.el"))
  (let* ((download-cmd (string-append "wget -N -c " url))
        (update-quack-el-mode-file (lambda ()
                                     (system download-cmd)
                                     (update-installation)))
        (download/update url (lambda (url)
                               (system download-cmd)))
        (update-installation (lambda (downloaded-file)
                               (let ((temp-dir-name (gensym url)))
                                 (mkdir temp-dir-name)
                                 (cd temp-dir-name)
                                 (copy-file downloaded-file 
        (do-this (lambda ()
                   (update-quack-el-mode-file)
                   (update-dot-emacs)))
    (with-dir dir 
  (display "sonu"))


