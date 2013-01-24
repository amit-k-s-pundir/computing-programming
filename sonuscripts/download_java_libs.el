(require 'wget)

(setq urls '())

(wget-uri "http://www.springbyexample.org/pdf/SpringByExample.pdf" "/opt/downloads/" '("-cN"))
