(dolist (x '(:cl-fad :cl-ppcre))
  (ql:quickload x))

(defpackage "LIRA-AU"
  (:use "COMMON-LISP" "CL-FAD" "CL-PPCRE"))

(in-package "LIRA-AU")


(defun configure-build-properties-file (psdk-home &key (app-server-home
                                                        #p"/opt/liferay-portal-tomcat-6.0.5/liferay-portal-6.0.5"))
  (let* ((user-name "sonu")
         (build-properties-file (concatenate 'string "build." user-name
                                             ".properties"))
         (build-properties-file-path (merge-pathnames build-properties-file
                                                      app-server-home))
         (new-build-properties-file (concatenate 'string build-properties-file
                                                 ".new"))
         (new-build-properties-file-path (merge-pathnames
                                          new-build-properties-file
                                          app-server-home))
         (regex "^(\w)*app.server.dir=(.*)"))

    (with-open-file (is build-properties-file-path)
      (with-open-file (os new-build-properties-file-path :direction :output)
        (loop for line = (read-line is nil)
           for match = (scan-to-strings regex line) 
           if match return (delete-file new-build-properties-file-path)
           else do (format os "~a~%" line))
        (format os "~a~%" (format nil "app.server.dir=~a~%" app-server-home))))))

                      
    

(defun configure-lira-plugins-sdk (psdk-home)
  (configure-build-properties-file))
