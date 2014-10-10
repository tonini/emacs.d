;; no blinking cursor
(if (fboundp 'blink-cursor-mode)
    (blink-cursor-mode 0))

(setq visible-bell nil)

(menu-bar-mode -1)
(tool-bar-mode 0)

(set-frame-font "Source Code Pro-13")

(set-frame-parameter nil 'fullscreen 'fullboth)
(setq default-cursor-type 'box)
