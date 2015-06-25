;;; grep-prt.el --- Specific grep/rgrep setup

;;; Commentary:
;;

;;; Code:

(require 'grep)

(setq grep-find-ignored-directories (append '(".cask" "node_modules") grep-find-ignored-directories))

(provide 'grep-prt)

;;; grep-prt.el ends here
