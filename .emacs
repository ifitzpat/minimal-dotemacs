(load "~/firewall.el")
(require 'package)
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                                        ("gnu" . "http://mirrors.163.com/elpa/gnu/")
                         ;("gnu" . "http://elpa.gnu.org/packages/")
                         ;("localelpa" . "~/.emacs.d/localelpa/")
                         ))
(package-initialize)
(package-install 'use-package)

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode))

(use-package restclient
  :ensure t)

(use-package docker
  :ensure t)

(use-package docker-tramp
  :ensure t
  :after docker
  )

(use-package dockerfile-mode
  :ensure t
  :after docker
  )

(use-package evil
  :ensure t
  :after evil-leader
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (defalias 'evil-insert-state 'evil-emacs-state)
  (setq evil-emacs-state-cursor '("red" bar))
  (setq evil-normal-state-cursor '("green" box))
  (setq evil-visual-state-cursor '("orange" box))
  )


(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  )

(use-package counsel-projectile
  :ensure t
  :after projectile)

(use-package graphviz-dot-mode
  :ensure t
  :config
  (setq graphviz-dot-indent-width 4)
)

;(use-package company-graphviz-dot
;  )

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "j" 'counsel-M-x
    "g" 'magit-status
    "0" 'delete-window
    "1" 'delete-other-windows
    "2" 'split-window-below
    "3" 'split-window-right
    "d" 'dired
    "k" 'kill-buffer
    "b" 'switch-to-buffer
    "p" 'counsel-projectile
    "G" 'counsel-org-goto
    )
  )

(use-package eyebrowse
  :ensure t
  :after evil-leader
  :config
  (eyebrowse-mode t)
  (evil-leader/set-key
    "<" 'eyebrowse-prev-window-config
    ">" 'eyebrowse-next-window-config
    "/" 'eyebrowse-create-window-config
    "r" 'org-refile
    )
  )


(use-package which-key
  :ensure t
  :config
  (setq which-key-popup-type 'minibuffer)
  (which-key-mode)
  )


(use-package ivy
  :ensure t
  :diminish (ivy-mode . "")
  :config
  (ivy-mode 1)
  )

  (use-package counsel
  :ensure t
  :after ivy
  :config
  (counsel-mode))

(use-package key-chord
  :ensure t
  :config
  (key-chord-mode 1)
  (key-chord-define-global "a;" 'evil-normal-state))

;(use-package ob-shell
;  :ensure t
;  )
(use-package flycheck
             :ensure t
             :config
             (global-flycheck-mode t))

(use-package python
  :ensure t
  :config
  (setq python-shell-interpreter "python3")
  (setq org-src-preserve-indentation t)
  (setq org-src-tab-acts-natively t)
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)
  )

(use-package virtualenvwrapper
  :ensure t
  )

(use-package py-autopep8
  :ensure t
  :config
  (add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
  (setq py-autopep8-options '("--max-line-length=100" "-a" "-a"))
  )

(set-face-attribute 'default nil :height 140)
(setq magit-git-executable "D:\\Programs\\pkgs\\git-2.23.0-h6bb4b03_0\\Library\\bin\\git.exe")
(use-package magit
  :ensure t
  )

(use-package evil-magit
  :ensure t
  :after magit
  )


;(use-package forge
;  :ensure t
;  :after magit
;  )

(use-package ob-restclient
  :ensure t
  )

(use-package ess
  :ensure t
  :init (require 'ess-site)
  :config
  (require 'ob-R)
)
(setq org-confirm-babel-evaluate nil)
(setq org-export-babel-evaluate nil)
(require 'ox-md)
(require 'ob-dot)
(org-babel-do-load-languages 'org-babel-do-load-languages
			     '((emacs-lisp . t)
			       (sh . t)
			       (shell . t)
			       (bash . t)
			       (R . t)
                   (dot . t)
			       (python . t)
			       (restclient . t)
			       ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (async bind-key closql dash docker-tramp emacsql emacsql-sqlite epl ghub git-commit goto-chg json-mode json-reformat json-snatcher julia-mode markdown-mode pkg-info s swiper tablist transient treepy with-editor company-graphviz-dot graphviz-dot-mode graphviz eyebrowse virtualenvwrapper flycheck py-autopep8 dockerfile-mode ess ess-site evil-magit counsel-projectile projectile which-key magit ob-python ob-restclient ob-shell ob-sh key-chord counsel evil-leader ivy evil docker restclient use-package)))
 '(safe-local-variable-values
   (quote
    ((eval add-hook
           (quote after-save-hook)
           (function my-save-hook)
           :append :local)
     (org-export-allow-bind-keywords . t)
     (eval add-hook
           (quote after-save-hook)
           (function org-babel-tangle)
           :append :local)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun restore-proxy ()
  (interactive)
  (async-shell-command "sudo cntlm -c /etc/cntlm.conf"))

(defun my-save-hook ()
       (interactive)
       (org-md-export-to-markdown)
       (org-babel-tangle))

(setq dired-dwim-target t)
