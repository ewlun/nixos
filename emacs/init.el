;; -*- lexical-binding: t; -*-

;; ---------------- INIT ----------------

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package)
  (setf use-package-always-ensure t))

;; ------------- APPEARANCE --------------

(setq warning-minimum-level :error)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-message t)
(add-to-list 'default-frame-alist '(width . 115))
(add-to-list 'default-frame-alist '(height . 38))
(setq column-number-mode t)
(global-display-line-numbers-mode t)

(use-package kanagawa-themes
  :config (load-theme 'kanagawa-wave t))

(use-package delight)


;; =========== PROGRAMMING LANGUAGES ===========

;; ---------------- LISP ----------------

(use-package sly
  :custom (inferior-lisp-program "ros -Q run"))

(use-package smartparens
  :hook (lisp-mode sly-mrepl-mode)
  :config
  (require 'smartparens-config)
  (define-key smartparens-mode-map (kbd "M-(") 'sp-wrap-round)
  (define-key smartparens-mode-map (kbd "M-[") 'sp-wrap-square)
  (define-key smartparens-mode-map (kbd "M-{") 'sp-wrap-curly)
  (define-key smartparens-mode-map (kbd "M-<backspace>") 'sp-backward-unwrap-sexp))


;; ---------------- HTML ----------------

(use-package emmet-mode ; C-j för att komplettera
  :hook html-mode
  :bind (:map emmet-mode-keymap
  ("C-c p" . (lambda () (interactive)
  (insert "<pre><code></code></pre>")
   (forward-char -13)))))


;; ---------------- RUST ----------------

(use-package rust-mode
  :ensure t
  :init
  (setq rust-mode-treesitter-derive t))

(use-package rustic
  :ensure t
  :after (rust-mode))


;; ---------------- Nix ------------------

(use-package nix-mode)

;; ---------------- C/C++ ----------------

(use-package company-c-headers
  :config (add-to-list 'company-backends 'company-c-headers)
  (add-to-list 'company-c-headers-path-system "/usr/include/c++/13"))

(defun init-c++ ()
  (c-set-style "stroustrup")
  (setq lsp-enable-on-type-formatting nil)
  (setq company-clang-arguments "-I/usr/include/c++/13/")
  (define-key c++-mode-map [backtab]
            '(lambda () (interactive ) (c-indent-command) (next-line)))
  (lsp))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(setq compile-command (concat "g++ -std=c++17 -Wall -Wextra -Wpedantic -Werror " buffer-file-name))
(global-set-key [f5] 'compile)

(use-package cmake-mode)

;; ============ PACKAGES/CONFIG =============

;; ------------ ESSENTIALS -------------

(use-package ivy
  :config (ivy-mode)
  :delight)

(use-package counsel
  :config (counsel-mode)
  :delight)

(use-package company
  :config (global-company-mode)
  :delight)

(use-package vterm
  :hook ('vterm-mode . (lambda () (display-line-numbers-mode -1)))
  :bind (:map vterm-mode-map
              ("C-c C-g" . vterm-send-C-g))
  :config (add-to-list 'display-buffer-alist '("\\*vterm"
                                               (display-buffer-at-bottom)
                                               (window-height . 0.30))))

;; ---------------- MISC ----------------

(use-package undo-tree
  :config
  (global-undo-tree-mode)
   (setq undo-tree-history-directory-alist
         '(("." . (concat user-emacs-directory "undo")))
   :delight)

(use-package magit)

(use-package lsp-mode
  :hook ((python-mode . lsp)
         ((c++-mode c-mode) . init-c++)
         (rust-mode . lsp)))

(use-package yasnippet
  :config (yas-global-mode 1)
  :delight yas-minor-mode)

(use-package fold-this
  :config
  (global-set-key (kbd "C-c C-f") 'fold-this)
  (global-set-key (kbd "C-c M-f") 'fold-this-unfold-all))

;; ---------------- CUSTOM ----------------

(defun insert-line-before () (interactive)
       (previous-line)
       (move-end-of-line nil)
       (newline))

(global-set-key (kbd "C-<return>") 'insert-line-before)

(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window -1)))

;; For copying in WSL
(setq select-active-regions nil)


;; ------------- BUILTINS -------------

(use-package org
  :ensure nil
  :custom
  (org-hide-emphasis-markers t)
  :bind (("C-c o a" . org-agenda)))

(use-package eldoc
  :ensure nil
  :delight)

(use-package gnus
  :ensure nil
  :config
  (setq gnus-select-method '(nntp "news.gwene.org")))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(cmake-mode company-c-headers counsel delight emmet-mode fold-this
		kanagawa-themes lsp-mode magit nix-mode rustic sly
		smartparens undo-tree vterm yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
