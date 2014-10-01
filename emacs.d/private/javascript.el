(defun tonini-javascript-mode-hook ()
  (when (and buffer-file-name (string-match "_spec.js$" buffer-file-name))
  (setq cabbage-testing-execute-function 'karma-start-single-run)))
(add-hook 'js-mode-hook 'tonini-javascript-mode-hook)
