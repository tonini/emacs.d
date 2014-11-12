(defun tonini-toggle-fullscreen ()
  "Toggle full screen."
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

(defun tonini-browse-localhost-port-3000 ()
  (interactive)
  (browse-url "http://localhost:3000"))

(defun tonini-rgrep-todos-in-dir (dir)
  "Grep recursively for TODO comments in the given directory"
  (interactive "Ddirectory:")
  (grep (concat "grep -nH -I -r -E \"[\\#\\/\\-\\;\\*]\s*TODO|FIXME|BUG|WARNING:?\" " dir " 2>/dev/null"))
  (enlarge-winqdow 7))

(defun tonini-git-grep (search)
  "git-grep the entire current repo"
  (interactive (list (tonini-git-grep-prompt)))
  (grep-find (concat "git --no-pager grep -P -n "
                     (shell-quote-argument search)
                     " `git rev-parse --show-toplevel`")))

;; (defun paste-to-osx (text &optional push)
;;   (let ((process-connection-type nil))
;;     (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;;       (process-send-string proc text)
;;       (process-send-eof proc))))

;; (setq interprogram-cut-function 'paste-to-osx)
;; (setq interprogram-paste-function 'copy-from-osx)
