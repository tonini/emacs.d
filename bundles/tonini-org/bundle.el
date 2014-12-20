(setq cabbage-org-files "~/Dropbox/org/")

(setq org-capture-templates
      '(("j" "Journal Entry" plain
         (file+datetree (concat cabbage-org-files "journal.org"))
         "%U\n\n%?" :empty-lines-before 1)
        ("w" "Log Work Task" entry
         (file+datetree (concat cabbage-org-files "worklog.org"))
         "* TODO %^{Description}  %^g\n%?\n\nAdded: %U"
         :clock-in t
         :clock-keep t)))

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
