(in-package #:home-server)

(query "drop table if exists documents cascade ;")

(query :create-table documents ((name :type text)
				(registeration-date :type date)
				(file-path :type text)
				(open-with :type text)
				(note :type text)
				(id :type serial :primary-key t)
				(sub-category :type text)
					;				(sub-category-id :type integer)
				))

;; (query :create-table programming-documents (()))

;; (query :create-table lisp-programming-documents ())

;; (query :create-table cl-lisp-programming-documents ())

;; (query :create-table scheme-lisp-programming-documents ())

;; (query :create-table c-programming-documents ())

;; (query :create-table c++-programming-documents ())

;; (query :create-table assembly-programming-documents ())

;; (query :create-table architecture-programming-documents ())

;; (query :create-table linux-programming-documents ())

;; (query :create-table general-programming-documents ())

;; (query :create-table graphics-programming-documents ())

;; (query :create-table ai-programming-documents ())

(defvar *schema* '(documents ((name :type text)
			      (registeration-date :type date)
			      (file-path :type text)
			      (open-with :type text)
			      (note :type text)
			      (id :type serial :primary-key t)
			      (sub-category :type text)
					;				(sub-category-id :type integer)
			      )
		   (or (computing () (or (programming () (or
							  (programming-languages
							   ()
							   (or  (lisp ()) (candcpp ())
								(assembly
								 ())
								(perl ())))
							  (architecture
							   ()
							   (or
							    (general ())
							    (ia
							     ())
							    (mips
							     ()) (arm ())))
							  (linux
							   ())
							  (system
							   ())
							  (web
							   ())
							  (emacs
							   ())
							  (networking ())
							  (ai
							   ())
							  (graphics
							   ())
							  (opengl
							   ())))
					 (ai ())
					 (architecture ())
					 (general ())
					 (graphics ())
					 (linux ())
					 (networking ())
					 (numerics ())
					 (security ())
					 (system-admin ())            
					 ))
		    (personal ())
		    (work ()))))

(defun schema->postmodern (schema)
  (let ((query '()))
    (labels ((helper (schema)
	       (loop
		  for schema-head = (pop  schema)
;		    while schema
		  do
		    (cond
		      ((symbolp schema-head)
		       (let ((slots (pop schema)))
			 (setq query  (append query `((:create-table ,schema-head ,slots))))))
		      ((and (listp schema-head)
			    (eql 'or (car schema-head)))
		       (let ((schemas (cdr schema-head)))
			 (dolist (schema schemas)
			   (helper schema)
			   ))))
		  while
		    schema)))
      (helper schema))
    query))
	   ;; 	       ((null schema)
;; 		'()
;; 					;       (return-from schema->postmodern query)
;; 		)
;; 	       ((symbolp (car schema))
;; 		(let ((table-name (pop schema))
;; 		      (slots (pop schema)))
;; 		  (append `((:create-table ,table-name ,slots))
;; 			  (helper schema))))
;; 	       ((and (listp (car schema))
;; 		     (eql 'or (caar schema)))
;; 		(progn			;(format t "~a~%" schema)
;; 		  (let* ((or-part (pop schema))
;; 			 (schemas (cdr or-part)))
;; 		    (append (mapcar (lambda (x)
;; 				      (helper x)) schemas)
;; 			    (helper schema))
;; 					;		(break)
;; 		    ;; (dolist (schema schemas query)
;; 		    ;;   (format t "~s~%" query)
;; 		    ;;   (schema->postmodern schema))
	   ;p)))))))))
	   
;; (defun schema->postmodern (schema)
;;   (labels ((helper (schema)
;; 	     (cond
;; 	       ((null schema)
;; 		'()
;; 					;       (return-from schema->postmodern query)
;; 		)
;; 	       ((symbolp (car schema))
;; 		(let ((table-name (pop schema))
;; 		      (slots (pop schema)))
;; 		  (append `((:create-table ,table-name ,slots))
;; 			  (helper schema))))
;; 	       ((and (listp (car schema))
;; 		     (eql 'or (caar schema)))
;; 		(progn			;(format t "~a~%" schema)
;; 		  (let* ((or-part (pop schema))
;; 			 (schemas (cdr or-part)))
;; 		    (append (mapcar (lambda (x)
;; 				      (helper x)) schemas)
;; 			    (helper schema))
;; 					;		(break)
;; 		    ;; (dolist (schema schemas query)
;; 		    ;;   (format t "~s~%" query)
;; 		    ;;   (schema->postmodern schema))
;; 		    ))))))
;;     (cons 'progn (helper schema))))
	     
    
    
    ;; (if (not (eql (car schema) 'or))
    ;; 	(error
    ;; (cond ((eql head  'or)
    ;; 	   (dolist (schema (cdr schema))
    ;; 	     (schema->postmodern schema)))
    ;; 	  (t
    ;; 	   (error "Not a proper schema")))))

(defun schema->postmodern (schema)
  (let ((os))
    (with-output-to-string (s)
      (format s "create-table ~a  ((document-id :type serial) (subcategory :type text"))))

(defun execute (schema)
  "Executes the given schema - a tree - to generate postmodern sql
  queries.
It just generates the code corresponding to the outline of the schema
  in the form of the tables that the schema contains and their
  inter-relationship. One still would need to fill it with the
  required attributes for each table. It would be easy to add the code
  for specifying and generating the attributes as well but it would
  clutter the schema specification unbearably"
  )
  
