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

(defvar *schema* '(documents (or (computing (or (programming (or (programming-languages (lisp) (candcpp)
											(assembly) (perl))
								 (architecture (general)
									       (ia) (mips) (arm))
								 (linux) (system) (web)
								 (emacs) (networking)
								 (ai) (graphics
								       (opengl))))
						(ai)
						(architecture)
						(general)
						(graphics)
						(linux)
						(networking)
						(numerics)
						(security)
						(system-admin)
						))
			      (personal)
			      (work))))

(defmacro schema->postmodern (schema)
  (let ((table-name (car schema))
	(schema (cadr schema)))
    (if (not (eql (car schema) 'or))
	(error
    (cond ((eql head  'or)
	   (dolist (schema (cdr schema))
	     (schema->postmodern schema)))
	  (t
	   (error "Not a proper schema")))))

(defun schema->postmodern (schema)
  (let ((os))
    (with-output-to-string (s)
      (format s "create-table ~a  ((document-id :type serial) (subcategory :type text)))

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
  
