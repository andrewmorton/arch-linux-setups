;;;;;;;;;;;;;;; Boilerplate START
;;;;;
;; Preserve my clean init file START


(setq package-enable-at-startup nil)

;;;;;;;;;;;;;;; Visual Adjustments in Emacs START

(setq inhibit-startup-message t)

;; Turn off scroll bars for keyboard env
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 10)

(setq visible-bell t)

;; Set font facing
(set-face-attribute 'default nil
         :font "JetBrains Mono:weight=extra-bold"
         :height 170)

(column-number-mode)
(global-display-line-numbers-mode t)

;; Turn off line numbers for certain things
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook
		shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;;;;;;;;;;;;;;; Visual Adjustments in Emacs END


(setq custom-file (expand-file-name "sys_custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Preserve my clean init file END
;;;;;

;;;;;
;; Defining startup package repos START

(require 'package)
;; Define repos as package archives
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(package-refresh-contents)

;;;;;;;;;;;;;;; Boilerplate END


;;;;;;;;;;;;;;; Early package configuration START
;;;;;
;; Defining startup package repos END
;; Set use-package START

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)

;; Set use-package END

;; Defining startup package repos END
;;;;;;;;;;;;;;; Early package configuration END



;;;;;;;;;;;;;;; Change Keybindings
;; Escape quits
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;;;;;;;;;;;;;;; Use package calls
;;;;;
;; Evil START

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode t))

(use-package evil-collection
  :after evil
  :config (evil-collection-init))

;; Evil END
;;;;;

;;;;;
;; Terraform support START
(use-package terraform-mode)
(use-package terraform-doc)

(require 'terraform-mode)
(require 'terraform-doc)

;;
;;;;; Terraform Support END

;;;;;
;; ELisp support START

(use-package rainbow-delimiters
  :ensure t
  :diminish
  :hook (prog-mode . rainbow-delimiters-mode))
;;
;;;;; ELisp Support END

;;;;; 
;; Markdown support
(use-package markdown-mode)
;;
;;;;;

;;;;; Setup Ivy
;;

(use-package ivy
  :diminish
  :bind (:map ivy-minibuffer-map
	     ("TAB" . ivy-alt-done))
  :init
  (ivy-mode t))
;;
;;;;;

;;;;; counsel
;;
(use-package counsel
  :diminish
  :bind (("M-x" . counsel-M-x)
	 ("C-M-j" . counsel-switch-buffer)
	 ("C-x C-f" . counsel-find-file)))
;;
;;;;;

;;;;; swiper
;;
(use-package swiper
  :bind ("C-s" . swiper))
;;
;;;;;

;;;;; magit
;;
(use-package magit
  :bind (("C-g" . magit-status)))

(use-package git-gutter
  :diminish
  :config
  (global-git-gutter-mode 't))
;;
;;;;;

;;;;;
;; doom modeline
(use-package doom-modeline
  :init (doom-modeline-mode t)
  :custom (doom-modeline-height 10))

(use-package all-the-icons)
;;
;;;;;

;;;;;
;; which-key
(use-package which-key
  :init (which-key-mode)
  :diminish (which-key-mode)
  :config (setq which-key-idle-delay 0.5))
;;
;;;;;

;;;;;
;; Ivy-rich: Creates context around ivy completions
(use-package ivy-rich
  :init (ivy-rich-mode 1))
;;
;;;;;

;;;;;
;; Command log buffer: shows the commands that are being run on key presses
(use-package command-log-mode)
;;
;;;;;

;;;;;
;; Command log buffer: shows the commands that are being run on key presses
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  (counsel-describe-symbol-function  #'helpful-symbol)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-symbol] . counsel-describe-symbol)
  ([remap describe-key] . helpful-key)
  ("<f1> f" . counsel-describe-function)
  ("<f1> v" . counsel-describe-variable)
  ("<f1> o" . counsel-describe-symbol)
  ("<f1> l" . counsel-find-library))
;;
;;;;;

;;;;;
;; General for keybindings

(use-package general
  :config
  (general-create-definer guts/action-keys
			  :keymaps '(normal insert visual emacs)
			  :prefix "SPC"
			  :global-prefix "C-SPC")
  (guts/action-keys
   "s" '(:ignore t :which-keys "scaling")
   "t" '(:ignore t :which-keys "toggling")
   "o" '(:ignore t :which-keys "org-mode")))

;;;;;
;; Use Org Mode

;; setup org mode functions
(defun guts/org-mode-setup ()
  (variable-pitch-mode 0)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil
	org-startup-indented 1))

(defun guts/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
	visual-fill-column-center-text 1)
  (visual-fill-column-mode 1))

(use-package org
  :hook (org-mode . guts/org-mode-setup))

(use-package org-bullets
  :after (org)
  :config (org-bullets-mode 1))

(use-package visual-fill-column
  :hook (org-mode . guts/org-mode-visual-fill))
;;
;;;;;


;;  Add Themes
(use-package "cyberpunk-theme")
(use-package "cyberpunk-2019-theme")
(use-package "soothe-theme")
(use-package "cherry-blossom-theme")
(use-package "zerodark-theme")
(use-package doom-themes)

(defvar current-theme 'doom-outrun-electric)

(load-theme current-theme t)