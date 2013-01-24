(defun create-cpp-proj (proj-name &optional base-dir dir-tree)
  (interactive "*sProject Name:\nDBase Directory:")
  (insert (format "Project name is: %s\n" proj-name))
  (if (and base-dir
           (not (file-directory-p base-dir)))
      (and (insert (format "Creating baase directory: %s\n" base-dir))
           (make-directory (expand-file-name base-dir)))
        )
  (insert "#include <vector>

using namespace std;

int main(int argc, char** argv){
}

"))

(defun touch (filename)
  (let ((cmd (concat  "touch "
                     filename)))
    (insert cmd)
    (shell-command-to-string cmd)))
        
(defun create-dir-tree (dir-tree &optional base-dir)
  "Creates a directory tree in the base-dir.  If base-dir is not supplied then
the default-dir is used as the base-dir."
  (let ((dir default-directory))
    (unwind-protect
        (progn (if base-dir (cd base-dir))
               (make-directory (expand-file-name (car dir-tree)))
               (cd (car dir-tree))
               (dolist (e (cdr dir-tree))
                 (cond ((stringp e) (touch e))
                       ((consp e) (create-dir-tree e)))))
      (cd dir))))
