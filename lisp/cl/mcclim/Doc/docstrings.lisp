;;; -*- Mode: Lisp -*-

;;;; A docstring extractor for arbitrary CL systems, cribbed from
;;;; SBCL. Creates @include-ready documentation from the docstrings of
;;;; exported symbols of specified packages.

;;;; Written by Rudi Schlatte <rudi@constantly.at>, mangled by
;;;; Nikodemus Siivola, brought to McCLIM by Troels Henriksen.

;;;; TODO
;;;; * Verbatim text
;;;; * Quotations
;;;; * Method documentation untested
;;;; * Method sorting, somehow
;;;; * Index for macros & constants?
;;;; * This is getting complicated enough that tests would be good
;;;; * Nesting (currently only nested itemizations work)
;;;; * doc -> internal form -> texinfo (so that non-texinfo format are also
;;;;   easily generated)

;;;; FIXME: The description below is no longer complete. This
;;;; should possibly be turned into a contrib with proper documentation.

;;;; Formatting heuristics (tweaked to format SAVE-LISP-AND-DIE sanely):
;;;;
;;;; Formats SYMBOL and `symbol' as @code{symbol} if SYMBOL exists in
;;;; the current package, or @var{symbol} if symbol is in the argument
;;;; list of the defun / defmacro.
;;;;
;;;; Lines starting with * or - that are followed by intented lines
;;;; are marked up with @itemize.
;;;;
;;;; Lines containing only a SYMBOL that are followed by indented
;;;; lines are marked up as @table @code, with the SYMBOL as the item.

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require 'sb-introspect))

(defpackage :cl-docextractor
  (:use :cl :sb-mop :cl-ppcre)
  (:shadow #:documentation)
  (:export #:documentee #:document)
  (:documentation
   "Tools to generate Texinfo documentation from docstrings."))

(in-package :cl-docextractor)

(defclass documentee ()
  ((%name :accessor name
          :initarg :name
          :type string
          :initform "Unnamed"
          :documentation "The name of the thing to be
documented.")
   (%output-directory :accessor output-directory
                      :initarg :output-directory
                      :type pathname
                      :initform (error "An output directory must be provided"))
   (%packages :accessor packages
              :initarg :packages
              :initform '()
              :documentation "The packages to extract docstrings from.")
   (%ignored-packages :accessor ignored-packages
                      :initarg :ignored-packages
                      :initform '()
                      :documentation "A list of packages whose
contents will be ignored when printing class-precedence-lists.")
   (%output-filetype :accessor output-filetype
                     :initarg :filetype
                     :initform "texinfo"
                     :documentation "The file type used for the
output files."))
  (:documentation "A `documentee' is a set of packages to create
Texinfo documentation from, a number of rules describing how to
parse the docstrings and an output pathname."))

;;;; various specials and parameters

(defvar *texinfo-output*)
(defvar *texinfo-variables*)
(defvar *documentation-package*)

