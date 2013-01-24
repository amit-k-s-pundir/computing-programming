(defvar *info-intro*
  "This software provides some essential/critical details about your
  local system - particularly, the local lisp system - which are often
  difficult to remember properly but are almost always needed to
  develop a non-trivial system in lisp.")

(defclass asdf-info ()
  ((default-dir-for-installation :initform
  "/home/sonu/.local/share/common-lisp/source/")
   (source-registry-conf-dir :initform "/home/sonu/.config/common-lisp/source-registry.conf.d/"))
  )

(defmethod add-dir-to-asdf-search-path (asdf-info asdf-info)
  
