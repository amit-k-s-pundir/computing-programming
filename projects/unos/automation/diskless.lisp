(defpackage #:sonu.automation.diskless
  (:nicknames "diskless"))

(in-package "diskless")

(defun setup-diskless-server ()
  (and (setup-dhcp)
       (setup-tftp))
