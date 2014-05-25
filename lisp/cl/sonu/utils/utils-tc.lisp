(defpackage :tc
  (:use :utils-project))

(defmethod setup ((project tc-project) &optional
						  (download-dir #p "/opt/downloads/")
										;(downloads (list-of path-specifier-p))
						  (downloads `(,@(concatenate (tc-project-name project) ".jar"))))
  (let((project-base-dir (project-base-dir project)))
	
	(call-next-method project download-dir downloads)
	(loop for)
	(cp (append downloads (if (listp project-base-dir) project-base-dir
							   (list project-base-dir))))
	(dolist (x downloads)
	  (jar-to-zip x)
	  (unzip x))
	))

(defclass tc-project (project)
  ((base-dir :initform #p "/home/sonu/workspace/projects/tc/"
			 :initarg :base-dir :accessor project-base-dir)))

(defclass tc-des-project (tc-project)
  ((base-dir :initform #p "/home/sonu/workspace/projects/tc/design/"
			 :initarg :base-dir :accessor project-base-dir))
  )

(defclass tc-assembly-project (tc-project)
  ()
  )

(defclass tc-arch-project (tc-project)
  ()
  )

(defclass tc-dev-project (tc-project)
  ()
  )

(defclass tc-bugfixes-project (tc-project)
  ()
  )

