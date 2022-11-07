;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email clients, file templates and snippets.
(setq user-full-name "mihh"
      user-mail-address "mihneaturcu29@tuta.io")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(setq doom-theme 'doom-vibrant)

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 20)) ;;22
;; (setq doom-font (font-spec :family "DejaVu Sans Mono" :size 20))
;; (setq doom-font (font-spec :family "DejaVu Sans Mono" :size 15 :height 17))
      ;; doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(menu-bar--display-line-numbers-mode-relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; ;; old config
;; (setq company-idle-delay 0)
;; (setq company-minimum-prefix-length 1)
;; (setq c-basic-offset 2)
;; (setq text-scale-mode-step 1.1)
;; (setq max-lisp-eval-depth 50000)
;; ;;




(add-hook 'fundamentals-mode-hook
          (lambda()
            (text-scale-increase 2)))
(add-hook 'prog-mode-hook
          (lambda()
            (text-scale-increase 2)))
(add-hook 'vterm-mode-hook
          (lambda()
            (text-scale-increase 1)))
(add-hook 'dired-mode-hook
          (lambda()
            (text-scale-increase 1)))
(add-hook 'compilation-mode-hook
          (lambda()
            (text-scale-increase 1)))

(add-hook 'cpp-mode-hook
          (lambda()
            (flycheck-mode)))

;; (setq text-scale-mode-step 1.1)
(global-auto-revert-mode t)
(setq mihh-dir "~/.doom.d/mihh/" )
(load! (concat mihh-dir "godot_config.el"))
;; (load! (concat mihh-dir "cpp2.el"))
(load! (concat mihh-dir "cpp2.el"))

;; debugger ig
;; add to $DOOMDIR/config.el
(after! dap-mode
  (setq dap-python-debugger 'debugpy))

(map! :map dap-mode-map
      :leader
      :prefix ("d" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug"         "s" #'dap-debug

      ;; debug
      :prefix ("dd" . "Debug")
      :desc "dap debug recent"  "r" #'dap-debug-recent
      :desc "dap debug last"    "l" #'dap-debug-last

      ;; eval
      :prefix ("de" . "Eval")
      :desc "eval"                "e" #'dap-eval
      :desc "eval region"         "r" #'dap-eval-region
      :desc "eval thing at point" "s" #'dap-eval-thing-at-point
      :desc "add expression"      "a" #'dap-ui-expressions-add
      :desc "remove expression"   "d" #'dap-ui-expressions-remove

      :prefix ("db" . "Breakpoint")
      :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
      :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
      :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
      :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)




;; (defun buffer-mode (buffer-neim)
;;   "Returns the major mode associated with a buffer."
;;   (with-current-buffer buffer-neim
;;      major-mode))
