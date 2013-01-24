(load "utils-file.lisp")

(defun build-gcc (src-dir build-dir)
  (unless (-e build-dir)
    (-c build-dir))
  (with-dir build-dir
    (! "make distclean")
    (with-make-opts '(:prefix "/opt/gcc")))
  
  )

;; Does the system has all the pre-requisites for building gcc?
(defun check-prereqs (&optional prereq-libs)
  (let* ((prereq-libs '("libgmp-dev" "libmpfr-dev" "libmpc-dev"))
         (notinstalled-libs (mapcar #'lib-installed? prereq-libs)))
    (if notinstalled-libs
        (error "The following libs are required but not installed:
~{~A ~}" notinstalled-libs)
        t)
    ))

(defun configure (&optional config-options)
  (and (check-prereqs)
       (! (format nil "./configure ~A" '(config-optionsx)))))

(defun build ()
  (! "make"))

(defun install ()
  (! "make install"))

;; If you ever happen to want to link against installed libraries
;; in a given directory, LIBDIR, you must either use libtool, and
;; specify the full pathname of the library, or use the `-LLIBDIR'
;; flag during linking and do at least one of the following:
;; - add LIBDIR to the `LD_LIBRARY_PATH' environment variable
;; during execution
;; - add LIBDIR to the `LD_RUN_PATH' environment variable
;; during linking
;; - use the `-Wl,-rpath -Wl,LIBDIR' linker flag
;; - have your system administrator add LIBDIR to `/etc/ld.so.conf'

;; See any operating system documentation about shared libraries for
;; more information, such as the ld(1) and ld.so(8) manual pages.

(defun post-install-setup ()
  (>> "/home/sonu/.bash_profile"
  "LD_LIBRARY_PATH=|$GCC_HOME/lib:$LD_LIBRARY_PATH|"
  "LD_RUN_PATH=|$GCC_HOME/lib:$LD_RUN_PATH|"))
