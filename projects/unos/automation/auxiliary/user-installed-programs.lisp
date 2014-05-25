(defvar *user-installed-programs*)

(defvar *user-installed-essentials*)
(setf *user-installed-essentials* '("aptitude" "perl-doc" "nfs-utils"))

(defvar *user-installed-general-tools*)
(setf *user-installed-general-tools* '("wordnet" "guvcview"))

(defvar *user-installed-dev-tools*)
(setf *user-installed-dev-tools* '("apache" "postgres" "systemtap"))

(defvar *user-installed-system-tools*)
(setf *user-installed-system-tools* '("system-tap"))

(defvar *user-installed-networking-tools*)
(setf *user-installed-networking-tools* '("open-ssh"))

(defvar *user-installed-entertainment-tools*)
(setf *user-installed-entertainment-tools* '("vlc"))

(setf *user-installed-programs* (append *user-installed-essentials*
					*user-installed-general-tools*
					*user-installed-networking-tools*
					*user-installed-system-tools*
					*user-installed-dev-tools*
					*user-installed-entertainment-tools*)

