(defun create-dir-tree (base-dir-pathname dir-tree)
  (if (not (or (symbolp dir-tree)
			   (stringp dir-tree)
			   (listp dir-tree)))
	  (cerror "Enter a directory tree" "The dir-tree should
either be a list (representing the directory structure you are trying to create) or
it should be a string or a symbol (representing a plain file which is not a directory)."))
  (if (or (stringp dir-tree)
		  (symbolp dir-tree))
	  (flet ((create-file (base-dir-pathname filename)
		   (open (make-pathname :name dir-tree :defaults base-dir-pathname)
								 :direction :output :if-exists :error :if-does-not-exist :create)))
		(create-file base-dir-pathname dir-tree))
	  (let ((base-dir-pathname (make-pathname :directory
											(append (pathname-directory base-dir-pathname)
													`(,(car dir-tree)))
											:defaults base-dir-pathname)))
	  (ensure-directories-exist base-dir-pathname)
	  (and (not (null (cdr dir-tree)))
		   (map nil (lambda (dir-tree)
				 (create-dir-tree base-dir-pathname dir-tree)) (cdr dir-tree))))))