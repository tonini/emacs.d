;; no blinking cursor
(if (fboundp 'blink-cursor-mode)
    (blink-cursor-mode 0))

(setq visible-bell nil)

(menu-bar-mode -1)
(tool-bar-mode 0)

(set-frame-font "Source Code Pro-13")

(set-frame-parameter nil 'fullscreen 'fullboth)
(setq default-cursor-type 'box)

(load (expand-file-name "~/.emacs.d/themes/github.el"))

(set-face-attribute 'mode-line nil :height 130)
(set-face-attribute 'mode-line-inactive nil  :height 130)
;; (set-face-attribute 'mode-line nil  :background "Orange")
;; (set-face-attribute 'region nil :background "#525d60")
;; (set-face-foreground 'hl-line "#000000")
;; (set-cursor-color "#eeeeee")
