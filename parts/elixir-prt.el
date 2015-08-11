(require 'smartparens)

(add-to-list 'load-path "~/Projects/emacs-elixir/")
(add-to-list 'load-path "~/Projects/alchemist.el/")

(require 'alchemist)

(setq alchemist-goto-elixir-source-dir "~/Projects/elixir/")
(setq alchemist-goto-erlang-source-dir "~/Projects/otp_src_17.4/")

(defun t-elixir-mode-hook ()
  (yas/minor-mode +1)
  (smartparens-mode +1)
  (tester-init-test-run #'alchemist-mix-test-file "_test.exs$")
  (tester-init-test-suite-run #'alchemist-mix-test))

(defun my-elixir-do-end-close-action (id action context)
  (when (eq action 'insert)
    (newline-and-indent)
    (forward-line -1)
    (indent-according-to-mode)))

(sp-with-modes '(elixir-mode)
  (sp-local-pair "->" "end"
                 :when '(("RET"))
                 :post-handlers '(:add my-elixir-do-end-close-action)
                 :actions '(insert)))

(sp-with-modes '(elixir-mode)
  (sp-local-pair "do" "end"
                 :when '(("SPC" "RET"))
                 :post-handlers '(:add my-elixir-do-end-close-action)
                 :actions '(insert)))

(defun t-erlang-mode-hook ()
  (define-key erlang-mode-map (kbd "M-,") 'alchemist-goto-jump-back))

(defun t-alchemist-custom-keybindings ()
  (define-key alchemist-mode-map (kbd "M-w") 'alchemist-goto-list-symbol-definitions))

(defun alchemist-my-iex-keys ()
  (define-key alchemist-iex-mode-map (kbd "C-d") 'windmove-right))

(add-hook 'alchemist-iex-mode-hook 'alchemist-my-iex-keys)
(add-hook 'alchemist-mode-hook 't-alchemist-custom-keybindings)
(add-hook 'elixir-mode-hook  't-elixir-mode-hook)
(add-hook 'erlang-mode-hook 't-erlang-mode-hook)

;; Display alchemist buffers always at the bottom
;; Source: http://www.lunaryorn.com/2015/04/29/the-power-of-display-buffer-alist.html
(add-to-list 'display-buffer-alist
             `(,(rx bos (or "*alchemist test report*"
                            "*alchemist mix*"
                            "*alchemist help*"))
                    (display-buffer-reuse-window
                     display-buffer-in-side-window)
               (reusable-frames . visible)
               (side            . right)
               (window-width   . 0.5)))

(defun alchemist-quit-displayed-windows ()
  "Quit side windows of the current frame."
  (interactive)
  (dolist (window (list (get-buffer-window "*alchemist test report*")
                        (get-buffer-window "*alchemist mix*")
                        (get-buffer-window "*alchemist help*")))
    (if window
        (quit-window nil window))))

(provide 'elixir-prt)
