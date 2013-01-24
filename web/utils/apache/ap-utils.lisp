(defun gen-ap-output-filter-file (&optional filter-name)
  "Generates a skeletal C source file for a generic output-filter module for
apache2."
  (add-generic-ap-filter-headers)
  (generic-header)
  (generic-body)
  (generic-footer))
