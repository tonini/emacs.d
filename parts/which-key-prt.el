;;; guide-key-prt.el --- which-key setup

;;; Commentary:
;;

;;; Code:

(require 'which-key)

(which-key-mode)

;; Apply suggested settings for minibuffer
(which-key-setup-minibuffer)

;; Set the time delay (in seconds) for the which-key popup to appear.
(setq which-key-idle-delay 0.7)

(provide 'which-key-prt)

;;; which-key-prt.el ends here
