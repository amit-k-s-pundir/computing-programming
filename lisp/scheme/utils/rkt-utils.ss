(module rkt-utils racket
  (provide (all-defined-out))

  (define create-dir-tree
    (lambda (base-dir dir-tree)
      (current-directory base-dir)
      (let ((dir (build-path 'same (car dir-tree)))
            (dir-children (cdr dir-tree)))
        (unless (directory-exists? dir)
          (make-directory dir))
        (current-directory base-dir)

  (define setup-generic-proj
    (lambda (name base-dir dir-tree)
      (unless (directory-exists? base-dir)
        (make-directory base-dir))
      (current-directory base-dir)
      (let ((proj-dir (build-path 'same name)))
        (if (directory-exists? proj-dir)
            (error 'setup-generic-proj "Directory ~a already exists!" proj-dir)
            (make-directory proj-dir))
        (and (current-directory proj-dir)
             (directory-
             (create dir-tree)))      )))
