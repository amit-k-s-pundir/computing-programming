(in-package #:shopping-list)

;;(defvar *db* (postmodern:connect db user password host :pooled-p t))
(defvar *user* "sonu")
(defvar *db* "shopping-list-test-db")
(defvar *password* "sonu")
;(defvar *db-connection*)
(init)

(query (format nil "drop table if exists shopping_item cascade ;"))
(query (format nil "drop table if exists shopping_item_details cascade ~
;"))
(query "drop table if exists shopping_list ;")

(query (:create-table shopping-item ((brand :type text)
			     (id :type serial :primary-key t)
			     (name :type text))
	       (:unique brand name)))

(query (:create-table shopping-item-details ((by-when :type date)
					   (expected-price :type
							   money)
					   (note :type text)
					   (quantity :type integer
						     :check (:>
							     'quantity
							     0))
					   (id :type serial
					       :primary-key t)
					   (suggested-shop :type
							  text))))

(query (:create-table shopping-list ((shopping-item-id :type integer
						       :references
						       (shopping-item
							:restrict
						       :cascade))
				     (shopping-item-details-id :type
							       integer 
							       :references
							       (shopping-item-details
								:restrict :cascade)))))

(defparameter *shopping-item-test-data* '((:brand "lipton" :name "tea")
				    (:brand "nescafe" :name "coffee")
				    (:brand "samsung" :name "tv")
				    (:brand "any" :name "ssd")
				    (:brand "hp" :name "notebook") 
				    (:brand "nike" :name "trainers")
				    (:brand "thinkpad" :name
				    "laptop")))

(defparameter *shopping-item-details-test-data* '((:by-when "25-June-2014"
					     :expected-price "250.00"
					     :note "no note"
;					     :purchased "yes"
					     :quantity "250"
					     :suggested-shop
					     "bigbasket"
					     )
					    (:by-when "25-July-2014"
					     :expected-price "350.00"
					     :note "" 
					     ;:purchased "no"
					     :quantity "200"
					     :suggested-shop
					     "smallbasket"
					     )
					    (:by-when "25-June-2014"
					     :expected-price "250000.00"
					     :note "check the latest
					     models before going to
					     the shop" 
;					     :purchased "no"
					     :quantity "1"
					     :suggested-shop
					     "flipkart"
					     )
					    (:by-when "25-July-2014"
					     :expected-price "20000.00" 
					     :note "prefer
					     intel or samsung"
;					     :purchased "no" 
					     :quantity "1" 
					     :suggested-shop "ebay")
					    (:by-when "25-June-2014"
					     :expected-price "250000.00" 
					     :note "try lenovo too"
;					     :purchased "yes"
					     :quantity "1"
					     :suggested-shop
					     "flipkart"
					      )
					    (:by-when "25-July-2014"
					     :expected-price "6000.00"
					     :note "should be suitable
					     for distance running"
;					     :purchased "no" 
					     :quantity "1" 
					     :suggested-shop "nike retail store"
					     )
					    (:by-when "25-June-2014"
					     :expected-price "250000.00" 
					     :note "try hp too"
;					     :purchased "no"
					     :quantity "1"
					     :suggested-shop
					     "flipkart"
					     )))

;; (add (make-instance 'shopping-request :shopping-item
;; 				     (make-instance 'shopping-item
;; 				     :brand "lipton" :name "tea")
;; 				     :shopping-item-details
;; 				     (make-instance
;; 				     'shopping-item-details :by-when
;; 				     :expected-price :note :purchased
;; 				     :quantity :suggested-shop
;; 				     :when-purchased)))


(loop for shopping-item-instance-arglist in *shopping-item-test-data*
   for shopping-item-details-instance-arglist in
     *shopping-item-details-test-data*
   do (add-shopping-request shopping-item-instance-arglist shopping-item-details-instance-arglist))
;;(add-shopping-request (car *shopping-item-test-data*) (car *shopping-item-details-test-data*))

(postmodern:clear-connection-pool)
