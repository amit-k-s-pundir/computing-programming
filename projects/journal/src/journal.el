(defvar *fresh-journal-page*)
(defvar *journal-dir* "/home/sonu/workspace/journal/")

(defun gen-page/daily (&optional journal-dir)
  "Generates a fresh journal page for use that day.
The idea is that when emacs is started for the first time on a given
  day then a fresh journal page is automatically created and presented
  to the user. For every other restart of emacs for that day if the
  the journal page for that day already exists then the function is a
  no-op. 
Furthermore it will save the current (yesterday's) page but will
  inserts its content in the fresh page at the beginning in a
  differentiating manner to provide some context and continuance."

  (with-dir journal-dir
            (setq *fresh-journal-page*
                  (gen-fresh-daily-journal-page))))

(defun gen-fresh-daily-journal-page (&optional page-name)
  (find-file (or page-name
                 (let* ((current-date-time-format "%H-%M-%S-%a-%d-%b-%Y")
                        (page-name (concat
                                    *journal-dir* (format-time-string
                                            current-date-time-format)
                                    "-journal.org")))
                   page-name))))
