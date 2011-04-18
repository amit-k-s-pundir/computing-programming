#lang racket

(require net/url)
(require xml)

(let ((input-port (get-pure-port 
                   (string->url "http://www.reddit.com/r/programming/"))))
  (display (read-line input-port)))

(xml->xexpr (document-element
             (read-xml (open-input-string
                        "<doc><bold>hi</bold> there!</doc>"))))