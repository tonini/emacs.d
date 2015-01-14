(add-to-list 'load-path "~/Projects/emacs-elixir/")
(add-to-list 'load-path "~/Projects/alchemist.el/")

(require 'elixir-mode)
(require 'alchemist)

(defun t-elixir-mode-hook ()
  (yas/minor-mode +1)
  (flycheck-mode +1)
  (smartparens-mode +1)
  (tester-init-test-run #'alchemist-mix-test-file "_test.exs$")
  (tester-init-test-suite-run #'alchemist-mix-test))

(defun custom-alchemist-hook ()
  (set (make-local-variable 'company-backends) '(alchemist-company)))

(add-hook 'alchemist-mode-hook  'custom-alchemist-hook)

(add-hook 'elixir-mode-hook  't-elixir-mode-hook)

(provide 'elixir-prt)
