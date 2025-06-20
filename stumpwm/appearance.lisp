(defvar phundrak-nord0 "#2e3440")
(defvar phundrak-nord1 "#3b4252")
(defvar phundrak-nord2 "#434c5e")
(defvar phundrak-nord3 "#4c566a")
(defvar phundrak-nord4 "#d8dee9")
(defvar phundrak-nord5 "#e5e9f0")
(defvar phundrak-nord6 "#eceff4")
(defvar phundrak-nord7 "#8fbcbb")
(defvar phundrak-nord8 "#88c0d0")
(defvar phundrak-nord9 "#81a1c1")
(defvar phundrak-nord10 "#5e81ac")
(defvar phundrak-nord11 "#bf616a")
(defvar phundrak-nord12 "#d08770")
(defvar phundrak-nord13 "#ebcb8b")
(defvar phundrak-nord14 "#a3be8c")
(defvar phundrak-nord15 "#b48ead")

(setq *colors*
      `(,phundrak-nord1   ;; 0 black
        ,phundrak-nord11  ;; 1 red
        ,phundrak-nord14  ;; 2 green
        ,phundrak-nord13  ;; 3 yellow
        ,phundrak-nord10  ;; 4 blue
        ,phundrak-nord14  ;; 5 magenta
	;;,phundrak-nord5)) ;; 7 white
        ,phundrak-nord8   ;; 6 cyan
	("#eff4fc" "#686a6d"))
      *mode-line-background-color* "#32334c")


(ql:quickload "clx-truetype")
(load-module "ttf-fonts")
(setf xft:*font-dirs* (append xft:*font-dirs* (list "/run/current-system/sw/share/X11/fonts")))

;; Tell clx-truetype about the fonts you have installed. You really only need to do this once,
;; but putting it here means you will not forget in the future.
(xft:cache-fonts)

(set-font (make-instance 'xft:font :family "DejaVu Sans Mono" :subfamily "Book" :size 10))

(load-module "swm-gaps")

(defvar *enable-gaps* t)

(defun one-window-no-gaps (&rest arg)
  (declare (ignore arg))
  (when *enable-gaps*
    (if (< 2 (length (group-frames (current-group))))
       (swm-gaps:toggle-gaps-off)
       (swm-gaps:toggle-gaps-on))))

(add-hook *new-window-hook* #'one-window-no-gaps)
(add-hook *split-frame-hook* #'one-window-no-gaps)
(add-hook *focus-frame-hook* #'one-window-no-gaps)
(add-hook *destroy-window-hook* #'one-window-no-gaps)
(add-hook *focus-group-hook* #'one-window-no-gaps)

(setf swm-gaps:*inner-gaps-size* 10)
(setf swm-gaps:*outer-gaps-size* 0)
(setf swm-gaps:*head-gaps-size* 0)

(when *enable-gaps* (swm-gaps:toggle-gaps-on))
