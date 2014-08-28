(in-package #:shopping-list)

(defmethod display ((target (eql :web)) shopping-list)
  (with-html-output (*http-stream*)
    (loop for shopping-request in shopping-list
       for shopping-item = (shopping-request-shopping-item
			    shopping-request)
       for shopping-item-details =
	 (shopping-request-shopping-item-details shopping-request)
