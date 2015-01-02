;;; ruby-prt.el --- Ruby setup

;;; Commentary:
;;

;;; Code:

(require 'ruby-mode)
(require 'inf-ruby)
(require 'ruby-compilation)
(require 'rspec-mode)
(require 'rvm)

(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile\\'" . ruby-mode))

(eval-after-load 'ruby-mode
  '(progn

     (setq rspec-spec-command "rspec")
     (setq rspec-use-rake-when-possible nil)
     (setq rspec-use-bundler-when-possible t)

     (setq rspec-use-rvm t)
     (rvm-use-default)

     (defun t-ruby-mode-defaults ()
       (inf-ruby-minor-mode +1)
       (subword-mode +1)
       (tester-init-test-run #'rspec-run-single-file "_spec.rb$"))

     (add-hook 'ruby-mode-hook 't-ruby-mode-defaults)))

(provide 'ruby-prt)

;;; ruby-prt.el ends here
