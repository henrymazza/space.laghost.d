(require 'use-package)
(setq use-package-verbose 'debug)

(add-to-list 'load-path (expand-file-name "~/.spacemacs.develop.d/straight/repos/all-the-icons"))

(use-package good-scroll
  :disabled
  :straight (good-scroll :type git :host github :repo "io12/good-scroll.el")
  :init
  (good-scroll-mode 1)
  :config
  (global-set-key [next] #'good-scroll-up-full-screen)
  (global-set-key [prior] #'good-scroll-down-full-screen)
  )

(use-package ob-elixir
  :disabled
  :straight t
  :after elixir)

(use-package dired-subtree
  :disabled
  :straight t
  :after dired
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))

;; force web-mode (#not)
(use-package web-mode
  :disabled
  :straight t
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2))

(use-package string-inflection
  :init
  (global-set-key (kbd "C-c i") 'string-inflection-cycle)
  (global-set-key (kbd "C-c C") 'string-inflection-camelcase)
  (global-set-key (kbd "C-c L") 'string-inflection-lower-camelcase)
  (global-set-key (kbd "C-c J") 'string-inflection-java-style-cycle))

(use-package fic-mode
  :disabled
  :straight (fic-mode :type git :host github :repo "lewang/fic-mode"))

;; indent visual-line wrapped lines
(use-package adaptive-wrap
  :straight t
  :hook (prog-mlode . adaptive-wrap-prefix-mode))

;; utilities for working with files
(use-package f
  :straight t)

;; nice grep like searcher
(use-package xah-find
  :straight t)

;; more powerful
(use-package elgrep
  :straight t)

(use-package restclient
  :straight t)

(use-package diredful
  :straight t
  :init
  (diredful-mode 1))

(use-package docker
  :straight t
  :ensure t
  :bind ("C-c d" . docker))


(use-package org-reveal
  :disabled
  :straight (org-reveal :type git :host github :repo "yjwen/org-reveal")
  :init
  (use-package ox-reveal
    :straight t)

  ;; TODO: make that relative
  (setq org-reveal-root "file:///Users/HMz/Development/reveal.js")
  (setq org-reveal-title-slide nil))

(use-package org-tree-slide
  :straight t)

(use-package ruby-tools
  :straight (ruby-tools :type git :host github :repo "rejeep/ruby-tools.el"))

(use-package request
  :straight (request :type git :host github :repo "tkf/emacs-request"))

(use-package polymode
  :straight t
  :disabled
  :config
  (define-hostmode poly-ng2-ts-hostmode
    :mode 'ng2-ts-mode)

  (define-innermode poly-ng2-ts-doc-markdown-innermode
    :mode 'markdown-mode
    :head-matcher "/*"
    :tail-matcher "*/"
    :head-mode 'host
    :tail-mode 'host)

  (define-polymode poly-ng2-ts-mode
    :hostmode 'poly-ng2-ts-hostmode
    :innermodes '(poly-ng2-ts-doc-markdown-innermode))

  (define-hostmode poly-ruby-hostmode
    :mode 'ruby-mode)

  (define-innermode poly-ruby-sql-innermode
    :mode 'sql-mode
    :head-matcher "SQL"
    :tail-matcher "SQL"
    :head-mode 'host
    :tail-mode 'host)

  (define-polymode poly-ruby-mode
    :hostmode 'poly-ruby-hostmode
    :innermodes '(poly-ruby-sql-innermode))
  )


(use-package poly-ruby
  :straight t
  :disabled
  :mode ("\\.rb" . poly-ruby-mode)
  :init
  (define-key ruby-mode-map (kbd "C-c m") 'toggle-poly-ruby-mode))

(use-package poly-markdown
  :straight t
  :ensure polymode
  :defer t
  :mode ("\\.md" . poly-markdown-mode))

(defun run-in-vterm-kill (process event)
  "A process sentinel. Kills PROCESS's buffer if it is live."
  (let ((b (process-buffer process)))
    (and (buffer-live-p b)
         (kill-buffer b))))

;; (defun run-in-vterm (command)
;;   "Execute string COMMAND in a new vterm.

;; Interactively, prompt for COMMAND with the current buffer's file
;; name supplied. When called from Dired, supply the name of the
;; file at point.

;; Like `async-shell-command`, but run in a vterm for full terminal features.

;; The new vterm buffer is named in the form `*foo bar.baz*`, the
;; command and its arguments in earmuffs.

;; When the command terminates, the shell remains open, but when the
;; shell exits, the buffer is killed."
;;   (interactive
;;    (list
;;     (let* ((f (cond (buffer-file-name)
;;                     ((eq major-mode 'dired-mode)
;;                      (dired-get-filename nil t))))
;;            (filename (concat " " (shell-quote-argument (and f (file-relative-name f))))))
;;       (read-shell-command "Terminal command: "
;;                           (cons filename 0)
;;                           (cons 'shell-command-history 1)
;;                           (list filename)))))
;;   (with-current-buffer (vterm (concat "*" command "*"))
;;     (set-process-sentinel vterm--process #'run-in-vterm-kill)
;;     (vterm-send-string command)
;;     (vterm-send-return)))

;; Typescript
(use-package tide
  :straight t
  :disabled
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save))
  :init
  (add-hook 'js2-mode-hook #'setup-tide-mode)
  ;; configure javascript-tide checker to run after your default javascript checker
  (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)

  ;; this seems to work (from [[https://github.com/ananthakumaran/tide/issues/67][flycheck doesn't use next syntax checker (tslint) after tide · Issue #67 · ananthakumaran/tide]])
  (defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (flycheck-add-next-checker 'typescript-tide '(t . typescript-tslint) 'append)
    (eldoc-mode +1)
    (company-mode +1))

  ;; aligns annotation to the right hand side
  (setq company-tooltip-align-annotations t)

  ;; formats the buffer before saving
  (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'typescript-mode-hook #'setup-tide-mode)

  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
                (setup-tide-mode)))))

(use-package ng2-mode
  :straight t)

(use-package popup-switcher
  :straight t
  :init
  (setq psw-popup-position 'center)
  (setq psw-highlight-previous-buffer t)
  :config
  (spacemacs/set-leader-keys "bv" 'psw-switch-buffer)
  ;; (global-set-key [f2] 'psw-switch-buffer)
  )

;; Quit, Exit, Escape
(use-package evil-escape
  :commands evil-escape-mode
  :init
  (setq evil-escape-excluded-states '(normal visual multiedit emacs motion)
        evil-escape-excluded-major-modes '(neotree-mode)
        evil-escape-key-sequence "kj"
        evil-escape-delay 0.25)
  (add-hook 'after-init-hook #'evil-escape-mode)
  :config
  ;; no `evil-escape' in minibuffer
  (cl-pushnew #'minibufferp evil-escape-inhibit-functions :test #'eq)

  (defun evil-keyboard-quit ()
    "Keyboard quit and force normal state."
    (interactive)
    (and evil-mode (evil-force-normal-state))
    (keyboard-escape-quit))

  (define-key evil-insert-state-map   (kbd "Esc") #'evil-keyboard-quit)

  ;; (defun my-esc (prompt)
  ;;   "Functionality for escaping generally. Includes exiting Evil
  ;;    insert state and C-g binding. "
  ;;   (cond
  ;;    ((or (evil-insert-state-p)
  ;;         ;; (evil-normal-state-p)
  ;;         (evil-replace-state-p)
  ;;         (evil-visual-state-p)) [escape])))
  ;; (define-key key-translation-map (kbd "C-g") 'my-esc)

  ;; (define-key evil-normal-state-map   (kbd "C-g") #'evil-keyboard-quit)
  ;; (define-key evil-motion-state-map   (kbd "C-g") #'evil-keyboard-quit)
  ;; (define-key evil-insert-state-map   (kbd "C-g") #'evil-keyboard-quit)
  ;; (define-key evil-window-map         (kbd "C-g") #'evil-keyboard-quit)
  ;; (define-key evil-operator-state-map (kbd "C-g") #'evil-keyboard-quit)
  ;; (define-key key-translation-map (kbd "ESC") (kbd "C-g"))
  ;; (define-key key-translation-map (kbd "C-g") (kbd "ESC"))
  )

;; (use-package leuven-theme
;;   :config
;;   (load-theme 'leuven-dark t))

(use-package org-cliplink
  :straight t)

(use-package org-download
  :straight t)

(use-package all-the-icons
  :straight t
  :disabled
  :catch t
  :demand t)

(use-package indicators
  :straight t
  :disabled
  :config
  (add-hook 'prog-mode
            (lambda ()
              (ind-create-indicator
               'point
               :managed t))))

(use-package browse-at-remote
  :straight t)

(use-package magithub
  :straight t
  :disabled
  :after magit
  :catch t
  :config
  (magithub-feature-autoinject t)
  (setq magithub-clone-default-directory "~/github"))

;; (use-package magit-popup
;;   :straight t
;;   :demand t)

;; (use-package git-link
;;   :straight t
;;   :after magit)

;; (use-package forge
;;   :disable
;;   :straight t
;;   :after magit)

(use-package magit-gh-pulls
  :straight t
  :disabled
  :demand t
  :catch t
  :after magit-popup
  :init
  ;; NOTE: Broken! asks for magit-gh-pulls-pop which depends on:
  (require 'magit-popup)

  (require 'gh-url) ;; this is giving recursive load, try twice at least:

  :config
  (remove-hook 'magit-mode-hook 'turn-on-magit-gh-pulls))

(use-package org-link-minor-mode
  :straight t)

(use-package poporg
  :straight t
  :after org
  :bind (("C-c /" . poporg-dwim)))

(use-package yafolding
  :straight t
  :init
  (define-key evil-normal-state-map (kbd "z a") 'yafolding-toggle-element)
  (define-key evil-normal-state-map (kbd "z c") 'yafolding-hide-element)
  (define-key evil-normal-state-map (kbd "z o") 'yafolding-show-element)
  (define-key evil-normal-state-map (kbd "z m") 'yafolding-toggle-all))

(straight-use-package 'dash)

(use-package outshine
  :disabled
  :after dash
  :straight (outshine :type git :host github :repo "alphapapa/outshine")
  :config
  (defvar outline-minor-mode-prefix "\M-#")
  (add-hook 'prog-mode-hook 'outshine-mode))

(use-package doom-modeline
  :straight t
  :catch t
  :hook (prog-mode . doom-modeline-mode)
  :demand t
  :if window-system
  :after all-the-icons
  :config
  ;; The maximum displayed length of the branch name of version control.
  (setq doom-modeline-vcs-max-length 34)
  (setq doom-modeline-height 18)
  (display-battery-mode 0)

  (doom-modeline-mode 1))

(use-package yascroll
  :disabled
  :straight t
  :config
  (global-yascroll-bar-mode 1))

(use-package google-this
  :straight t
  :config (google-this-mode 1))

(use-package projectile-rails
  :straight t
  :config
  ;; Fix for projectile rails breaking helm buffers
  (defun projectile-rails--setup-auto-insert ()
    "Call `define-auto-insert' with condition for ruby files under the current project.

If `auto-insert-alist' holds already the condition for the current project it does nothing.
So it safe to call it many times like in a minor mode hook."
    (let* ((file-re (format "^%s.*\\.rb$" (projectile-rails-root)))
           (current-project-cond `(,file-re . "projectile-rails")))
      (unless (and (boundp 'auto-insert-alist)
                   (projectile-rails--auto-insert-setup-p current-project-cond))
        (define-auto-insert
          current-project-cond
          [
           (lambda () (insert (projectile-rails-corresponding-snippet)))
           projectile-rails-expand-yas-buffer
           ]
          )))))

(use-package all-the-icons
  :straight t
  :catch t
  :demand t)

(straight-use-package 'circe)

(use-package ibuffer-projectile
  :straight t
  :requires ibuffer
  :init
  (defun j-ibuffer-projectile-run ()
    "Set up `ibuffer-projectile'."
    (ibuffer-projectile-set-filter-groups)
    (unless (eq ibuffer-sorting-mode 'recency)
      (ibuffer-do-sort-by-alphabetic)))

  (add-hook 'ibuffer-sidebar-mode-hook #'j-ibuffer-projectile-run)
  (add-hook 'ibuffer-hook #'j-ibuffer-projectile-run)
  :config
  (setq ibuffer-projectile-prefix ""))

(use-package ibuffer-sidebar
  :straight t
  :catch t
  :commands (ibuffer-sidebar-toggle-sidebar)
  :config
  (setq ibuffer-sidebar-use-custom-font t))

(use-package undohist
  :straight (:host github :repo "halbtuerke/undohist-el"
                   :branch "do-not-save-undo-file-for-ignored-files")
  :init
  (autoload 'undohist-initialize "undohist")
  (undohist-initialize)
  :config
  (setq undohist-ignored-files '("\\.gpg\\'" "COMMIT_EDITMSG")))

(use-package psession
  :straight t
  :disabled
  :config
  (psession-mode 1))

(use-package ibuffer-sidebar
  :straight t
  :catch t
  ;; :load-path "~/.emacs.d/fork/ibuffer-sidebar"
  ;; :commands (ibuffer-sidebar-toggle-sidebar)
  :config
  (setq ibuffer-sidebar-use-custom-font t)
  (setq ibuffer-sidebar-face `(:family "San Francisco" :height 120))
  (spacemacs/set-leader-keys "b S" 'ibuffer-sidebar-toggle-sidebar)
  (setq ibuffer-default-sorting-mode 'recency)
  (setq ibuffer-sidebar-use-custom-font t)
  (add-hook 'ibuffer-sidebar-mode-hook #'j-ibuffer-projectile-run))

(use-package dired
  :straight nil
  :hook
  (dired-mode . hl-line-mode)
  (dired-mode . dired-hide-details-mode)
  (dired-mode . +dired-mode-faces)
  :custom
  (dired-listing-switches "-al --group-directories-first")
  ;; Always copy/delete recursively
  (dired-recursive-copies  'always)
  (dired-recursive-deletes 'top)
  :init
  (defun +dired-mode-faces ()
    (face-remap-add-relative 'hl-line
                             :background (face-background 'isearch))))

(use-package dired-sidebar
  :straight t
  :hook
  (dired-sidebar-mode . hide-mode-line-mode)
  (dired-sidebar-mode . hl-line-mode)
  (dired-sidebar-mode . variable-pitch-mode)
  (dired-sidebar-mode . +dired-sidebar-setup)
  ;; :general
  ;; (:keymaps
  ;;  'global
  ;;  "C-x C-n" 'dired-sidebar-toggle-sidebar)
  :init
  (defun +dired-sidebar-setup ()
    (setq cursor-type nil)
    (stripe-buffer-mode 0)
    ;; Disable conflicting icons
    (all-the-icons-dired-mode 0)))

(use-package dired-subtree
  :straight t
  :bind
  (:map dired-mode-map
        ("i" . dired-subtree-insert))
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map)
  (progn
    ;; Function to customize the line prefixes (I simply indent the lines a bit)
    (setq dired-subtree-line-prefix (lambda (depth) (make-string (* 2 depth) ?\s)))
    (setq dired-subtree-use-backgrounds nil)))

(use-package stripe-buffer
  :straight t
  :disabled
  :hook
  (dired-mode . stripe-buffer-mode))

(use-package all-the-icons-dired
  :straight t
  :diminish all-the-icons-dired-mode
  :hook
  (dired-mode . all-the-icons-dired-mode))

(use-package vscode-icon
  :straight t)

(use-package awesome-tab
  :disabled
  :straight (awesome-tab :type git
                         :host github :repo "manateelazycat/awesome-tab")
  ;; :load-path "path/to/your/awesome-tab"
  :config
  (setq awesome-tab-height 140)
  (awesome-tab-mode t))

(use-package direx
  :straight t
  :disabled
  :init)

(use-package lsp-mode
  :straight t
  :disabled
  :commands lsp
  :diminish lsp-mode
  :hook
  (elixir-mode . lsp)
  :init
  (add-to-list 'exec-path "~/Development/elixir-ls/"))

(use-package persp-mode
  :straight t
  :after projectile
  :custom
  (persp-auto-save-num-of-backups 10)
  (persp-autokill-buffer-on-remove 'kill-weak)
  ;; (persp-interactive-completion-system 'ido)
  (persp-keymap-prefix "")
  (persp-nil-name "nil")


  :config
  (persp-def-auto-persp "dotfiles"
                        :mode 'prog-mode)

  (persp-def-auto-persp "ruby"
                        :buffer-name "\\.rb")

  (persp-def-auto-persp "elisp"
                        :buffer-name "\\.el")

  (persp-def-auto-persp "js"
                        :buffer-name "\\.js")

  (persp-def-auto-persp "projectile"
                        :hooks 'projectile-mode-hook
                        :get-name (projectile-project-root)
                        :predicate (lambda (buffer state)
                                     (if (and (not (eq nil (buffer-file-name buffer)))
                                              (bound-and-true-p projectile-mode)
                                              (projectile-project-p)
                                              (projectile-project-buffer-p buffer (projectile-project-root)))
                                         nil))
                        :on-match (lambda (perspective buffer after-match hook args)
                                    (persp-frame-switch perspective))))

(use-package persp-mode-projectile-bridge.el
  :straight (persp-mode-projectile-bridge.el :type git
                                             :host github :repo "Bad-ptr/persp-mode-projectile-bridge.el")
  :after (projectile persp-mode)
  :defer t
  :init
  (add-hook 'after-init-hook
            #'(lambda ()
                (message-box "Inside!")
                (persp-mode-projectile-bridge-mode 1))
            t)
  (add-hook 'persp-mode-projectile-bridge-mode-hook
            #'(lambda ()
                (if persp-mode-projectile-bridge-mode
                    (persp-mode-projectile-bridge-find-perspectives-for-all-buffers)
                  (persp-mode-projectile-bridge-kill-perspectives))))

  ;; shrug
  (run-with-timer 10 nil (lambda () (persp-mode-projectile-bridge-mode 1)))
  )

(use-package dired-k
  :straight t
  :init
  (add-hook 'dired-initial-position-hook 'hl-line-mode)
  (add-hook 'dired-initial-position-hook 'dired-k))

(use-package sublimity
  :straight t
  ;; :disabled
  :init
  (require 'sublimity)
  (require 'sublimity-scroll)
  (require 'sublimity-attractive)
  (setq sublimity-attractive-centering-width 110)
  (sublimity-mode t))

(use-package tempbuf
  :straight t
  ;; :disabled
  ;; :load-path  "~/spacemacs.d/layers/hmz-misc/local/tempbuf/tempbuf.el"
  :config
  ;; modified from jmjeong / jmjeong-emacs
  (add-hook 'help-mode-hook 'turn-on-tempbuf-mode)
  (add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)
  (add-hook 'custom-mode-hook 'turn-on-tempbuf-mode)
  (add-hook 'w3-mode-hook 'turn-on-tempbuf-mode)
  (add-hook 'Man-mode-hook 'turn-on-tempbuf-mode)
  (add-hook 'view-mode-hook 'turn-on-tempbuf-mode)
  (add-hook 'helm-major-mode-hook 'turn-on-tempbuf-mode)
  (add-hook 'inferior-python-mode-hook 'turn-on-tempbuf-mode)
  (add-hook 'magit-mode-hook 'turn-on-tempbuf-mode)

  (defun hmz-misc/tempbuf-kill-func ()
    (message "%s" (buffer-name))
    (shell-command
     (combine-and-quote-strings
      (list "terminal-notifier"
            "-message" (buffer-name)
            "-title" "Tempbuf"
            ) " ")))

  (add-hook 'tempbuf-kill-hook 'hmz-misc/tempbuf-kill-func)

  (and (fboundp 'temp-buffer-resize-mode) (temp-buffer-resize-mode t)))

(use-package rspec-mode
  :straight t
  :config
  (eval-after-load 'rspec-mode
    '(rspec-install-snippets))

  ;; somehow this function isn't defined but rspec-mode looks for it
  (defun* get-closest-gemfile-root (&optional (file "Gemfile"))
    (let ((root (expand-file-name "/")))
      (loop
       for d = default-directory then (expand-file-name ".." d)
       if (file-exists-p (expand-file-name file d))
       return d
       if (equal d root)
       return nil)))

  (defun rspec-runner ()
    "Return command line to run rspec."
    (let ((bundle-command (if (rspec-bundle-p) "bundle exec " ""))
          (zeus-command (if (rspec-zeus-p) "zeus " nil))
          (spring-command (if (rspec-spring-p) "SKIP_COV=true spring " nil)))
      (concat (or zeus-command spring-command bundle-command)
              (if (rspec-rake-p)
                  (concat rspec-rake-command " spec")
                rspec-spec-command)))))

(use-package yard-mode
  :straight t
  :defer t
  :hook
  (ruby-mode-hook . yard-mode))

(use-package inf-ruby
  :straight t
  :hook
  (ruby-mode . inf-ruby-minor-mode)
  (inf-ruby-mode . siren-inf-ruby-mode-setup)
  (compilation-filter . inf-ruby-auto-enter)

  :init
  (defun siren-inf-ruby-mode-setup ()
    (company-mode -1))
  (autoload 'inf-ruby-minor-mode "inf-ruby" "Run an inferior Ruby process" t)

  :config
  (unbind-key "C-c C-r" inf-ruby-minor-mode-map)
  (unbind-key "C-c C-s" inf-ruby-minor-mode-map))

(use-package direnv
  :straight t
  :config
  (direnv-mode))

(use-package exec-path-from-shell
  :straight t
  :custom
  (exec-path-from-shell-variables '("PATH"
                                    "MANPATH"
                                    "TMPDIR"
                                    "GOPATH"
                                    "KUBECONFIG"))
  (exec-path-from-shell-arguments '("-l" "-i"))
  (exec-path-from-shell-check-startup-files t)
  (exec-path-from-shell-debug nil)

  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package ido-yes-or-no
  :straight t
  :disabled
  :init
  (ido-yes-or-no-mode 0))

;; FIXME: not loading at start time
(use-package amx
  :disabled
  :straight t
  :init
  (defun spacemacs/helm-M-x-fuzzy-matching ()
    "Helm M-x with fuzzy matching enabled"
    (interactive)
    (let ((amx-prompt-string "Emacs commands: "))
      (amx)))

  (defun spacemacs/amx ()
    "Execute amx with a better prompt."
    (interactive)
    (let ((amx-prompt-string "Emacs commands: "))
      (amx)))

  (defun spacemacs/amx-major-mode-commands ()
    "Reexecute amx with major mode commands only."
    (interactive)
    (let ((amx-prompt-string (format "%s commands: " major-mode)))
      (amx-major-mode-commands)))

  :config
  (progn
    (setq-default amx-history-length 32
                  amx-save-file (concat spacemacs-cache-directory
                                        ".amx-items"))
    ;; (ivy-mode 0)
    (amx-mode 1)
    (ido-mode 1)
    ;; (setq ivy-re-builders-alist
    ;;       '((ivy-switch-buffer . ivy--regex-plus)
    ;;         (t . ivy--regex-fuzzy)))
    ;; define the key binding at the very end in order to allow the user
    ;; to o
    (add-hook 'emacs-startup-hook
              (lambda () (spacemacs/set-leader-keys
                           dotspacemacs-emacs-command-key 'spacemacs/amx))))

  (spacemacs/set-leader-keys ":" 'spacemacs/amx-major-mode-commands)
  (spacemacs/set-leader-keys "SPC" 'spacemacs/amx)
  (global-set-key (kbd "M-x") 'spacemacs/amx)
  (global-set-key (kbd "M-X") 'spacemacs/amx-major-mode-commands)

  ;; (define-key evil-normal-state-map (kbd "SPC SPC") 'spacemacs/amx)
  ;; (evil-leader/set-key "SPC" 'spacemacs/amx)
  ;; (spacemacs/set-leader-keys "SPC" 'spacemacs/amx)
  )

(use-package unicode-fonts
  :straight t
  :config
  (unicode-fonts-setup))

(use-package wakatime-mode
  :straight t
  :disabled
  :init
  (setq wakatime-python-path "/usr/local/bin/python3")
  :config
  (global-wakatime-mode t))

(use-package dtrt-indent
  :straight (dtrt-indent :type git
                         :host github :repo "jscheid/dtrt-indent"))

(use-package hl-block-mode
  :disabled
  :straight (hl-block-mode :type git
                           :host github :repo "emacsmirror/hl-block-mode")
  :config
  (global-hl-block-mode t))

(use-package evil-ruby-text-objects
  :straight t
  :config
  (add-hook 'ruby-mode-hook 'evil-ruby-text-objects-mode)
  (add-hook 'enh-ruby-mode-hook 'evil-ruby-text-objects-mode))

(use-package doom-todo-ivy
  :disabled
  :straight (doom-todo-ivy :type git :host github :repo "jsmestad/doom-todo-ivy")
  :catch t
  :after ivy
  :hook (after-init . doom-todo-ivy)
  :init
  (setq doom/ivy-task-tags
        '(("HACK" . warning)
          ("OPTIMIZE" . success)
          ("XXX" . font-lock-function-name-face)
          ("NOTE"  . font-lock-variable-name-face)
          ("BUG"  . font-lock-warning-face)
          ("TODO"  . warning)
          ("FIXME" . error))))

(use-package highlight-indent-guides
  :straight t
  :disabled
  :init
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-method 'character))

(use-package indicators
  :straight t
  :disabled
  :config
  (setq ind-indicator-height 19)
  (add-hook 'after-change-major-mode-hook
            (lambda()
              (ind-create-indicator 'point
                                    :managed t
                                    :face 'font-lock-const-face))))

(use-package rubocop
  :defer t
  :after ruby-mode
  :bind (:map ruby-mode-map
              ("C-c . f" . rubocop-check-current-file)
              ("C-c . p" . rubocop-check-project)
              ("C-c . d" . rubocop-check-directory)
              ("C-c . F" . rubocop-autocorrect-current-file)
              ("C-c . P" . rubocop-autocorrect-project)
              ("C-c . D" . rubocop-autocorrect-directory)))

(use-package rubocopfmt
  :straight (rubocopfmt :type git :host github :repo "jimeh/rubocopfmt.el")
  :init
  (add-hook 'ruby-mode-hook #'rubocopfmt-mode)

  (defun rubocopfmt-before-save ()
    (interactive)
    (when (and (member major-mode rubocopfmt-major-modes))
      (if (and rubocopfmt-on-save-use-lsp-format-buffer
               (bound-and-true-p lsp-mode))
          (lsp-format-buffer)
        (rubocop-autocorrect-current-file))))
  )

(use-package fira-code-mode
  :straight t
  :if window-system
  :load-path "~/.spacemacs.d/layers/hmz-misc/local/fira-code-mode/"
  :hook prog-mode)

(use-package gcmh
  :straight t
  :config
  (gcmh-mode 1))

(use-package alert
  :straight t
  :config
  (alert-add-rule :status   '(buried visible idle)
                  :severity '(moderate high urgent)
                  :mode     'erc-mode
                  :predicate
                  #'(lambda (info)
                      (string-match (concat "\\`[^&].*@BitlBee\\'")
                                    (erc-format-target-and/or-network)))
                  :persistent
                  #'(lambda (info)
                      ;; If the buffer is buried, or the user has been
                      ;; idle for `alert-reveal-idle-time' seconds,
                      ;; make this alert persistent.  Normally, alerts
                      ;; become persistent after
                      ;; `alert-persist-idle-time' seconds.
                      (memq (plist-get info :status) '(buried idle)))
                  :style 'fringe
                  :continue t))

(use-package list-processes+
  :straight t
  :defer t
  :config

  (spacemacs/set-leader-keys "a p" 'list-processes+)

  ;; override this which is broken
  (defun list-processes-kill-process ()
    ""
    (interactive)
    ;; the end of this line use to have 'process, which is void
    (let ((proc (get-text-property (point) 'tabulated-list-id)))
      (when (and proc
                 (y-or-n-p (format "Kill process %s? " (process-name proc))))
        (delete-process proc)
        (list-processes+)))))

(use-package hide-lines
  :straight t
  :config
  (add-hook 'after-change-major-mode-hook
            (lambda () (add-to-invisibility-spec 'hl))))

(use-package origami
  :straight t
  :config
  (global-origami-mode t))

(use-package hidesearch
  :disabled)

(use-package bpr
  :straight t
  :after alert
  :config

  (use-package alert
    :config
    (defun hmz-misc/mac-notify (title &optional message)
      (alert message :title title)))

  (defun hmz-misc/bpr-process-sentinel (proc string)
    (if (string-equal string "finished\n")
        (run-with-timer 5 nil (lambda (p)
                                (delete-window)
                                ) (process-buffer proc))
      (run-with-timer 60 nil (lambda (p)
                               (kill-buffer p)
                               ) (process-buffer proc)))
    (alert (process-name proc) :title string))

  (setq my-ansi-escape-re
        (rx (or
             (and (or ?\233 (and ?\e ?\[))
                  (zero-or-more (char (?0 . ?\?)))
                  (zero-or-more (char ?\s ?- ?\/))
                  (char (?@ . ?~)))
             (char "")
             (char ""))))

  (defun hmz-misc/bpr-process-filter (proc string)
    (when (buffer-live-p (process-buffer proc))
      (with-current-buffer (process-buffer proc)
        (let
            ((moving (> 3 (abs (- (count-lines (point-min) (point-max)) (line-number-at-pos))))))

          (save-excursion  ;;TODO perhaps save-mark-and-excursion?

            ;; Insert the text, advancing the process marker.
            (goto-char (process-mark proc))
            ;; (overwrite-mode overwrite-mode-textual)


            (let ((str
                   ;; Ember test is throwing escaped \n, hope just now
                   (replace-regexp-in-string "\\\\n" "\n" string)))

              (while (string-match my-ansi-escape-re str)
                ;; send first part to the buffer
                (let ((content (substring str 0 (car (match-data)))))
                  (insert content)
                  (delete-char (min (- (point-max)
                                       (point))
                                    (length content))))

                ;; deal with special code
                (let ((ansi-code (substring str  (car (match-data))
                                            (cadr (match-data)))))

                  (condition-case nil
                      (cond
                       ;;TODO save re context
                       ;; Color Code
                       ;; ((string-equal "\\n" ansi-code) (insert "\n"))
                       ((string-equal "" ansi-code)
                        (delete-backward-char 1))
                       ((string-equal "" ansi-code)
                        (beginning-of-line)
                        (kill-line))
                       ((string-match-p "m$" ansi-code) (insert ansi-code))

                       ((string-match "\\[\\(?1:.*\\);\\(?2:.*\\)f" ansi-code)
                        (let ((col (string-to-number (match-string 1 ansi-code)))
                              (lin (string-to-number (match-string 2 ansi-code))))
                          (goto-char (point-max))
                          (while (< (count-lines (point-min) (point-max)) (lin))
                            (newline))
                          (goto-line lin)

                          (end-of-line)
                          (while (< (current-column) col)
                            (insert " "))
                          (beginning-of-line)
                          (forward-char col)))

                       ((string-match "\\[\\(?1:.*\\)\\(?2:[ABCD]\\)" ansi-code)
                        (let ((count (string-to-int
                                      (match-string 1 ansi-code)))
                              (cmd (match-string 2 ansi-code)))

                          (cond
                           ;;TODO: does up and down command preserve columns(?)
                           ;; Moves the cursor up by COUNT rows
                           ((string-equal cmd "A")
                            (forward-line ;; negative goes back
                             (- (min
                                 count
                                 (count-lines (point-min)
                                              (point))))))
                           ;; moves the cursor down by COUNT rows
                           ((string-equal cmd "B")
                            (forward-line count))
                           ;; moves the cursor forward by COUNT columns
                           ((string-equal cmd "C")
                            (forward-char count))
                           ;; moves the cursor backward by COUNT columns
                           ((string-equal cmd "D")
                            (if (> (current-column) count)
                                (backward-char count)
                              (beginning-of-line))))))

                       ;; clear all to the right
                       ((string-equal ansi-code "[0K") (kill-line))
                       ;; idem
                       ((string-equal ansi-code "[K") (kill-line))
                       ;; Requests a Report Device Code response from the device. (WTF?)
                       ((string-equal ansi-code "[c") nil)
                       ;; erase all current line
                       ((string-equal ansi-code "[2K") (kill-whole-line))
                       ;; erase from cursor to begining of line
                       ((string-equal ansi-code "[1K") (kill-backward-chars (- (current-column) 1)))
                       ;; clear vertical tabulation (?)
                       ((string-equal ansi-code "[1G") (beginning-of-line))
                       ;; Show the cursor (duh!)
                       ((string-equal ansi-code "[?25h") nil)
                       ;; insert unrecognized
                       (t (insert (format "[%s]"ansi-code))))
                    (error "ERROR: %s" ansi-code))

                  ;; process the rest
                  (setq str (substring str (cadr (match-data))))))

              ;; insert piece after last code
              (insert str))

            ;;TODO Try to detect errors and such
            (when (string-match-p "Error" string)
              (hmz-misc/mac-notify "Filter got and Error!" string))

            (if (< (process-mark proc) (point))
                (ansi-color-apply-on-region (marker-position (process-mark proc)) (point))
              (ansi-color-apply-on-region (point-min) (marker-position (process-mark proc))))

            (set-marker (process-mark proc) (point)))

          (if moving (goto-char (process-mark proc)))))))

  (defun hmz-misc/bpr-clear-or-kill ()
    "If process is running clear buffer, kills it otherwise."
    (interactive)
    (if (process-live-p (get-buffer-process (current-buffer)))
        (if (zerop (buffer-size))
            (kill-this-buffer)
          (erase-buffer))
      (kill-this-buffer)))

  (defun hmz-misc/bpr-on-error (process)
    (hmz-misc/mac-notify "Error" (process-name process))
    (with-current-buffer (process-buffer process)
      (save-excursion
        (rename-buffer
         (replace-regexp-in-string "\[.*\]" "[ERROR]" (format "%s"(tabbar-tab-value tab)))))))

  (defun hmz-misc/bpr-on-success (process)
    (hmz-misc/mac-notify "Success" (process-name process))
    (with-current-buffer (process-buffer process)
      (save-excursion
        (rename-buffer
         (replace-regexp-in-string "\[.*\]" "[OK]" (buffer-name))))))

  (defun hmz-misc/bpr-on-start (process)

    ;; (setq buffer-face-mode-face `(:background "#111111"))
    ;; (buffer-face-mode 1)
    (switch-to-buffer-other-window (process-buffer process))
    (tabbar-local-mode -1) ;; often it gets hidden, I suppose this helps
    (set-process-filter process 'hmz-misc/bpr-process-filter)
    (set-process-sentinel process 'hmz-misc/bpr-process-sentinel)
    (with-current-buffer (process-buffer process)
      (save-excursion
        (local-set-key  (kbd "s-k") 'hmz-misc/bpr-clear-or-kill)
        (text-scale-decrease 2)
        (setq tab-width 8)
        (setq overwrite-mode 'overwrite-mode-binary)
        (rename-buffer
         (replace-regexp-in-string "\(.*\)" (concat "[" (format "%s" (process-id process)) "]") (buffer-name)))))

    (hmz-misc/mac-notify "Started" (process-name process)))

  (defun hmz-misc/bpr-on-completion (process)
    (hmz-misc/mac-notify (format "Ended with status %d" (process-exit-status process)) (process-name process)))

  (spacemacs/set-leader-keys "a w" 'bpr-spawn)

  (setq bpr-on-error 'hmz-misc/bpr-on-error)
  (setq bpr-on-success 'hmz-misc/bpr-on-success)
  (setq bpr-on-completion 'hmz-misc/bpr-on-completion)
  (setq bpr-on-start 'hmz-misc/bpr-on-start)

  (defun preamble-regexp-alternatives (regexps)
    "Return the alternation of a list of regexps."
    (mapconcat (lambda (regexp)
                 (concat "\\(?:" regexp "\\)"))
               regexps "\\|"))

  (defvar non-sgr-control-sequence-regexp nil
    "Regexp that matches non-SGR control sequences.")

  (defun regexp-alternatives (regexps)
    (mapconcat (lambda (regexp) (concat "\\(" regexp "\\)")) regexps "\\|"))

  (setq non-sgr-control-sequence-regexp
        (regexp-alternatives
         '(;; icon name escape sequences
           "\033\\][0-2];.*?\007"
           ;; non-SGR CSI escape sequences
           "\033\\[\\??[0-9;]*[^0-9;m]"
           ;; noop
           "\012\033\\[2K\033\\[1F"
           )))

  (defun filter-non-sgr-control-sequences-in-region (begin end)
    (save-excursion
      (goto-char begin)
      (while (re-search-forward
              non-sgr-control-sequence-regexp end t)
        (message (match-string))
        (replace-match ""))))

  (defun filter-non-sgr-control-sequences-in-output (ignored)
    (let ((start-marker
           (or comint-last-output-start
               (point-min-marker)))
          (end-marker
           (process-mark
            (get-buffer-process (current-buffer)))))
      (filter-non-sgr-control-sequences-in-region
       start-marker
       end-marker)))

  ;; (setq    'comint-output-filter-functions nil  )
  ;; (add-hook 'comint-output-filter-functions
  ;;           'filter-non-sgr-control-sequences-in-output)

  ;; no showing progress on echo line
  (setq bpr-show-progress nil)

  ;; use ansi-color-apply-on-region function on output buffer
  (setq bpr-colorize-output nil)

  ;; use comint-mode for processes output buffers instead of shell-mode
  (setq bpr-process-mode 'shell-mode)

  (setq bpr-scroll-direction -1)
  ;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
  ;; (add-hook 'comint-mode-hook 'ansi-color-for-comint-mode-on)

  ;; (add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

  )

(use-package command-log-mode
  :straight t
  :config
  (global-command-log-mode))

(use-package drag-stuff
  :straight t
  :init
  (drag-stuff-global-mode 1)
  (drag-stuff-define-keys))

(use-package neotree
  ;; :disabled
  :straight t
  :after (all-the-icons rainbow-identifiers)
  :init
  ;; I'm leaving most of these settings to customize
  (setq neo-auto-indent-point t)
  (setq neo-autorefresh nil)

  ;;TODO: it crawls to a death in big dirs, going to bet on refreshing on
  ;;      buffer change. Possibly adding a timeout for it to occur.
  (setq neo-banner-message "")
  (setq neo-create-file-auto-open t)
  (setq neo-filepath-sort-function (lambda (f1 f2) (string< (downcase f1)
                                                       (downcase f2))))

  (setq neo-vc-integration (quote (face char)))
  (setq neo-force-change-root t)
  (setq neo-show-hidden-files t)
  (setq neo-show-updir-line nil)
  (setq neo-smart-open t)
  (setq neo-theme (if (display-graphic-p) (quote icons) (quote arrow)))
  (setq neo-window-fixed-size nil)
  (setq neo-window-position (quote right))

  (setq neo-hidden-regexp-list
        '("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" "\\.o$" ;; defaults
          ;; add yours:
          "__.*__"))

  :config
  (use-package switch-buffer-functions
    :straight t
    :config
    (setq switch-buffer-functions nil)
    (add-hook 'switch-buffer-functions
              (lambda (prev cur)
                ;; (tabbar-mode 1)
                (unless (or (string= (buffer-name) "*Messages*")
                            (string= (buffer-name) neo-buffer-name)
                            (file-remote-p (buffer-file-name)))
                  (if (and (neo-global--window-exists-p) (buffer-file-name))
                      (neotree-refresh t)
                    (neotree-hide))))))

  (defun hmz-winum-assign-func ()
    (cond
     ((equal (buffer-name) "*Calculator*") 10)
     ((string-match-p (buffer-name) ".*\\*NeoTree\\*.*") 9)
     (t nil)))

  (setq winum-assign-func 'hmz-winum-assign-func)

  (defun neo-buffer--insert-dir-entry (node depth expanded)
    "Overriden function to get rid of useless typography."
    (let ((node-short-name (neo-path--file-short-name node)))
      (insert
       (propertize " "
                   'display `(space :width ,(* 2 (- depth 1)) )))

      (when (memq 'char neo-vc-integration)

        (insert
         (propertize " "
                     'display `(space :width 0.35))))

      (neo-buffer--insert-fold-symbol
       (if expanded 'open 'close) node)
      (insert-button (concat node-short-name "")
                     'follow-link t
                     'face neo-dir-link-face
                     'neo-full-path node
                     'keymap neotree-dir-button-keymap
                     'help-echo
                     (neo-buffer--help-echo-message node-short-name))
      (neo-buffer--node-list-set nil node)
      (neo-buffer--newline-and-begin)))

  (setq hmz-misc/neo-sort-dir-with-files t)

  (defun neo-buffer--insert-tree (path depth)
    (if (eq depth 1)
        (neo-buffer--insert-root-entry path))
    (let* ((contents (neo-buffer--get-nodes path))
           (nodes (car contents))
           (leafs (cdr contents))
           (default-directory path))

      (if (> (length nodes) 200)
          (insert " ··· \n")
        (if (bound-and-true-p hmz-misc/neo-sort-dir-with-files)
            (let ((sorted (sort
                           (append (car contents) (cdr contents))
                           (lambda (s1 s2)
                             (string< (upcase s1) (upcase s2) )))))
              (dolist (node sorted)
                (if (file-directory-p node)
                    (let ((expanded (neo-buffer--expanded-node-p node)))
                      (neo-buffer--insert-dir-entry
                       node depth expanded)
                      (if expanded (neo-buffer--insert-tree (concat node "/")
                                                            (+ depth 1))))

                  (neo-buffer--insert-file-entry node depth))))

          (dolist (node nodes)
            (let ((expanded (neo-buffer--expanded-node-p node)))
              (neo-buffer--insert-dir-entry
               node depth expanded)
              (if expanded (neo-buffer--insert-tree (concat node "/")
                                                    (+ depth 1)))))
          (dolist (leaf leafs)
            (neo-buffer--insert-file-entry leaf depth))))))

  (defun neo-buffer--insert-file-entry (node depth)
    "Overriden so it can be configured to show files and directories together."

    (let ((node-short-name (neo-path--file-short-name node))
          (vc (when neo-vc-integration (neo-vc-for-node node))))


      (insert
       (propertize " "
                   'display `(space :width ,(+ 0.3 (* 2 (- depth 1))))))

      (neo-buffer--insert-fold-symbol 'leaf node-short-name)

      (insert-button node-short-name
                     'follow-link t
                     'face neo-file-link-face
                     'neo-full-path node
                     'keymap neotree-file-button-keymap
                     'help-echo (neo-buffer--help-echo-message node-short-name))
      (neo-buffer--node-list-set nil node)
      (neo-buffer--newline-and-begin)))

  (defun neo-buffer--insert-fold-symbol (name &optional node-name)
    "Overriden to make it less noisy. Made to work with non-monospaced fonts."
    (let ((vc (when neo-vc-integration (neo-vc-for-node node)))
          (n-insert-symbol (lambda (n)
                             (neo-buffer--insert-with-face
                              n 'neo-expand-btn-face))))
      (cond
       ((and (display-graphic-p) (equal neo-theme 'icons))

        (or (and (equal name 'open)
                 (insert
                  (propertize
                   " "
                   'display '((raise 0)
                              (space :width 0.0)))
                  (propertize
                   (concat " " (all-the-icons-octicon "triangle-down"))
                   'face `(:family ,(all-the-icons-octicon-family) :foreground "skyblue" :height 1.2)
                   'display '(raise -0.0))
                  (propertize
                   " "
                   'display '((raise 0)
                              (space :width 0.3)))))

            (and (equal name 'close)
                 (insert

                  (propertize
                   " "
                   'display '((raise 0.00)
                              (space :width 0.50)))
                  (propertize
                   (all-the-icons-octicon "triangle-right")
                   'face `(:family ,(all-the-icons-octicon-family) :foreground  "grey40" :height 1.2 )
                   'display '(raise 0.0))

                  (propertize
                   " "
                   'display '((raise 0)
                              (space :width 0.5)))))

            (and (equal name 'leaf)
                 (if vc
                     (let ((vc-string (char-to-string (car vc))))

                       (insert (propertize vc-string
                                           'display '(height 0.80)
                                           'face (if (memq 'face neo-vc-integration)
                                                     (cdr vc)
                                                   neo-file-link-face)))
                       (if (string-equal vc-string " ")
                           (insert
                            (propertize " " 'display '(space :width 0.90)))
                         (insert (propertize " " 'display '(space :width 0.70)))))

                   (insert
                    (propertize " "
                                'display `(space :width 1.00))))



                 )))
       (t
        (or (and (equal name 'open)  (funcall n-insert-symbol "▼ "))
            (and (equal name 'close) (funcall n-insert-symbol "► ")))))))

  (defun neo-opens-outwards ()
    "Reveals Neotree expanding frame and tries to compensate internal size."
    (interactive)
    (if (neo-global--window-exists-p)
        (progn
          (setq hmz-neotree-hidden t)
          (neotree-hide))

      (let ((origin-buffer-file-name (buffer-file-name)))
        (setq hmz-neotree-hidden nil)
        (neotree-find (projectile-project-root))
        (neotree-find origin-buffer-file-name))))

  (global-set-key (kbd "s-r") 'neo-opens-outwards)
  (global-set-key (kbd "H-r") 'neo-opens-outwards)

  (defun hmz-neotree-mode ()
    (interactive)

    ;; hide line numbers
    (linum-mode 0)
    (display-line-numbers-mode 0)

    ;; go away with modeline
    (hidden-mode-line-mode t)

    ;; custom doesn't work, neither does setting on init file
    (setq neo-buffer--show-hidden-file-p nil)

    ;; hide cursor when not active
    (setq cursor-in-non-selected-windows nil)

    ;; no scroll bars
    (scroll-bar-mode 0)
    ;; (yascroll-bar-mode 1)
    (spacemacs/toggle-truncate-lines-on)

    ;; highlight current line
    (hl-line-mode t)
    ;; hl-line-mode when window not in focus
    (setq hl-line-sticky-flag t)

    ;; disable fringes
    (setq left-fringe-width 0)
    (setq right-fringe-width 0)

    ;; makes the icons smaller, once there's no face settings
    ;; for them.
    (text-scale-set -1)

    ;; no line wrap
    (toggle-word-wrap 1)
    (set-default 'truncate-lines t)
    (toggle-truncate-lines 1)

    ;; Set width here so it takes scaled font size
    (setq neo-window-width 34)
    (setq neo-window-fixed-size nil))

  (add-hook 'neotree-mode-hook 'hmz-neotree-mode)

  (defadvice neo-buffer--refresh (after hmz-keep-hl-line-after-buffer-refresh 1 () activate)
    "Keep hl-line active after refreshing neotree's tree."
    (hl-line-mode t)
    (setq hl-line-sticky-flag t))

  (defadvice tabbar-cycle (after hmz-refresh-neotree-upon-cycle-tabs 1 () activate)
    (when (neo-global--window-exists-p)
      (neotree-refresh t )))

  (defadvice next-buffer (after hmz-refresh-neotree-change-next-buffer 1 () activate)
    (when (not (eq buffer-file-name neo-buffer-name))
      (if (buffer-file-name)
          (neotree-refresh t)
        (neotree-hide)
        ))
    )

  (setq hmz-neotree-hidden t)

  (defadvice previous-buffer (after hmz-refresh-neotree-change-previous-buffer 1 () activate)
    (when (not (eq buffer-file-name neo-buffer-name))
      (if (or buffer-file-name (not hmz-neotree-hidden))
          (neotree-refresh t)
        (neotree-hide)
        ))
    )

  (defun neo-global--do-autorefresh ()
    "Overriden version of neotree refresh function that doesn't try to refresh buffers that are not visiting a file and generating error and jumping cursor as result."
    (interactive)
    (when (and neo-autorefresh (neo-global--window-exists-p) buffer-file-name (not (eq (current-buffer) "*NeoTree*"))
               (neotree-refresh t)))))

(provide 'hmz-modules)
