;;; project-prt.el --- Project setup

;;; Commentary:
;;

;;; Code:

(add-to-list 'load-path "~/Projects/tester.el/")

(provide 'project-prt)
(require 'projectile)
(require 'perspective)
(require 'textmate)
(require 'persp-projectile)
(require 'tester)

(projectile-global-mode)
(persp-mode)

(defvar t-project-location (expand-file-name "~/Projects/"))

(defmacro t-persp (name &rest body)
  `(let ((initialize (not (gethash ,name perspectives-hash))))
     (persp-switch ,name)
     (when initialize ,@body)))

(defun t-persp-last ()
  (interactive)
  (persp-switch (persp-name persp-last)))

(defun t-project-ido-find-project ()
  (interactive)
  (let* ((project-name (ido-completing-read "Project: "
                                            (directory-files t-project-location nil "^[^.]")))
         (project-path (concat t-project-location project-name)))
    (t-persp project-name)
    (let ((default-directory project-path))
      (textmate-goto-file))))

(defun persp-format-name (name)
  "Format the perspective name given by NAME for display in `persp-modestring'."
  (let ((string-name (format "%s" name)))
    (if (equal name (persp-name persp-curr))
        (propertize string-name 'face 'persp-selected-face))))

(defun persp-update-modestring ()
  "Update `persp-modestring' to reflect the current perspectives.
Has no effect when `persp-show-modestring' is nil."
  (when persp-show-modestring
    (setq persp-modestring
          (append '("[")
                  (persp-intersperse (mapcar 'persp-format-name (persp-names)) "")
                  '("]")))))

(persp-mode)

(provide 'project-prt)

;;; project-prt.el ends here
