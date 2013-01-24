(defpackage :apache-utils)

(in-package :apache-utils)

;;;; (write-apache-module module) -> output
;;;; module : module?
;;;; output : string?
(defmethod write :before ((apmo apache-module))
  (let ((include-headers-list (apache-module-include-headers apmo)))
    (gen-include-headers include-headers-list))
;  (write-apmo-header)                   ; First write the apache module (apmo,
                                        ; from now on) header.
 ; (write-apmo-body)
  ;(write-apmo-footer)
  )

(defmethod write :after ((apmo apache-module))
  (gen-epilogue apmo))

(defmethod write ((apmo apache-module))
  (gen-body apmo))

(defclass apache-module ()
  ((name :initarg name)))

(defun write-apmo-header ()
  )
(defun gen-apache-module (name)
  (gen-apmo-header)
  (gen-apmo-body)
  (gen-apmo-footer))

; ; (write-header headers) -> output
;; headers : (listof string?)
;; output : string?
(defun write-header (headers)
  (join headers))

;; Joins a list of string into a single string interpolating the argument
;; string.
;; (join headers field-separator)
;; headers : (listof string?)
;; field-separator : (or char? string? function?)
(defun join (seq &optional (field-separator (string " ")))
  (let ((field-separator
         (typecase field-separator
           (character (string field-separator))
           (string ))))))
(defun gen-header (headers)
    (gen-headers headers))
 
(defun gen-apmo-header (headers)
  "Generates the header for a generic apache module."
  (gen-c-headers (car headers))
  (gen-cpp-headers (cadr headers))
  (dolist (header-name headers)
    ))

;; (gen-c-headers headers) -> output
;; headers : (listof string?)
;; output : (listof string?) 
(defun gen-c-headers (headers)
  (dolist (header headers output)
    (push (gen-c-header header) output)))

(defun gen-c-header (header)
  (format nil "~&include \"~A.h\";" header ))

;; (gen-cpp-headers headers) -> output

(defun gen-cpp-headers (headers)
  (mapcar (lambda (header)
            (format nil "~&include <~A>;" header)) headers))
