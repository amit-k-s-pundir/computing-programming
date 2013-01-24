;(define-class test (class-name "Test")
 ; (x init: 10))

(define-alias JButton javax.swing.JButton)
(define-simple-class HBox (javax.swing.Box)
  ((*init*) (invoke-special javax.swing.Box (this) '*init* 0)))
(define-alias JFrame javax.swing.JFrame)
(define-alias Box javax.swing.Box)

(define value 0)

(define txt
  (javax.swing.JLabel
   text: "0"))

(define (set-value i)
  (set! value i)
  (set! txt:text (number->string i)))

(define fr
  (JFrame
     title: "Hello!"
     (Box 1#|VERTICAL|# ||:
      (javax.swing.Box:createGlue)
      txt
      (javax.swing.Box:createGlue)
      (HBox
       (JButton ;; uses 1-argument constructor
	"Decrement" ;; constructor argument
	tool-tip-text: "decrement"
	action-listener: (lambda (e) (set-value (- value 1))))
       (javax.swing.Box:createGlue)
       (JButton ;; uses 0-argument constructor
	text: "Increment"
	tool-tip-text: "increment"
	action-listener: (lambda (e) (set-value (+ value 1))))))))
(fr:setSize 200 100)
(set! fr:visible #t)
