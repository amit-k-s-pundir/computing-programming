;(asdf-load-packages '(:asdf-binary-locations :cl-who :cl-ppcre :parenscript :cl-fad :mcclim ))

(defpackage "utils"
;  (:use :cl :asdf :parenscript :cl-who :cl-ppcre :cl-fad :clim :clim-lisp)
;  (:use  :parenscript :cl-who :cl-ppcre :cl-fad )
  (:use :cl )
;  (:export #:app-main))
  (:export #:app-main))

(in-package "utils")

;; (define-application-frame superapp ()
;;   ()
;;   (:pointer-documentation t)
;;   (:panes
;;     (app :application :display-time t :height 300 :width 600)
;;     (int :interactor :height 200 :width 600))
;;   (:layouts
;;     (default (vertically () app int))))

;; (defun app-main ()
;;   (run-frame-top-level (make-application-frame 'superapp)))
;; (define-superapp-command (com-quit :name t) ()
;;   (frame-exit *application-frame*))
;; (define-presentation-type name-of-month ()
;;   :inherit-from 'string)
;; (define-presentation-type day-of-month ()
;;   :inherit-from 'integer)
;; (define-superapp-command (com-out :name t) ()
;;   (with-output-as-presentation (t "The third month" 'name-of-month)
;;     (format t "March~%"))
;;   (with-output-as-presentation (t 15 'day-of-month)
;;     (format t "fifteen~%")))
;; (define-superapp-command (com-get-date :name t)
;;     ((name 'name-of-month) (date 'day-of-month))
;;   (format (frame-standard-input *application-frame*)
;;   "the ~a of ~a~%" date name))

;; (app-main )

*package*

(defmacro define-lisp-shell-util (util &rest keys)
  `(defun ,util (args &rest keys)
	 (sb-ext:run-program (string-downcase (symbol-name ',util))
						 args :search t :wait t :output *standard-output*)))

(defun make-directory-tree (base-dir dir-tree)
  (if (not (directory-p base-dir))
		(error "~<The first argument ~S should be a valid pathname specifier for a ~
directory:>" '( base-dir)))
  (if (or (symbolp dir-tree)
		  (stringp dir-tree))
		(create-file (join-dir-file base-dir dir-tree))
		(let ((base-dir (join-dir-dir base-dir (car dir-tree))))
		  (ensure-directories-exist base-dir)
		  (if (not (null (cdr dir-tree)))
			  (mapcar (lambda (x)
						(make-directory-tree base-dir x)) (cdr dir-tree))))))

(defun create-file (namestring)
  (with-open-file (s namestring :direction :output :if-exists :append
					 :if-does-not-exist :create)))

(defun directory-p (directory)
  (and (pathname directory) 
	   (not (string= (directory-namestring directory) ""))))

(defun join-dir-file (dir file)
  (pathname (concatenate 'string (namestring dir) (namestring file))))

(defun join-dir-dir (base-dir rel-dir)
  (pathname (concatenate 'string (namestring base-dir) (namestring rel-dir))))


(defparameter *current-dir* *base-dir*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Work area;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq work-file (ensure-directories-exist (merge-pathnames
										   (make-pathname :directory
														  (concatenate
														   'list
														   (pathname-directory *base-dir*)
														   '("test")) :name "test" :type
														   "html")
										   *base-dir*)))

(setq *current-dir* (merge-pathnames (make-pathname :directory
													(concatenate
													 'list
													 (pathname-directory
													  *base-dir*)
													 '("test")))
									 *base-dir*))


(with-open-file (s work-file :direction :output :element-type :default
				   :if-exists :append
				   :if-does-not-exist :create )
  (cl-who:with-html-output (s)
	(loop for (link . title) in
		 '(("http://zappa.com/" . "Frank Zappa")
		   ("http://marcusmiller.com/" . "Marcus Miller")
		   ("http://www.milesdavis.com/" . "Miles Davis"))
	   do (cl-who:htm (:a :href link (:b (cl-who:str title)))
					  :br))))

(with-open-file (s work-file :direction :output :element-type :default
				   :if-exists :append
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

(make-directory-tree "/home/sonu/workspace/programming/" '("flex/" "ImageLoader.as" "Spinning3dOceon.as"))

(define-lisp-shell-util /usr/bin/gvim )
(define-lisp-shell-util ls )
(define-lisp-shell-util wget )
(define-lisp-shell-util aptitude)
(define-lisp-shell-util touch)
(wget '("www.google.com"))
(ls nil)
(/usr/bin/gvim '())

(defmacro write-js (file &body js)
  `(let ((javascript (progn ,@js)))
	 (with-open-file (s ,file :direction :output :if-exists :append :if-does-not-exist :create )
	   (format s " ~<~A~:@>" `(,,'javascript)))))

(macroexpand-1  '(write-js #p "/home/sonu/workspace/test/test.js"
				  (ps (array 2))))
(write-js #p "/home/sonu/workspace/test/test.js"
		   (ps (array 2)))

(progn (ps (array 2)))

;;; Take care of the :pty argument; it might gobble up all the output!
(setq program (sb-ext:run-program "/bin/ls" '("/home/sonu/workspace/")  :error :stream :if-error-exists :error
								  :status-hook nil :wait nil :input :stream
								  :if-input-does-not-exist :error :output #p "/home/sonu/sbcltmp"
								  :if-output-exists :append :search t))
(sb-ext:process-kill program 9 :pid)

(read-char-no-hang (sb-ext:process-output program))

(with-open-file (s #p "/home/sonu/sbcltmp" :direction :input )
    (loop
	   with ls = (multiple-value-list (read-line s))
	 while (null (second ls))
	   collect	   (format nil (car ls))))

(with-open-file (s #p "/home/sonu/sbcltmp" :direction :input )
    (loop
		 repeat 5
		 do (format t "sonu")
	   append (multiple-value-list (read-line s)) into x
		 finally (return x)))

;;;;;;;;;;;;;;;;;;;work;;;;;;;;;;;;;;;;;;
(defun backup/email (files email-address)
  (loop
	   for file in files
	   do (email file email-address)))

(defun email (file backup-message email-address &opt email-fn &rest email-args)
  (cl-smtp:send-email "smtp.gmail.com" "sonupundir@gmail.com" "sonupundir@gmail.com" backup-message nil
					  :ssl tls :authentication '(:login "sonupundir" "a19m15i14t21")))
;;;;;;;;;;;;;;;;;;endwork;;;;;;;;;;;;;;;

;work;

(defjavafaces ()
	(map-facesservlet-instance)
  (create-pages)
  (define-page-navigation app-config-resource-file)
  (generate-backing-beans)
  (add-managed-beans-decls app-config-resource-file))

(defservlet (&key display-name servlet-name servlet-class load-on-startup-p url-pattern)
	(ps-html ((:servlet)
			  ((:display-name) (ps-inline :display-name))
			  ((:servlet-name) (ps-inline :servlet-name))
			  ((:servlet-class) (ps-inline :servlet-class))
			  ((:load-on-startup) (ps-inline :load-on-startup-p)))
			 (:servlet-mapping )
			 ((:servlet-name ) (ps-inline :servlet-name))
			 ((:url-pattern ) (ps-inline :url-pattern))))

(defun map-javafaces-servlet ()
  )


(defmethod setup-project ((project project))
  (ensure-directories-exist project-basedir)
  (make-directory-tree project-basedir project-dirtree))

(defclass project ()
  ((basedir :initarg :basedir :initform #p "./" )
   (dirtree :initarg :dirtree )))


(defmethod setup-project ((project Greasemonkey))
  )

;;Thu Dec 17 21:33:23 IST 2009
(with-open-file (s #p "~/workspace/projects/tc/assembly/presentation_engine_layout_module_architecture_1_0/draft.java" :direction :output :if-exists :append :if-does-not-exist :create)
  (loop for x in ))

(in-package :sb-mop )
(defclass java-std-class (standard-class)
  ((:kind :initform 0 :initarg :kind)))

(defclass java-test ()
  ((name :initform 0 :reader java-test-name))
  (:metaclass java-std-class)
  (:kind name :reader java-test-kind))

(defmethod validate-superclass
           ((class java-std-class)
            (superclass standard-class))
  t)

(setq x (make-instance 'java-test))

(java-test-kind x)

(defclass ordered-class (standard-class)
     ((slot-order :initform ()
                  :initarg :slot-order
                  :reader class-slot-order)))

(defmethod compute-slots ((class ordered-class))
  (let ((order (class-slot-order class)))
    (sort (copy-list (call-next-method))
          #'(lambda (a b)
              (< (position (slot-definition-name a) order)
                 (position (slot-definition-name b) order))))))

(defclass point ()
     ((x :initform 0)
      (y :initform 0))
  (:metaclass ordered-class)
  (:slot-order x y))


(defun distance (point) (sqrt (/ (+ (expt (standard-instance-access point 0) 2)
									(expt (standard-instance-access point 1) 2)) 2.0)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun posix-to-sbcl-getcwd ()
  (let ((p (sb-posix:getcwd)))
		   (make-pathname :directory (append (pathname-directory p)
											 `(,(pathname-name p)))
						  :name nil)))

