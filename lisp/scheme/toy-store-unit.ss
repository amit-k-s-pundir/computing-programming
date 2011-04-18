; In "toy-store-unit.ss":
  #lang scheme
  
  (require "toy-store-sig.ss"
           "toy-factory-sig.ss")
  
  (define-unit toy-store@
    (import toy-factory^)
    (export toy-store^)
  
    (define inventory null)
  
    (define (store-color) 'green)
  
    (define (maybe-repaint t)
      (if (eq? (toy-color t) (store-color))
          t
          (repaint t (store-color))))
  
    (define (stock! n)
      (set! inventory
            (append inventory
                    (map maybe-repaint
                         (build-toys n)))))
  
    (define (get-inventory) inventory))
  
  (provide toy-store@)