;;; dired-prt.el --- custom dired setup

;;; Commentary:
;;

;;; Code:

(require 'dired-x)

;; allow dired to be able to delete or copy a whole dir.
(setq dired-recursive-deletes (quote top)) ; “top” means ask once

;; copy from one dired dir to the next dired dir shown in a split window
(setq dired-dwim-target t)

;; Auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)

(require 'ls-lisp)
(setq ls-lisp-use-insert-directory-program t)
(setq insert-directory-program "/usr/local/Cellar/coreutils/8.23_1/libexec/gnubin/ls")

(load (expand-file-name "~/.emacs.d/vendor/dired-sort-map.el"))

(require 'dired-sort-map)
(setq dired-listing-switches "--group-directories-first -alh")

(defun t-open-in-external-app ()
  "Open the current file or dired marked files in external app.
The app is chosen from your OS's preference.

URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2015-01-26"
  (interactive)
  (let* (
         (ξfile-list
          (if (string-equal major-mode "dired-mode")
              (dired-get-marked-files)
            (list (buffer-file-name))))
         (ξdo-it-p (if (<= (length ξfile-list) 5)
                       t
                     (y-or-n-p "Open more than 5 files? "))))

    (when ξdo-it-p
      (cond
       ((string-equal system-type "darwin")
        (mapc
         (lambda (fPath) (shell-command (format "open \"%s\"" fPath)))  ξfile-list))
       ((string-equal system-type "gnu/linux")
        (mapc
         (lambda (fPath) (let ((process-connection-type nil)) (start-process "" nil "xdg-open" fPath))) ξfile-list))))))

(defun t-open-in-desktop ()
  "Show current file in desktop (OS's file manager).
URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2015-06-12"
  (interactive)
  (cond
   ((string-equal system-type "darwin") (shell-command "open ."))
   ((string-equal system-type "gnu/linux")
    (let ((process-connection-type nil)) (start-process "" nil "xdg-open" "."))
    )))

(provide 'dired-prt)

;;; completion-prt.el ends here
