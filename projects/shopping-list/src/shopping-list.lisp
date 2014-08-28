(in-package :cl-user)

(defpackage #:shopping-list
  (:use :cl :sonu-utils :cl-ppcre :cl-fad :cl-who :hunchentoot :optima
  :parenscript :postmodern)
  (:export #:add
	   #:get
	   #:remove
	   #:update))

(in-package #:shopping-list)

(defvar *db* "shopping-list-test-db")
(defvar *user* "sonu")
(defvar *password* "sonu")
(defvar *database*)

(defun setup-db-connection (&optional (db *db*) (user *user*) (password *password*) (host "127.0.0.1"))
  (unless *database*
    (setf *database* (postmodern:connect db user password host
					      :pooled-p t :port 5433))))

(defun init ()
  (setup-db-connection))

;; Identifies a *shopping-item*
(defclass shopping-item ()
  ((brand :initarg :brand :initform null :accessor shopping-item-brand)
;   (id :initarg :id :initform null)
   (name :initform null :initarg :name :accessor shopping-item-name))
  (:metaclass postmodern:dao-class ))

;p; Details about a *shopping-item*; probably used for anlalytics and analysis later
(defclass shopping-item-details ()
  (;(actual-shop :col-type string :initarg :actual-shop :accessor :actual-shop)
   (by-when :col-type date :initarg :by-when :accessor shopping-item-details-by-when)
   (expected-price :col-type money :initarg :expected-price :accessor shopping-item-details-expected-price)
					;   (from-where :col-type string :initarg :from-where :accessor :from-where)e
   (note :col-type string :initarg :note :accessor shopping-item-details-note)
;   (purchased :col-type bool :initarg :purchased :accessor :purchased)
   (quantity :col-type integer :initarg :quantity :accessor shopping-item-details-quantity)
  ; (real-price :col-type int :initarg :real-price :accessor :real-price)
   (suggested-shop :col-type string :initarg :suggested-shop :accessor shopping-item-details-suggested-shop)
 ;  (when-purchased :col-type date :initarg :when-purchased :accessor
 ;  :when-purchased))
   )
  (:metaclass postmodern:dao-class))

;; A *shopping-list* is a collection of all *shopping-request*s of a *user*
(defclass shopping-request ()
  ((shopping-item :initarg :shopping-item :accessor shopping-request-shopping-item)
   (shopping-item-details :initarg :shopping-item-details :accessor shopping-request-shopping-item-details))
  (:metaclass postmodern:dao-class)
;  (:keys shopping-item)
)

;; The main UI for registering a request for shopping something
(defmethod add ((shopping-request shopping-request))
  (with-slots (shopping-item shopping-item-details) shopping-request
    (add shopping-item)
    (add shopping-item-details)
    (let ((shopping-item-id (caar (postmodern:query (:select 'id :from
							     'shopping-item
							     :where
							     (:and 
							      (:=
							       'brand
							       (shopping-item-brand
								shopping-item))
							      (:= 'name
								 (shopping-item-name
								  shopping-item)))))))
	  (shopping-item-details-id (caar (postmodern:query (:select
							     'id :from
							     'shopping-item-details
							     :where
							     (:and (:=
								    'by-when
								    (shopping-item-details-by-when 
								     shopping-item-details))
								   (:=
								    'expected-price
								    (shopping-item-details-expected-price
								     shopping-item-details))
								   (:=
								    'note
								    (shopping-item-details-note
								     shopping-item-details))
								   (:=
								    'quantity
								    (shopping-item-details-quantity
								     shopping-item-details))
								   (:=
								    'suggested-shop
								    (shopping-item-details-suggested-shop
								     shopping-item-details))))))))
      (format t "shopping-item-id:~a~% shopping-item-details-id:~a~%"
	      shopping-item-id shopping-item-details-id)
      (postmodern:query (:insert-into 'shopping-list
				      :set 'shopping-item-id
				      shopping-item-id
				      'shopping-item-details-id
				      shopping-item-details-id)))))
	  

;; Register a *shopping-item* in the database of *shopping-item*s. This is useful for later analytics
(defmethod add ((shopping-item shopping-item))
  (with-slots (brand name) shopping-item
    (let ((query (format nil "insert into shopping_item (brand, name) ~
values ('~a', '~a');" brand name)))
      (postmodern:query query))))

(defmethod add ((shopping-item-details shopping-item-details))
  (with-slots (by-when expected-price note 
		       quantity suggested-shop)
      shopping-item-details
    (let ((query (format nil "insert into shopping_item_details ~
  (by_when, expected_price, note, quantity, suggested_shop) ~
  values  ('~a', '~a', '~a', '~a', '~a')" by-when expected-price note
  quantity suggested-shop)))
      (postmodern:query query))))

;; A utility function
(defun add-shopping-request (shopping-item-instance-arglist
			     shopping-item-details-instance-arglist)
  (let* ((shopping-item-instance (apply #'make-instance 'shopping-item
					shopping-item-instance-arglist))
	 (shopping-item-details-instance (apply #'make-instance
						'shopping-item-details
						shopping-item-details-instance-arglist))
	 (shopping-request-instance (make-instance 'shopping-request
						   :shopping-item
						   shopping-item-instance
						   :shopping-item-details
						   shopping-item-details-instance)))
    (add shopping-request-instance)
					;    (add shopping-item-instance)
					;    (add shopping-item-details-instance)
    ))

;; Remove an earlier registered *shopping-request*
(defmethod sl.remove ((shopping-request shopping-request))
  (let* ((shopping-item-id (shopping-item-id (shopping-item
					      shopping-request)))
	 (shopping-item-details-id (shopping-item-details-id
				    (shopping-item-details
				     shopping-request)))
	 (query (format nil "delete from ~s where shopping-item-id = ~s ~
and shopping-item-details-id = ~s" table shopping-item-id
shopping-item-details-id)))
    (postmodern:query query)))

(defmethod sl.get ((x (eql 'shopping-list)) &optional (user-id *userId*))
  "Returns the shopping list of the user with *userId*"
  (let ((query (sql (:select '* :from  '*shopping-list*))))
    (postmodern:query query)))


(defmethod sl.remove ((shopping-item shopping-item))
  )

(defmethod update ((shopping-request shopping-request))
  )

(defmethod update ((shopping-request shopping-request))
  )

(defmethod update ((shopping-item shopping-item))
  )

(defmethod update ((shopping-item-details shopping-item-details))
  )

;; (defun add-shopping-item (use fer shopping-item shopping-list)
;;   "*user* add a *shopping-item* to her *shopping-list*")

;; (defun remove-shopping-item (user shopping-item shopping-list)
;;   "*user* removes the *shopping-item* from the *shopping-list*")
;; (defun add-shoppable-item (item item-list)
;;   "Add a shoppable *item* to the *item-list* - a datastore of interesting shoppable items.
;; Please note that the *item-list* is differnt from a *user*'s *shopping-list*. A *shopping-list*
;; is a list of *item*s that a *user* wants to purchase whereas an *item-list* is a super set of
;; *shopping-list* and is a collection of items from which items can be quickly selected for shopping
;; in addition to the other items supplied by the user. Also note that the new items supplied by the
;; user for shopping are automatically added to the *item-list* by definition.")
;; (defun remove-shoppable-item (item item-list)
;;   "Removes a shoppable *item* from the *item-list*. This is the counterpart to the *add-item* function.
;; See that function for further details.")
;; (defun get-shoppable-list ()
;;   "Returns the full list of all shoppable items. 
;; See *add-item* for important details about *item-list*.")
;; (defun get-item (item-id))
;; (defun list-items ())

;; (format t "~a~%" "sonu")
;; (defun gen-sql (x))
