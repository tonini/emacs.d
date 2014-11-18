(cabbage-vendor 'textmate)

;; add additional files / directories to execlude from textmate-goto-file
(when (not (string-match "backup" *textmate-gf-exclude*))
  (setq *textmate-gf-exclude*
        (replace-regexp-in-string "tmp"
                                  "tmp|backup|elpa|\.cask"
                                  *textmate-gf-exclude*)))
