;;;###autoload
(defun t-writer-mode ()
  (interactive)
  (markdown-mode)
  (linum-mode -1)
  (writeroom-mode t)
  (visual-line-mode t)
  (flyspell-mode t)
  (turn-off-smartparens-mode)
  (company-mode -1))

;;;###autoload
(defun t-disable-writer-mode ()
  (interactive)
  (linum-mode t)
  (writeroom-mode -1)
  (visual-line-mode -1)
  (flyspell-mode -1)
  (turn-on-smartparens-mode)
  (company-mode +1))

(provide 'writer-prt)
