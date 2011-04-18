 #!/usr/local/bin/csi -script
 ;;;; chickendoc - By Michele Simionato, Ed Watkeys and felix
(use regex)
 (require-extension regex utils)

 (define home
   (if (string>=? (chicken-version) "1.85")
       (chicken-home)
       (or (getenv "CHICKEN_HOME")
           "/usr/local/share/chicken") ) )

 (define chicken-manual (make-pathname home "doc/chicken.html"))
 (define default-browser (or (getenv "BROWSER") "mozilla -remote 'openurl(%%)'"))
 (define default-url (string-append "file://" chicken-manual))
 (define pattern (regexp "href=(#(index-)?[[^+])"))

 (define (any-file-line pred fname)
   (let* ((port
           (open-input-file fname))
          (result
           (letrec
               ((loop
                 (lambda ()
                   (let ((line (read-line port)))
                     (if (eof-object? line)
                         #f
                         (or (pred line) (loop)))))))
                (loop)))
          (close-input-port port))
          result))

 (define (get-link cmd file)
   (if cmd
       (let ((command (string-append "<code>" cmd)))
        (any-file-line (lambda (line)
                         (if (substring-index command line)
                             (let ((result (string-search pattern line)))
                               (if result (cadr result) #f))
                             #f))
                       file))
       #f))

 (define (browse browser url)
   (let ([[s (substring-index "%%" browser))
     (system
      (if s 
          (string-substitute "%%" url browser)
          (string-append browser   url ) ) ) ) )

 (define (main . args)
   (let-optionals args
       ((cmd #f) (browser default-browser))
     (if cmd
         (let ((link (get-link cmd chicken-manual)))
           (if link
               (browse browser (string-append default-url link))
               (write-line (sprintf Command ~A not found. cmd))))
         (print "Usage: browsedoc COMMAND [BROWSER]") ) ) )

 (apply main (command-line-arguments))

if you want to call the tool from emacs, this does the trick:

 (defun run-chickendoc ()
   (interactive)
   (start-process "chickendoc" *Messages*
                  "/usr/local/bin/chickendoc" ; path to the script
                  (symbol-name (symbol-at-point))))

 (global-set-key [f7] 'run-chickendoc)
