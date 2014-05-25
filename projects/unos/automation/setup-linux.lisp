(in-package :utils)


;; The plan is that, first we try to create the original file-system
;; by using the *directory-backup-stores* or - if needed - creating
;; the required directories manually. Once we have the desired
;; high-level filesystem, we start populating the filesystem from
;; various other backup stores. For example flickr will provide the
;; photos and videos whereas the ~/workspace/ will primarily be filled
;; from dropbox google-code ubuntu-one and github often by importing
;; the repository rather than syncing the folders/files.
(defvar *backup-stores* '(local flickr dropbox ubuntu-one github google-code))
(defvar *dir-repo-url* )
;; These dir-trees will ideally be generated and populated from the
;; backup store.
(defvar *dir-structure-overlay* '((workspace (programming ))))

(defclass backup-store ()
  ((url :initform nil :initarg :url)))

(defmethod restore-from ((x (eql :dropbox)) &optional (dropbox
  backup-store))
  (let ((dropbox-url (or (backup-store url)
			 #p "~/Dropbox/"))
	(cmd (format t "rsync -avz ~a ~a" dropbox-url "/")))
    (utils::! cmd)))

(defmethod initialize ((x (eql :filesystem)) *backup-store* &optional
							   restore-fn)
  (unless (restore-from *backup-store*)
    (funcall restore-fn)))

;; If we are unable to restore from any of the *backup-store* in
;; *backup-stores* then we use restore-fn as the option of last
;; resort. For example, when user sees that none of the *backup-stores*
;; is working then he can -probably interactively-  provide restore-fn
;; to create a desirable directory structure.
(defmethod setup ((x (eql :linux)) &optional restore-fn)
  )
