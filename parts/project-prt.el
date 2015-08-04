;;; project-prt.el --- Project setup

;;; Commentary:
;;

;;; Code:

(add-to-list 'load-path "~/Projects/tester.el/")

(provide 'project-prt)
(require 'projectile)
(require 'perspective)
(require 'textmate)
(require 'tester)

(projectile-global-mode)
(persp-mode)
(require 'persp-projectile)

(defvar t-project-location (expand-file-name "~/Projects/"))

(defmacro t-persp (name &rest body)
  `(let ((initialize (not (gethash ,name perspectives-hash))))
     (persp-switch ,name)
     (when initialize ,@body)))

(defun t-persp-last ()
  (interactive)
  (persp-switch (persp-name persp-last)))

(defun t-emacs-conf-persp ()
  (interactive)
  (t-persp "@emacs.d"
           (let ((default-directory "~/Projects/emacs.d/"))
             (projectile-find-file))))

(defun t-main-persp ()
  (interactive)
  (t-persp "main"
           (let ((default-directory "~/Projects/")))))

(defun t-persp-kill-all ()
  "Kill all existing perspectives."
  (interactive)
  (t-persp "main")
  (cl-loop for persp-name in (persp-names) do
           (when (not (string= persp-name "main"))
             (persp-kill persp-name))))

(defun t-project-ido-find-project ()
  (interactive)
  (let* ((project-name (completing-read "Project: "
                                            (directory-files t-project-location nil "^[^.]")))
         (project-path (concat t-project-location project-name)))
    (t-persp project-name)
    (let ((default-directory project-path))
      (projectile-find-file))))

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

(provide 'project-prt)

;;; project-prt.el ends here
