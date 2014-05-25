(in-package #:shopping-list)

(defvar *db*)

(defun setup-db-connection (&optional (db *db*) (user *user*) (password *password*) (host *host*))
  (unless *db*
    (setf *db* (postmodern:connect db user password host :pooled-p t))))


(defun init ()
  (setup-db-connection))

;; Identifies a *shopping-item*
(defclass shopping-item ()
  ((brand :initarg :brand :initform null)
;   (id :initarg :id :initform null)
   (name :initform null :initarg :name)))

;; Details about a *shopping-item*; probably used for anlalytics and analysis later
(defclass shopping-item-details ()
  (;(actual-shop :col-type string :initarg :actual-shop :accessor :actual-shop)
   (by-when :col-type date :initarg :by-when :accessor :by-when)
   (expected-price :col-type int :initarg :expected-price :accessor :expected-price)
					;   (from-where :col-type string :initarg :from-where :accessor :from-where)e
   (note :col-type string :initarg :note :accessor :note)
   (purchased :col-type bool :initarg :purchased :accessor :purchased)
   (quantity :col-type integer :initarg :quantity :accessor :quantity)
  ; (real-price :col-type int :initarg :real-price :accessor :real-price)
   (suggested-shop :col-type string :initarg :suggested-shop :accessor :suggested-shop)
   (when-purchased :col-type date :initarg :when-purchased :accessor :when-purchased)
   (shopping-item-id :col-type key :accessor :shopping-item-id)))

;; A *shopping-list* is a collection of all *shopping-request*s of a *user*
(defclass shopping-request ()
  ((shopping-item :initarg :shopping-item :accessor :shopping-item)
   (shopping-item-details :initarg :shopping-request :accessor :shopping-request))
  (:metaclass dao-class)
  (:keys shopping-item))

;; The main UI for registering a request for shopping something
(defmethod add-shopping-request ((shopping-request shopping-request))
  (with-slots (shopping-item by-when expected-price note purchased
			     quantity suggested-shop) shopping-request
    (

;; Remove an earlier registered *shopping-request*
(defun remove-shopping-request ())

(defun get-shopping-list (&optional (user-id *userId*))
  "Returns the shopping list of the user with *userId*"
  (let ((query (sql (:select '* :from  '*shopping-list*))))
    (postmodern:query query)))

;; Register a *shopping-item* in the database of *shopping-item*s. This is useful for later analytics
(defun register-shopping-item (shopping-item))

(defun remove-registered-shopping-item (shopping-item))

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
