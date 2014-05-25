(setq row '(("name" "tea") ("brand" ("lipton" "tetley" "twinings" "tata" "others"))
	    ("quantity" (100g 250g 500g 1000g)) ("purchased" nil)
	    ("from-where" nil) ("by-when" "1-1-13") ("when-purchased"
						     "2-10-13")
	    ("expected-price" (50R 100R)) ("real-price" 100R)
	    ("suggested-shop" "bigbasket") ("actual-shop"
					    "healthkart")))

(defun gen-sql (table row)
  (let ((key-list '())
	(value-list '()))
    (format nil "insert into ~a ~[~]a values ~a" table key-list value-list))
  (flet)
  (let ((prefix (format nil "insert into ~a values (" table))
	(suffix (format nil ");"))
	(body (let ((keys '())
		    (values '()))
		(string-right-trim " ," (with-output-to-string (s)
					  (loop for (key value) in row
					     collect key in keys
					     when (stringp value)
					     collect value in values
					     when (listp value)
					     collect (fomrat nil
							     "array ~{~a,
  ~}")
					     ;;  do (cond
  ;; 						  ((stringp value)
  ;; 						   (string-right-trim
  ;; 						    ", "  (format s
  ;; 								  "'~a'," value)))
  ;; 						  ((null value) (format
  ;; 								 s "'NULL', "))
  ;; 						  ((symbolp value)
  ;; 						   (format s "'~a', " (string-downcase (symbol-name value))))
                                         ;; 						  ((listp value)
  ;; 						   (format s
  ;; 							   "'{#\"~a#\"~{,
  ;; #\"~a#\"~}}' " (car value) (cdr value))))
					       ))))))
 ;   (format t "Body: ~a~%" body)
;    (break)
    (format nil "~<~a~:@>" (concatenate 'string prefix body suffix))))

(format t (gen-sql "TestTable" data))

(loop for key = (car data)
   for value = (cadr data)
   for data = (cddr data)
   do (format t "Key: ~s Value: ~s" key value))

(cddr data)


