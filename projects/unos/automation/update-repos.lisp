(in-package :sonu-utils)

(defun update-repos/dir-trees (dir-trees)
  "For each *dir* in a *dir-tree* in *dir-trees*, checks whether it is
  a git or svn repo and if it is, it updates that repo accordingly."
  (dolist (dir-tree dir-trees)
    (update-repos/dir-tree dir-tree)
;    (walk-dir-tree dir-tree #'update-repo)
    ))

(defun update-repos/dir-tree (dir-tree)
  (walk-dir-tree dir-tree #'update-repo/dir)
  )

(defun update-repo/dir (dir)
  (cond ((git-repo-p dir)
         (update-git-repo dir))
        ((svn-repo-p dir)
         (update-svn-repo dir))
        (t
         (error "~A is not a git or svn repo" dir)))
  )

(defun update-git-repo (repo-dir)
  (let ((git-repo-update-cmd "git pull"))
    (with-dir repo-dir
      (! git-repo-update-cmd))))

(defun update-svn-repo (repo-dir)
  (let ((svn-repo-update-cmd "svn update"))
    (with-dir repo-dir
      (! svn-repo-update-cmd))))

(defun git-repo-p (dir)
  (directory (merge-pathnames ".git" dir)))

(defun svn-repo-p (dir)
  (directory (merge-pathnames ".svn" dir)))

