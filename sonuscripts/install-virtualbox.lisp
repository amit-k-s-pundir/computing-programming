(in-package :sonu.scripts)

(defvar *download-url-for-i386*
  "http://download.virtualbox.org/virtualbox/4.3.8/virtualbox-4.3_4.3.8-92456~Ubuntu~raring_i386.deb")

(defvar *download-url-for-amd64*
  "http://download.virtualbox.org/virtualbox/4.3.8/virtualbox-4.3_4.3.8-92456~Ubuntu~raring_amd64.deb")

(defvar *download-dir* "/opt/downloads")

(defgeneric get-install (target &key download-url download-dir install-dir &allow-other-keys))
  
(defmethod get-install ((target (eq 'virtualbox)) &key (download-url
							*download-url-for-amd64*) (download-dir *download-dir*) (install-dir
														 *install-dir*))  
  (with-dir *download-dir*
    (download *download-url-for-amd64*)
    (with-dir *install-dir*
      (install *downloaded-package*))))

(defun download/wget (url &optional (download-dir download-dir-p (current-dir))
			    (wget-options wget-options-p))
  (with-dir download-dir
    (wget wget-options url)))

(defun install (item &optional (install-dir (current-dir)))
  (rsync rsync-options item install-dir))
  
