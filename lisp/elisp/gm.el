;;; gm.el --- Utilities for Greasemonkey coding.

;; Copyright (C) 2011 Free Software Foundation, Inc.
;;
;; Author: Amit K S Pundir <sonu@localhost>
;; Maintainer: Amit K S Pundir <sonu@localhost>
;; Created: 17 Mar 2011
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
;;   (require 'gm)

;;; Code:

(eval-when-compile
  (require 'cl))

(defun write-gm-header-in-place (name namespace description includes excludes 
                                      &optional header)
  (interactive)
  (flet ((list-to-string (ls sub1)
                         (let ((result '()))
                           (dotimes (i (length ls) (apply 'concat result))
                             (setq result (append result (list (format "// @%s		  %s\n" sub1 (pop
                                                                                              ls)))))))))
    (insert (concat (format "// ==UserScript==\n// @name		  %s\n// @namespace     \
%s\n//\ @description   %s\n" name namespace description)
            (list-to-string includes "include") (list-to-string excludes
                                                                "exclude")
            "// ==/UserScript==\n"))))

(provide 'gm)
;;; gm.el ends here
