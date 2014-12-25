;;; ruby-prt.el --- Ruby setup

;;; Commentary:
;;

;;; Code:

(require 'ruby-mode)
(require 'inf-ruby)
(require 'ruby-compilation)

(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile\\'" . ruby-mode))

(eval-after-load 'ruby-mode
  '(progn
     (defun t-ruby-mode-defaults ()
       (inf-ruby-minor-mode +1)
       (subword-mode +1))

     (setq t-ruby-mode-hook 't-ruby-mode-defaults)

     (add-hook 'ruby-mode-hook (lambda ()
                                 (run-hooks 't-ruby-mode-hook)))))

(provide 'ruby-prt)

;;; ruby-prt.el ends here
