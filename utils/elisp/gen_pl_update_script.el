;;; gen_pl_update_script.el --- Generates a generic update script in Perl.

;; Copyright (C) 2011 Free Software Foundation, Inc.
;;
;; Author: Amit K S Pundir <sonu@localhost>
;; Maintainer: Amit K S Pundir <sonu@localhost>
;; Created: 22 Mar 2011
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
;;   (require 'gen_pl_update_script)

;;; Code:

(eval-when-compile
  (require 'cl))

(defun gen-perl-update-script (download-url &optional script-name base-dir)
  (interactive)
  


(provide 'gen_pl_update_script)
;;; gen_pl_update_script.el ends here
