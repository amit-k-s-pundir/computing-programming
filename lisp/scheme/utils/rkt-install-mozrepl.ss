(module install-mozrepl racket
  (provide (all-defined-out))
  (define mozrepl_src_url "/home/sonu/workspace/programming/sources/mozrepl/mozrepl")
  (define esresso_url (string-concatenate mozrepl_src_url
                                          "/chrome/content/espresso.el"))
  (define mozrepl_install_dir "~/.emacs.d/mozrepl")
  )

