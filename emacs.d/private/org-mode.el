(defvar tonini--org-project-file-path
  (concat cabbage-org-files "projects/"))

(defvar tonini--org-refactoring-file-path
  (concat cabbage-org-files "refactorings/"))

(defun tonini-org-project-files ()
  (directory-files tonini--org-project-file-path nil "\\.org$"))

(defun tonini-org-refactoring-files ()
  (directory-files tonini--org-refactoring-file-path nil "\\.org$"))

(defun tonini-org-projects-chooser ()
  (let ((completing-read-func (if (null ido-mode)
                                  'completing-read
                                'ido-completing-read)))
    (setq project-file
          (funcall completing-read-func
                   "Project: "
                   (tonini-org-project-files)
                   nil
                   t))))

(defun tonini-org-refactoring-chooser ()
  (let ((completing-read-func (if (null ido-mode)
                                  'completing-read
                                'ido-completing-read)))
    (setq refactoring-file
          (funcall completing-read-func
                   "Refactoring: "
                   (tonini-org-refactoring-files)
                   nil
                   t))))

(defun tonini-org-project-file ()
  (find-file (concat tonini--org-project-file-path (tonini-org-projects-chooser)))
  (goto-char (point-min))
  (re-search-forward "^\*\s*.+\n" nil t)
  (newline 1))

(defun tonini-org-refactoring-file ()
  (find-file (concat tonini--org-refactoring-file-path (tonini-org-refactoring-chooser)))
  (goto-char (point-min))
  (re-search-forward "^\*\s*.+\n" nil t)
  (newline 1))

(defun tonini-org-new-project-todo ()
  (interactive)
  (org-capture nil "p"))

(setq org-capture-templates
      '(("p" "Project Todo Files" entry (function tonini-org-project-file)
         "** TODO %?\n  %T")
        ("r" "Refactorings" entry (function tonini-org-refactoring-file)
         "** TODO %?\n \n %a")))

(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE")
        (sequence "BUG(b)" "|" "FIXED")
        (sequence "FEATURE(f)" "|" "FINISHED")
        (sequence "MEETING(m)" "|" "DONE")
        (sequence "|" "CANCELED")))
