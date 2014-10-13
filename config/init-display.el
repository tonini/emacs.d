;; no blinking cursor
(if (fboundp 'blink-cursor-mode)
    (blink-cursor-mode 0))

(setq visible-bell nil)

(menu-bar-mode -1)
(tool-bar-mode 0)

(set-frame-font "Source Code Pro-13")

(set-frame-parameter nil 'fullscreen 'fullboth)
(setq default-cursor-type 'box)

(load (expand-file-name "~/.emacs.d/themes/color-theme-github.el"))

(set-face-attribute 'mode-line nil  :height 140)
(set-face-attribute 'mode-line nil  :background "Orange")
(set-face-attribute 'region nil :background "#e5d5a4")
(set-face-background 'hl-line "#e7e4d8")

(provide 'init-display)
