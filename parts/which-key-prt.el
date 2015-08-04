(require 'which-key)

(which-key-mode)

;; Apply suggested settings for minibuffer
(which-key-setup-minibuffer)

;; Set the time delay (in seconds) for the which-key popup to appear.
(setq which-key-idle-delay 0.1)

(provide 'which-key-prt)