(defvar *verbose-output* t
  "If true, print status information to `*standard-output*' while
running.")

(defparameter *documentee* nil
  "Bound to the `documentee' object currently being worked on.")

(defparameter *documentation-types*
  '(compiler-macro
    function
    method-combination
    setf
    ;;structure  ; also handled by `type'
    type
    variable)
  "A list of symbols accepted as second argument of `documentation'")

(defparameter *character-replacements*
  '((#\* . "star") (#\/ . "slash") (#\+ . "plus")
    (#\< . "lt") (#\> . "gt"))
  "Characters and their replacement names that `alphanumize' uses. If
the replacements contain any of the chars they're supposed to replace,
you deserve to lose.")

(defparameter *characters-to-drop* '(#\\ #\` #\')
  "Characters that should be removed by `alphanumize'.")

(defparameter *texinfo-escaped-chars* "@{}"
  "Characters that must be escaped with #\@ for Texinfo.")

(defparameter *itemize-start-characters* '(#\* #\-)
  "Characters that might start an itemization in docstrings when
  at the start of a line.")

(defparameter *symbol-characters* "ABCDEFGHIJKLMNOPQRSTUVWXYZ*:-+&"
  "List of characters that make up symbols in a docstring.")

(defparameter *symbol-delimiters* " ,.!?;")

(defparameter *ordered-documentation-kinds*
  '(package type structure condition class macro))

;;;; utilities

(defun flatten (list)
  (cond ((null list)
         nil)
        ((consp (car list))
         (nconc (flatten (car list)) (flatten (cdr list))))
        ((null (cdr list))
         (cons (car list) nil))
        (t
         (cons (car list) (flatten (cdr list))))))

(defun whitespacep (char)
  (find char #(#\tab #\space #\page)))

(defun setf-name-p (name)
  (or (symbolp name)
      (and (listp name) (= 2 (length name)) (eq (car name) 'setf))))

(defgeneric specializer-name (specializer))

(defmethod specializer-name ((specializer eql-specializer))
  (list 'eql (eql-specializer-object specializer)))

(defmethod specializer-name ((specializer class))
  (class-name specializer))

(defun specialized-lambda-list (method)
  ;; courtecy of AMOP p. 61
  (let* ((specializers (method-specializers method))
         (lambda-list (method-lambda-list method))
         (n-required (length specializers)))
    (append (mapcar (lambda (arg specializer)
                      (if  (eq specializer (find-class 't))
                           arg
                           `(,arg ,(specializer-name specializer))))
                    (subseq lambda-list 0 n-required)
                    specializers)
           (subseq lambda-list n-required))))

(defun required-arguments (lambda-list)
  "Return the required arguments of `lambda-list'. Will not work
if &env or the like is the first parameter."
  (loop for parameter in lambda-list
       until (find parameter lambda-list-keywords)
       collecting parameter))

(defun string-lines (string)
  "Lines in STRING as a vector."
  (coerce (with-input-from-string (s string)
            (loop for line = (read-line s nil nil)
               while line collect line))
          'vector))

(defun indentation (line)
  "Position of first non-SPACE character in LINE."
  (position-if-not (lambda (c) (char= c #\Space)) line))

(defun docstring (x doc-type)
  (cl:documentation x doc-type))

(defun flatten-to-string (list)
  (format nil "~{~A~^-~}" (flatten list)))

(defun alphanumize (original)
  "Construct a string without characters like *`' that will f-star-ck
up filename handling. See `*character-replacements*' and
`*characters-to-drop*' for customization."
  (let ((name (remove-if (lambda (x) (member x *characters-to-drop*))
                         (if (listp original)
                             (flatten-to-string original)
                             (string original))))
        (chars-to-replace (mapcar #'car *character-replacements*)))
    (flet ((replacement-delimiter (index)
             (cond ((or (< index 0) (>= index (length name))) "")
                   ((alphanumericp (char name index)) "-")
                   (t ""))))
      (loop for index = (position-if #'(lambda (x) (member x chars-to-replace))
                                     name)
         while index
         do (setf name (concatenate 'string (subseq name 0 index)
                                    (replacement-delimiter (1- index))
                                    (cdr (assoc (aref name index)
                                                *character-replacements*))
                                    (replacement-delimiter (1+ index))
                                    (subseq name (1+ index))))))
    name))

(defun format-status (format-string &rest args)
  (when *verbose-output*
    (apply #'format t format-string args)))

;;;; generating various names

(defgeneric name (thing)
  (:documentation "Name for a documented thing. Names are either
symbols or lists of symbols."))

(defmethod name ((symbol symbol))
  symbol)

(defmethod name ((cons cons))
  cons)

(defmethod name ((package package))
  (package-name package))

(defmethod name ((method method))
  (list
   (generic-function-name (method-generic-function method))
   (method-qualifiers method)
   (specialized-lambda-list method)))

(defgeneric short-name (thing)
  (:documentation "Short name for a documented thing. Short names
are either symbols or lists of symbols. The short name is meant
to be the shortest uniquely distinguishing name for THING, and is
used for such things as file- and node-names."))

(defmethod short-name ((thing t))
  (name thing))

(defmethod short-name ((method method))
  (list
   (generic-function-name (method-generic-function method))
   (method-qualifiers method)
   (mapcar #'(lambda (arg)
               (if (listp arg)
                   (second arg)
                   arg))
           (required-arguments (specialized-lambda-list method)))))

;;; Node names for DOCUMENTATION instances

(defgeneric name-using-kind/name (kind name doc))

(defmethod name-using-kind/name (kind (name string) doc)
  (declare (ignore kind doc))
  name)

(defmethod name-using-kind/name (kind (name symbol) doc)
  (declare (ignore kind))
  (format nil "~A:~A" (package-name (get-package doc)) name))

(defmethod name-using-kind/name (kind (name list) doc)
  (declare (ignore kind))
  (assert (setf-name-p name))
  (format nil "(setf ~A:~A)" (package-name (get-package doc)) (second name)))

(defmethod name-using-kind/name ((kind (eql 'method)) name doc)
  (format nil "~A~{ ~A~} ~A"
          (name-using-kind/name nil (first name) doc)
          (second name)
          (third name)))

(defun node-name (doc)
  "Returns TexInfo node name as a string for a DOCUMENTATION instance."
  (let ((kind (get-kind doc)))
    (format nil "~:(~A~) ~(~A~)" kind (name-using-kind/name kind (get-name doc) doc))))

;;; Definition titles for DOCUMENTATION instances

(defgeneric title-using-kind/name (kind name doc))

(defmethod title-using-kind/name (kind (name string) doc)
  (declare (ignore kind doc))
  name)

(defmethod title-using-kind/name (kind (name symbol) doc)
  (declare (ignore kind))
  (format nil "~A:~A" (package-name (get-package doc)) name))

(defmethod title-using-kind/name (kind (name list) doc)
  (declare (ignore kind))
  (assert (setf-name-p name))
  (format nil "(setf ~A:~A)" (package-name (get-package doc)) (second name)))

(defmethod title-using-kind/name ((kind (eql 'method)) name doc)
  (format nil "~{~A ~}~A"
          (second name)
          (title-using-kind/name nil (first name) doc)))

(defun title-name (doc)
  "Returns a string to be used as name of the definition."
  (string-downcase (title-using-kind/name (get-kind doc) (get-name doc) doc)))

(defun include-pathname (doc)
  (let* ((kind (get-kind doc))
         (name (nstring-downcase
                (if (eq 'package kind)
                    (format nil "package-~A" (alphanumize (get-name doc)))
                    (format nil "~A-~A-~A"
                            (case (get-kind doc)
                              ((function generic-function) "fun")
                              (structure "struct")
                              (variable "var")
                              (method "method")
                              (otherwise (symbol-name (get-kind doc))))
                            (alphanumize (package-name (get-package doc)))
                            (alphanumize (get-short-name doc)))))))
    (make-pathname :name name :type (output-filetype *documentee*))))

;;;; documentation class and related methods

(defclass documentation ()
  ((name :initarg :name :reader get-name)
   (short-name :initarg :short-name :reader get-short-name)
   (kind :initarg :kind :reader get-kind)
   (string :initarg :string :reader get-string)
   (children :initarg :children :initform nil :reader get-children)
   (package :initform *documentation-package* :reader get-package)))

(defmethod print-object ((documentation documentation) stream)
  (print-unreadable-object (documentation stream :type t)
    (princ (list (get-kind documentation) (get-name documentation)) stream)))

(defgeneric make-documentation (x doc-type string))

(defmethod make-documentation ((x package) doc-type string)
  (declare (ignore doc-type))
  (make-instance 'documentation
                 :name (name x)
                 :short-name (short-name x)
                 :kind 'package
                 :string string))

(defmethod make-documentation (x (doc-type (eql 'function)) string)
  (declare (ignore doc-type))
  (let* ((fdef (and (fboundp x) (fdefinition x)))
         (name x)
         (kind (cond ((and (symbolp x) (special-operator-p x))
                      'special-operator)
                     ((and (symbolp x) (macro-function x))
                      'macro)
                     ((typep fdef 'generic-function)
                      (assert (or (symbolp name) (setf-name-p name)))
                      'generic-function)
                     (fdef
                      (assert (or (symbolp name) (setf-name-p name)))
                      'function)))
         (fundoc (when string
                   (make-instance 'documentation
                                  :name (name x)
                                  :short-name (short-name x)
                                  :string string
                                  :kind kind)))
         (methoddocs (when (eq kind 'generic-function)
                       (collect-gf-documentation fdef))))
    (if fundoc
        (list* fundoc methoddocs)
        methoddocs)))

(defmethod make-documentation ((x method) doc-type string)
  (declare (ignore doc-type))
  (make-instance 'documentation
                 :name (name x)
                 :short-name (short-name x)
                 :kind 'method
                 :string string))

(defmethod make-documentation (x (doc-type (eql 'type)) string)
  (make-instance 'documentation
                 :name (name x)
                 :short-name (short-name x)
                 :string string
                 :kind (etypecase (find-class x nil)
                         (structure-class 'structure)
                         (standard-class 'class)
                         (sb-pcl::condition-class 'condition)
                         ((or built-in-class null) 'type))))

(defmethod make-documentation (x (doc-type (eql 'variable)) string)
  (make-instance 'documentation
                 :name (name x)
                 :short-name (short-name x)
                 :string string
                 :kind (if (constantp x)
                           'constant
                           'variable)))

(defmethod make-documentation (x (doc-type (eql 'setf)) string)
  (declare (ignore doc-type))
  (make-instance 'documentation
                 :name (name x)
                 :short-name (short-name x)
                 :kind 'setf-expander
                 :string string))

(defmethod make-documentation (x doc-type string)
  (make-instance 'documentation
                 :name (name x)
                 :short-name (short-name x)
                 :kind doc-type
                 :string string))

(defgeneric maybe-documentation (x doc-type)
  (:documentation "Returns a list of DOCUMENTATION instances for
X and DOC-TYPE, or NIL if there is no corresponding docstring."))

(defmethod maybe-documentation (x doc-type)
  (let ((docstring (docstring x doc-type)))
    (when docstring
      (let ((documentation (make-documentation x doc-type docstring)))
        (if (listp documentation)
            documentation
            (list documentation))))))

(defmethod maybe-documentation (x (doc-type (eql 'generic-function)))
  (let ((documentation (make-documentation
                        x doc-type (docstring (docstring x doc-type) doc-type))))
    (if (listp documentation)
        documentation
        (list documentation))))

(defun lambda-list (doc)
  (case (get-kind doc)
    ((package constant variable type structure class condition nil)
     nil)
    (method
     (third (get-name doc)))
    (t
     ;; KLUDGE: Eugh.
     ;;
     ;; believe it or not, the above comment was written before CSR
     ;; came along and obfuscated this.  (2005-07-04)
     (when (or (symbolp (get-name doc))
               (setf-name-p (get-name doc)))
       (labels ((clean (x &key optional key)
                  (typecase x
                    (atom x)
                    ((cons (member &optional))
                     (cons (car x) (clean (cdr x) :optional t)))
                    ((cons (member &key))
                     (cons (car x) (clean (cdr x) :key t)))
                    ((cons cons)
                     (cons
                      (cond (key (if (consp (caar x))
                                     (caaar x)
                                     (caar x)))
                            (optional (caar x))
                            (t (clean (car x))))
                      (clean (cdr x) :key key :optional optional)))
                    (cons
                     (cons
                      (cond ((or key optional) (car x))
                            (t (clean (car x))))
                      (clean (cdr x) :key key :optional optional))))))
         (clean (sb-introspect:function-arglist (get-name doc))))))))

(defun documentation< (x y)
  (let ((p1 (position (get-kind x) *ordered-documentation-kinds*))
        (p2 (position (get-kind y) *ordered-documentation-kinds*)))
    (if (or (not (and p1 p2)) (= p1 p2))
        (string< (string (get-name x)) (string (get-name y)))
        (< p1 p2))))

;;;; turning text into texinfo

(defun escape-for-texinfo (string &optional downcasep)
  "Return STRING with characters in *TEXINFO-ESCAPED-CHARS* escaped
with #\@. Optionally downcase the result."
  (let ((result (with-output-to-string (s)
                  (loop for char across string
                        when (find char *texinfo-escaped-chars*)
                        do (write-char #\@ s)
                        do (write-char char s)))))
    (if downcasep (nstring-downcase result) result)))

(defun empty-p (line-number lines)
  (and (< -1 line-number (length lines))
       (not (indentation (svref lines line-number)))))

;;; line markups

(defun locate-symbols (line)
  "Return a list of triples with elements (start-index end-index
symbol-name) of symbol-like parts of LINE."
  (let (result)
    (do-scans (start end starts ends
                     "(`.*?')|[^A-z-*]+?([A-Z-]+)[^A-z-]+?" line
                     (nreverse result))
      (let ((realstart (find-if #'identity starts :from-end t))
            (realend (find-if #'identity ends :from-end t)))
        (push (list realstart realend
                    ;; Remove any markers.
                    (string-trim "`'" (subseq line realstart realend)))
              result)))))

(defun texinfo-line (line)
  "Format symbols in LINE texinfo-style: either as code or as
variables if the symbol in question is contained in symbols
*TEXINFO-VARIABLES*."
  (declare (optimize (debug 3)))
  (with-output-to-string (result)
    (let ((last 0))
      (dolist (symbol/index/name (locate-symbols line))
        (write-string (subseq line last (first symbol/index/name)) result)
        (let ((symbol-name (third symbol/index/name)))
          (if (or (find-symbol symbol-name *documentation-package*)
                  (find-symbol (string-upcase symbol-name) *documentation-package*))
              (format result (if (member symbol-name *texinfo-variables*
                                         :test #'stringp)
                                 "@var{~A}"
                                 "@code{~A}")
                      (string-downcase symbol-name))
              (write-string symbol-name result)))
        (setf last (second symbol/index/name)))
      (write-string (subseq line last) result))))

;;; lisp sections

(defun lisp-section-p (line line-number lines)
  "Returns T if the given LINE looks like start of lisp code --
ie. if it starts with whitespace followed by a paren or
semicolon, and the previous line is empty"
  (let ((offset (indentation line)))
    (and offset
         (plusp offset)
         (find (find-if-not #'whitespacep line) "(;")
         (empty-p (1- line-number) lines))))

(defun collect-lisp-section (lines line-number)
  (let ((lisp (loop for index = line-number then (1+ index)
                    for line = (and (< index (length lines)) (svref lines index))
                    while (indentation line)
                    collect line)))
    (values (length lisp) `("@lisp" ,@lisp "@end lisp"))))

;;; itemized sections

(defun maybe-itemize-offset (line)
  "Return NIL or the indentation offset if LINE looks like it starts
an item in an itemization."
  (let* ((offset (indentation line))
         (char (when offset (char line offset))))
    (and offset
         (member char *itemize-start-characters* :test #'char=)
         (char= #\Space (find-if-not (lambda (c) (char= c char))
                                     line :start offset))
         offset)))

(defun collect-maybe-itemized-section (lines starting-line)
  ;; Return index of next line to be processed outside
  (let ((this-offset (maybe-itemize-offset (svref lines starting-line)))
        (result nil)
        (lines-consumed 0))
    (loop for line-number from starting-line below (length lines)
       for line = (svref lines line-number)
       for indentation = (indentation line)
       for offset = (maybe-itemize-offset line)
       do (cond
            ((not indentation)
             ;; empty line -- inserts paragraph.
             (push "" result)
             (incf lines-consumed))
            ((and offset (> indentation this-offset))
             ;; nested itemization -- handle recursively
             ;; FIXME: tables in itemizations go wrong
             (multiple-value-bind (sub-lines-consumed sub-itemization)
                 (collect-maybe-itemized-section lines line-number)
               (when sub-lines-consumed
                 (incf line-number (1- sub-lines-consumed)) ; +1 on next loop
                 (incf lines-consumed sub-lines-consumed)
                 (setf result (nconc (nreverse sub-itemization) result)))))
            ((and offset (= indentation this-offset))
             ;; start of new item
             (push (format nil "@item ~A"
                           (texinfo-line (subseq line (1+ offset))))
                   result)
             (incf lines-consumed))
            ((and (not offset) (> indentation this-offset))
             ;; continued item from previous line
             (push (texinfo-line line) result)
             (incf lines-consumed))
            (t
             ;; end of itemization
             (loop-finish))))
    ;; a single-line itemization isn't.
    (if (> (count-if (lambda (line) (> (length line) 0)) result) 1)
        (values lines-consumed `("@itemize" ,@(reverse result) "@end itemize"))
        nil)))

;;; table sections

(defun tabulation-body-p (offset line-number lines)
  (when (< line-number (length lines))
    (let ((offset2 (indentation (svref lines line-number))))
      (and offset2 (< offset offset2)))))

(defun tabulation-p (offset line-number lines direction)
  (let ((step  (ecase direction
                 (:backwards (1- line-number))
                 (:forwards (1+ line-number)))))
    (when (and (plusp line-number) (< line-number (length lines)))
      (and (eql offset (indentation (svref lines line-number)))
           (or (when (eq direction :backwards)
                 (empty-p step lines))
               (tabulation-p offset step lines direction)
               (tabulation-body-p offset step lines))))))

(defun maybe-table-offset (line-number lines)
  "Return NIL or the indentation offset if LINE looks like it starts
an item in a tabulation. Ie, if it is (1) indented, (2) preceded by an
empty line, another tabulation label, or a tabulation body, (3) and
followed another tabulation label or a tabulation body."
  (let* ((line (svref lines line-number))
         (offset (indentation line))
         (prev (1- line-number))
         (next (1+ line-number)))
    (when (and offset (plusp offset))
      (and (or (empty-p prev lines)
               (tabulation-body-p offset prev lines)
               (tabulation-p offset prev lines :backwards))
           (or (tabulation-body-p offset next lines)
               (tabulation-p offset next lines :forwards))
           offset))))

;;; FIXME: This and itemization are very similar: could they share
;;; some code, mayhap?

(defun collect-maybe-table-section (lines starting-line)
  ;; Return index of next line to be processed outside
  (let ((this-offset (maybe-table-offset starting-line lines))
        (result nil)
        (lines-consumed 0))
    (loop for line-number from starting-line below (length lines)
          for line = (svref lines line-number)
          for indentation = (indentation line)
          for offset = (maybe-table-offset line-number lines)
          do (cond
               ((not indentation)
                ;; empty line -- inserts paragraph.
                (push "" result)
                (incf lines-consumed))
               ((and offset (= indentation this-offset))
                ;; start of new item, or continuation of previous item
                (if (and result (search "@item" (car result) :test #'char=))
                    (push (format nil "@itemx ~A" (texinfo-line line))
                          result)
                    (progn
                      (push "" result)
                      (push (format nil "@item ~A" (texinfo-line line))
                            result)))
                (incf lines-consumed))
               ((> indentation this-offset)
                ;; continued item from previous line
                (push (texinfo-line line) result)
                (incf lines-consumed))
               (t
                ;; end of itemization
                (loop-finish))))
     ;; a single-line table isn't.
    (if (> (count-if (lambda (line) (> (length line) 0)) result) 1)
        (values lines-consumed
                `("" "@table @emph" ,@(reverse result) "@end table" ""))
        nil)))

;;; section markup

(defmacro with-maybe-section (index &rest forms)
  `(multiple-value-bind (count collected) (progn ,@forms)
    (when count
      (dolist (line collected)
        (write-line line *texinfo-output*))
      (incf ,index (1- count)))))

(defun write-texinfo-string (string &optional lambda-list)
  "Try to guess as much formatting for a raw docstring as possible."
  (let ((*texinfo-variables* (flatten lambda-list))
        (lines (string-lines (escape-for-texinfo string nil))))
      (loop for line-number from 0 below (length lines)
            for line = (svref lines line-number)
            do (cond
                 ((with-maybe-section line-number
                    (and (lisp-section-p line line-number lines)
                         (collect-lisp-section lines line-number))))
                 ((with-maybe-section line-number
                    (and (maybe-itemize-offset line)
                         (collect-maybe-itemized-section lines line-number))))
                 ((with-maybe-section line-number
                    (and (maybe-table-offset line-number lines)
                         (collect-maybe-table-section lines line-number))))
                 (t
                  (write-line (texinfo-line line) *texinfo-output*))))))

;;;; texinfo formatting tools

(defun hide-superclass-p (class-name super-name)
  (let ((super-package (symbol-package super-name)))
    (or
     ;; KLUDGE: We assume that we don't want to advertise internal
     ;; classes in CP-lists, unless the symbol we're documenting is
     ;; internal as well.
     (and (member super-package (mapcar #'find-package (ignored-packages *documentee*)))
          (not (eq super-package (symbol-package class-name))))
     ;; KLUDGE: We don't generally want to advertise SIMPLE-ERROR or
     ;; SIMPLE-CONDITION in the CPLs of conditions that inherit them
     ;; simply as a matter of convenience. The assumption here is that
     ;; the inheritance is incidental unless the name of the condition
     ;; begins with SIMPLE-.
     (and (member super-name '(simple-error simple-condition))
          (let ((prefix "SIMPLE-"))
            (mismatch prefix (string class-name) :end2 (length prefix)))
          t ; don't return number from MISMATCH
          ))))

(defun hide-slot-p (symbol slot)
  ;; FIXME: There is no pricipal reason to avoid the slot docs fo
  ;; structures and conditions, but their DOCUMENTATION T doesn't
  ;; currently work with them the way we'd like.
  (not (and (typep (find-class symbol nil) 'standard-class)
            (docstring slot t))))

(defun texinfo-anchor (doc)
  (format *texinfo-output* "@anchor{~A}~%" (node-name doc)))

;;; KLUDGE: &AUX *PRINT-PRETTY* here means "no linebreaks please"
(defun texinfo-begin (doc &aux *print-pretty*)
  (let ((kind (get-kind doc)))
    (format *texinfo-output* "@~A {~:(~A~)} ~({~A}~@[ ~{~A~^ ~}~]~)~%"
            (case kind
              ((package constant variable)
               "defvr")
              ((structure class condition type)
               "deftp")
              (t
               "deffn"))
            (map 'string (lambda (char) (if (eql char #\-) #\Space char)) (string kind))
            (title-name doc)
            (lambda-list doc))))

(defun texinfo-index (doc)
  (let ((title (title-name doc)))
    (case (get-kind doc)
      ((structure type class condition)
       (format *texinfo-output* "@tindex ~A~%" title))
      ((variable constant)
       (format *texinfo-output* "@vindex ~A~%" title))
      ((compiler-macro function method-combination macro generic-function)
       (format *texinfo-output* "@findex ~A~%" title)))))

(defun texinfo-inferred-body (doc)
  (cond ((member (get-kind doc) '(class structure condition))
         (let ((name (get-name doc)))
           ;; class precedence list
           (format *texinfo-output* "Class precedence list: @code{~(~{@w{~A}~^, ~}~)}~%~%"
                   (remove-if (lambda (class)  (hide-superclass-p name class))
                              (mapcar #'class-name (class-precedence-list (progn (finalize-inheritance (find-class name))
                                                                                 (find-class name))))))
           ;; slots
           (let ((slots (remove-if (lambda (slot) (hide-slot-p name slot))
                                   (class-direct-slots (find-class name)))))
             (when slots
               (format *texinfo-output* "Slots:~%@itemize~%")
               (dolist (slot slots)
                 (format *texinfo-output* "@item ~(@code{~A} ~
                                     ~@[--- initargs: @code{~{@w{~S}~^, ~}}~]~)~%~%"
                         (slot-definition-name slot)
                         (slot-definition-initargs slot))
                 ;; FIXME: Would be neater to handler as children
                 (write-texinfo-string (docstring slot t)))
               (format *texinfo-output* "@end itemize~%~%")))))
        ((eq (get-kind doc) 'generic-function)
         (let* ((method-combination
                 (sb-mop:generic-function-method-combination
                  (fdefinition (get-name doc))))
                (combination-name (sb-pcl::method-combination-type-name
                                   method-combination))
                (options (sb-pcl::method-combination-options method-combination)))
           (unless (eq combination-name 'standard)
             (format *texinfo-output*
                     "Method combination: @code{~A} (~(~{@w{~A}~^, ~}~))~%~%"
                     combination-name options))))))

(defun texinfo-body (doc)
  (write-texinfo-string (get-string doc)))

(defun texinfo-end (doc)
  (write-line (case (get-kind doc)
                ((package variable constant) "@end defvr")
                ((structure type class condition) "@end deftp")
                (t "@end deffn"))
              *texinfo-output*))

(defun write-texinfo (doc)
  "Writes TexInfo for a DOCUMENTATION instance to *TEXINFO-OUTPUT*."
  (texinfo-anchor doc)
  (texinfo-begin doc)
  (texinfo-index doc)
  (texinfo-inferred-body doc)
  (texinfo-body doc)
  (texinfo-end doc)
  ;; FIXME: Children should be sorted one way or another
  (mapc #'write-texinfo (get-children doc)))

;;;; main logic

(defun collect-gf-documentation (gf)
  "Collects method documentation for the generic function GF"
  (loop for method in (generic-function-methods gf)
        for doc = (maybe-documentation method t)
        when doc
        nconc doc))

(defun collect-name-documentation (name)
  (loop for type in *documentation-types*
        for doc = (maybe-documentation name type)
        when doc
        do (format-status "-Creating Texinfo for ~A as ~A~%" name type) and
        nconc doc))

(defun collect-symbol-documentation (symbol)
  "Collects all docs for a SYMBOL and (SETF SYMBOL), returns a list of
the form DOC instances. See `*documentation-types*' for the possible
values of doc-type."
  (nconc (collect-name-documentation symbol)
         (collect-name-documentation (list 'setf symbol))))

(defun collect-documentation (package)
  "Collects all documentation for all external symbols of the given
package, as well as for the package itself."
  (let* ((*documentation-package* (find-package package))
         (docs nil))
    (check-type package package)
    (do-external-symbols (symbol package)
      (setf docs (nconc (collect-symbol-documentation symbol) docs)))
    (let ((doc (maybe-documentation *documentation-package* t)))
      (when doc
        (setf docs (nconc doc docs))))
    docs))

(defmacro with-texinfo-file (pathname &body forms)
  `(with-open-file (*texinfo-output* ,pathname
                                    :direction :output
                                    :if-does-not-exist :create
                                    :if-exists :supersede)
    ,@forms))

(defgeneric document (documentee &optional directory)
  (:documentation "Create documentation for
  `documentee'. `Directory' can be used to override `documentee's
  default output directory."))

(defmethod document ((documentee documentee)
                     &optional (directory (output-directory documentee)))
  (format-status "---Generating Texinfo for documentee ~A~%" (name documentee))
  (let ((*documentee* documentee))
    (apply #'generate-includes directory (packages documentee)))
  (format-status "---Done!~%"))

(defun generate-includes (directory &rest packages)
  "Create files in `directory' containing Texinfo markup of all
docstrings of each exported symbol in `packages'. `directory' is
created if necessary. If you supply a namestring that doesn't end
in a slash, you lose. The generated files are of the form
\"<doc-type>_<packagename>_<symbol-name>.texi\" and can be
included via @include statements. Texinfo syntax-significant
characters are escaped in symbol names, but if a docstring
contains invalid Texinfo markup, you lose."
  (handler-bind ((warning #'muffle-warning))
    (let ((directory (merge-pathnames (pathname directory))))
      (ensure-directories-exist directory)
      (dolist (package packages)
        (let ((*documentation-package* package))
          (format-status "--Generating Texinfo for package ~A~%" package)
          (dolist (doc (collect-documentation (find-package package)))
            (with-texinfo-file (merge-pathnames (include-pathname doc) directory)
              (write-texinfo doc)))))
      directory)))
