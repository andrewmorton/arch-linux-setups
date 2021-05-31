  (setq package-enable-at-startup nil)

  ;; set a custom el file to preserve my config
  (setq custom-file (expand-file-name "sys_custom.el" user-emacs-directory))
  (when (file-exists-p custom-file)
    (load custom-file))


  (require 'package)

  (setq package-archives '(("melpa" . "https://melpa.org/packages/")
                           ("org" . "https://orgmode.org/elpa/")
                           ("elpa" . "https://elpa.gnu.org/packages/")))

  (package-initialize)
  (package-refresh-contents)

  
(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (require 'use-package)

  ;; sets use package to ensure packages are kept up to date always
  (setq use-package-always-ensure 't)

  
;; Turn off startup message and turn off audible bell
  (setq inhibit-startup-message t)
  (setq visible-bell t)

(use-package org
  :hook (org-mode . guts/org-mode-setup))
