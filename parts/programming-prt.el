(require 'smartparens)

(smartparens-mode 1)

(if (fboundp 'global-flycheck-mode)
    (global-flycheck-mode +1))

(provide 'programming-prt)
