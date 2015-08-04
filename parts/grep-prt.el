(require 'grep)

(setq grep-find-ignored-directories (append '(".cask" "node_modules") grep-find-ignored-directories))

(provide 'grep-prt)
