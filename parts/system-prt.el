(server-start)

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
(setq auto-save-default nil)
(setq make-backup-files nil)

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

(provide 'system-prt)
