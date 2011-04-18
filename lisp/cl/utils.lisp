(in-package :cl-user)
;(find-package "util")
;(describe "in-package")

;(require "/opt/lisp/cl/clbuild/source/sbcl/contrib/asdf/asdf.lisp")
;(require "/opt/lisp/cl/clbuild/source/sbcl/contrib/asdf-install/asdf-install.lisp")
;; (setf asdf:*central-registry*
;; 	  (list* '*default-pathname-defaults*
;; 			 #p "/opt/lisp/cl/clbuild/systems/"
;; 			 #p "/home/sonu/cl/systems/"
;; 			 #p "/usr/share/common-lisp/systems/"
;; 			 asdf:*central-registry*))
;; (asdf:oos 'asdf:load-op :asdf-binary-locations) 
;; (defun asdf-load-packages (packages)
;;   (loop for package in packages
;; 	   do (asdf:oos 'asdf:load-op package) ))
;; (asdf-load-packages '(:asdf-binary-locations :cl-who :cl-ppcre :parenscript))

(defpackage "utils"
  (:use :cl :asdf :parenscript :cl-who :cl-ppcre ))
(in-package "utils")
;(use-package :cl-who)
;(use-package :parenscript)
;*default-pathname-defaults*
*package*

(defparameter *base-dir* (merge-pathnames (make-pathname :directory (concatenate 'list (pathname-directory (user-homedir-pathname))
																				 '("workspace" "programming" "lisp" "cl" )))))
(defparameter *current-dir* *base-dir*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Work area;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq work-file (ensure-directories-exist (merge-pathnames (make-pathname :directory (concatenate 'list (pathname-directory *base-dir*)
																								  '("test")) :name "test" :type "html")
														   *base-dir*)))
(setq *current-dir* (merge-pathnames (make-pathname :directory (concatenate 'list (pathname-directory *base-dir*)
																			  '("test")))
									   *base-dir*))


(with-open-file (s work-file :direction :output :element-type :default :if-exists :append
				   :if-does-not-exist :create )
  (cl-who:with-html-output (s)                                                                                               
  (loop for (link . title) in '(("http://zappa.com/" . "Frank Zappa")                                                      
                                ("http://marcusmiller.com/" . "Marcus Miller")                                               
                                ("http://www.milesdavis.com/" . "Miles Davis"))                                                            
        do (cl-who:htm (:a :href link                                                                                                             
                  (:b (cl-who:str title)))                                                                                                        
                :br))))

(with-open-file (s work-file :direction :output :element-type :default :if-exists :append
				   :if-does-not-exist :create )
				   (with-html-output (s)
					 (:table :border 0 :cellpadding 4                                                                                                         
							 (loop for i below 25 by 5                                                    
								do (htm                                                                                                                           
									(:tr :align "right"                                                
										 (loop for j from i below (+ i 5)                                                                                             
											do (htm                                                     
												(:td :bgcolor (if (oddp j)                                                                                         
																  "pink"                                  
																  "green")                                                                                           
													 (fmt "~@R" (1+ j)))))))))))
  
                                 
(parenscript:ps-html ((:a :href "foobar") "blorg"))
*js-inline-string-delimiter*



;;;;;;;;;;;;;fad utilities;;;;;;;;;;;;;;;;;;;;;;

(defun make-directory-tree ( tree)
  (let ((current-dir-pn (car tree)))
	(mapcar (lambda (x)))))

;; Like Perl's split function.
(defun split (s test))
