;; Use bin/bash as default shell for Emacs to work around PATH issues with zsh
(setq shell-file-name "/usr/local/bin/zsh")

(setq-default indent-tabs-mode nil)

;; delete the selection with a keypress
(delete-selection-mode t)

;; revert buffers automatically when underlying files are changed
(global-auto-revert-mode t)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; write a PID file for the emacs-server
(setq pidfile "~/.emacsserver.pid")

(add-hook 'emacs-startup-hook
          (lambda ()
            (with-temp-file pidfile
              (insert (number-to-string (emacs-pid))))))

(add-hook 'kill-emacs-hook
          (lambda ()
            (when (file-exists-p pidfile)
              (delete-file pidfile))))

;; `gc-cons-threshold'

;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Garbage-Collection.html
;;
;; I have a modern machine ;)
;;
(setq gc-cons-threshold 20000000)

(setq delete-old-versions t)
(setq make-backup-files nil)
(setq create-lockfiles nil)

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq ring-bell-function 'ignore)

(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

(add-hook 'before-save-hook 'whitespace-cleanup)

;; Allow this Emacs process to be a server for client processes.
(server-start)

(provide 'tonini-system)
