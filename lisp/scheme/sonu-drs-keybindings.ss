#lang scheme
(module schemekeys-keymap
  (lib "keybinding-lang.ss" "framework")
  (require (lib "tool-lib.ss" "drscheme"))

  (define (sendsnip e s)
    (let ([snip (make-object string-snip% s)])
      (send snip set-flags '(hard-newline))
      (send e insert snip (string-length s) 0)))

(keybinding ":m:/" (lambda (editor event)
                     (sendsnip editor 
