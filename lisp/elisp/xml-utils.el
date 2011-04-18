;;; xml-utils.el --- Some utilities to generate x(ht)ml files.

;; Copyright (C) 2011 Free Software Foundation, Inc.
;;
;; Author: Amit K S Pundir <sonu@localhost>
;; Maintainer: Amit K S Pundir <sonu@localhost>
;; Created: 15 Apr 2011
;; Version: 0.01
;; Keywords

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;; 

;; Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'xml-utils)

;;; Code:

(eval-when-compile
  (require 'cl))

(defun gen-default-xhtml-file ()
  (let ((default-xhtml-header "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE html  PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">")
        (default-xhtml-namespace-decl "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\">")
        (default-content "<head>
    <title></title>
  </head>
  <body>
    <p></p>
  </body>
</html>"))
    (insert default-xhtml-header 
            ;(newline-and-indent)
            "\n"
            default-xhtml-namespace-decl 
            ;(newline-and-indent)
            "\n"
            default-content)))


(provide 'xml-utils)
;;; xml-utils.el ends here
