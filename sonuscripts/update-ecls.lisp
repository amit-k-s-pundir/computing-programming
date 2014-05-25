(defparameter *ecls-dir* "/opt/sources/lisp/cl/ecls/")
(defparameter *ecl-dir* (concatenate 'string *ecls-dir* "ecl/"))
(defparameter *ecl-doc-dir* (concatenate 'string *ecls-dir*
                                         "ecl-doc"))
(defun build-ecl (&optional (ecl-dir *ecl-dir*))
  (utils::with-dir ecl-dir
    (let* ((config-cmd "make clean && ./configure --prefix=\"/opt/lisp/cl/ecls/\" ")
           (build-cmd "make")
           (install-cmd "make install")
           (cmd (concatenate 'string config-cmd " && " build-cmd " && "
                             install-cmd)))
      (utils::run-shell-cmd cmd))))
