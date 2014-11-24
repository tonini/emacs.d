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

 (setq ring-bell-function 'ignore)
