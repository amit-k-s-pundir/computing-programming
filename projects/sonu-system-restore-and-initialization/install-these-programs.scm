(use-modules (ice-9 textual-ports))
(use-modules (ice-9 regex))
(use-modules (ice-9 format))

(define lisps '((cl (sbcl ("git://git.code.sf.net/p/sbcl/sbcl"
                           "https://github.com/sbcl/sbcl.git") ())
                    (clozure ("https://github.com/Clozure/ccl.git") ()))
                (scheme (guile) (chez
                                 ("https://github.com/cisco/ChezScheme.git")
                                 ())
                        (chicken
                         ("https://github.com/alaricsp/chicken-scheme.git")
                         ())
                        (racket
                         ("https://github.com/racket/racket.git") ()))))
;;; both the following definitions of with-dir macro are correct,
;;; choose any one of them

;; (define-syntax with-dir
;;   (syntax-rules ()
;;     ((_ dir e ...)
;;      (let ((orig-dir (getcwd)))
;;        (chdir dir)  
;;        (let ((result    e ...))
;;          (chdir orig-dir)
;;          result)))))

(define-syntax with-dir
  (syntax-rules ()
    ((_ dir e ...)
     (let ((orig-dir (getcwd))
        (result '()))
       (chdir dir)  
       (set! result   (begin e ...))
         (chdir orig-dir)
result))))
2
(define (number-of-files-in dir)
  (let ((dir-port (opendir dir)))
        (do ((dirent (readdir dir-port) (readdir dir-port))
         (count 0 (1+ count)))
            ((eof-object? dirent) (- count 2)))))

(define install/stable-binary (lambda (download-url
                                       downloaded-file-name  #:optional
                                                    base-dir work-dir install-fn)
                                (let* ((base-dir (or base-dir
                                                    "/opt/downloads"))
                                      (work-dir (or work-dir
                                                    (string-append
                                                     base-dir w ))))
                                  (with-dir base-dir
                                            (let ((downloaded-file
                                                   (get-url
                                                    download-url)))
                                              (if install-fn
                                                  (install-fn downloaded-file)
                                                  (let ((temp-dir
                                                         (mktemp)))
                                                    (extract
                                                     downloaded-file
                                                     temp-dir)
                                                    (if (and  (equal?
                                                               (number-of-files-in
                                                                temp-dir 1)))))))
      bh                                            ))))


(define s-regex "The most recent version of SBCL is ([0-9]+\\.[0-9]\\.[0-9]),")

;; (define extract-version/sbcl-stable-binary (lambda (port)
;;                                              (letrec ((s  (get-line
;;                                                                  port))
;;                                                       (result
;;                                                           (if (string?
;;                                                                s) (string-match
;;                                                                    s-regex
;;                                                                    s))))
;;                                                (if result
;;                                                    (match:substring
;;                                                     result)
;;                                                    (extract-version/sbcl-stable-binary
;;                                                     port)))))

(define extract-version/sbcl-stable-binary (lambda (port)
                                             (let loop ((s (get-line
                                                            port)))
                                               (if (not (string? s))
                                                   #f
                                                   (let ((m
                                                          (string-match
                                                           s-regex
                                                           s)))
                                                     (if m
                                                          (match:substring
                                                                     m 1)
                                                         (loop (get-line
                                                            port))))))))

(define get-latest-version/sbcl-stable-binary (lambda ()
                                                (with-dir "/opt/downloads"
                                                          ;; (system
;;                                                            "wget \\
;; http://sbcl.org/platform-table.html")
                                                          (call-with-input-file
                                                              "platform-table.html"
                                                            extract-version/sbcl-stable-binary))))


(define install-sbcl/stable-binary (lambda ()
                                     (let ((download-url (format #f
                                                                 "http://downloads.sourceforge.net/project/sbcl/sbcl/1.3.8/sbcl-~a-x86-64-linux-binary.tar.bz2?r=&ts=1472273740&use_mirror=nchc"
                                                                 (get-latest-version/sbcl-stable-binary)))
                                           (file-name (format #f
                                                              "sbcl-~a-x86-64-linux-binary.tar.bz2"
                                                              (get-latest-version/sbcl-stable-binary))))
                                       (with-dir "/opt/downloads/"
                                                 (system (format #f
                                                                 "wget ~
z -O ~a -c ~a" file-name download-url))
                                                 (system (format #f  "tar jxvf ~a" file-name))))))

;; (define install-these-lisps (lambda* (#:optional (lisps lisps))
;;                               (unless (null? lisps)
;;                                  (letrec ((lisps-item (car lisps))
;;                                          (lisp-type (car lisps-item))]
;;                                          (lisp-name (car (car (cdrhb
;;                                                                lisp-item))))
;;                                          (source-repos (car (cdr (car
;;                                                                   (cdr
;;                                                                    lisp-item)))))
;;                                          (stable-sources (cadr (cdr
;;                                                                 (cadr lisp-item)))))))
;;                               (let* loop ((x (car lisps))
;;                                           (y )))
;;                               (do ((x (car lisps) (car lisps))))
;;                               ))

