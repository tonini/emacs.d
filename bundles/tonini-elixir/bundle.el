(add-to-list 'load-path "~/Projects/emacs-elixir/")
(add-to-list 'load-path "~/Projects/alchemist.el/")

(require 'elixir-mode)
(require 'alchemist)

(defun cabbage-elixir-mode-hook ()
  (cabbage--set-pairs '("(" "{" "[" "\"" "\'" "|"))

  (when (and buffer-file-name (string-match "_test.exs$" buffer-file-name))
    (setq cabbage-testing-execute-function 'alchemist-mix-test-file)))

(add-hook 'elixir-mode-hook 'cabbage-elixir-mode-hook)
