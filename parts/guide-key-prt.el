;;; guide-key-prt.el --- Guide-key setup

;;; Commentary:
;;

;;; Code:

(require 'guide-key)

(guide-key-mode 1)

(setq guide-key/idle-delay 0.7)

(setq guide-key/highlight-command-regexp "projectile")
(setq guide-key/guide-key-sequence '("C-c p"))

(defun setup-for-alchemist-mode ()
  (guide-key/add-local-guide-key-sequence "C-c a e")
  (guide-key/add-local-guide-key-sequence "C-c a m t")
  (guide-key/add-local-guide-key-sequence "C-c a h")
  (guide-key/add-local-guide-key-sequence "C-c a v")
  (guide-key/add-local-guide-key-sequence "C-c a i")
  (guide-key/add-local-guide-key-sequence "C-c a c")
  (guide-key/add-local-highlight-command-regexp "alchemist-"))
(add-hook 'alchemist-mode-hook 'setup-for-alchemist-mode)

(provide 'guide-key-prt)

;;; guide-key-prt.el ends here
