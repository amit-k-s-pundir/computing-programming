;;;;Home Server;;;;
;;The purpose of home-server is to serve as the central point to offer
;;server facility for the functionality that can make use of it and is
;;intended primarily form my own personal use.
;;
;;Currently it offers the facilities to manage and serve:
;;1) Documents: where documents is restriceted to mean only the static
;;files as opposed to the *media* files. It will use various critirea
;;(defined by me of course) to classify the documents.
;;2) Media: It will serve both audio and video media. Just like
;;documents, it will use various criterea to classify and tag the
;;media files.

;;Architecture: Some points about the architecture. Lately I have
;;increasingly been gravitating towards the good old client-server
;;model of architecture as opposed to the one monolithic app. This
;;provides a very useful sort of decoupling in addition to opening up
;;the possibilities of greater flexibility within the architecture
;;itself. The client side of the app can be run on any node while one
;;can consolidate the most important functionality in the server using
;;the tools and techniques of one's own choice without any worries
;;about the hardware/software configuration at the client site and
;;without any worries about updating it!

(in-package :cl-user)

(defpackage #:unos.automation.home-server
  (:nicknames #:home-server)
  (:use :cl :cl-ppcre :osicat :postmodern :iolib :cl-fad))

(in-package :home-server)

;; (defgeneric list-documents (&key document-type sort-by &allow-other-keys)
;;   "Lists all the documents currently registered with the server where
;;   documents are static non-media files")


;;(list 'documents 'programming-books 'rating :filter
;;(do-not-belong-to 'java))
(defun list (what? subtype sort-by &allow-other-keys)

(defgeneric add-documents (&key
