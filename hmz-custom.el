;; here are simple elisp customizations that may break and so cat get turned off easily

  (interactive)
  (if (= 1 (length (window-list frame)))
      (condition-case nil
          (progn
            ;;(kill-this-buffer)
            (delete-frame frame force))
        (error 'hide-application))
    (delete-window window)))

;; Unix Style C-h
(global-set-key (kbd "C-?") 'help-command) ;; this isn't working...
(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
;; (global-set-key (kbd "C-g") 'evil-force-normal-state)
;; make tab and shift tab move between MRU buffers
(define-key evil-normal-state-map (kbd "<S-tab>") 'previous-buffer)
(define-key evil-normal-state-map (kbd "<tab>") 'next-buffer)
;; command-t
(global-set-key (kbd "s-t") 'helm-projectile-find-file)
(global-set-key (kbd "H-t") 'helm-projectile-find-file)
(define-key evil-normal-state-map (kbd "C-h") 'help-command)

(global-set-key (kbd "s-w") 'delete-window-or-frame)

;; Kill region on paste
(delete-selection-mode 1)


;; ?Redefine transient state to include Next Conflicted File function
(spacemacs|define-transient-state smerge
  :title "smerge transient state"
  :doc "
 movement^^^^               merge action^^           other
 ---------------------^^^^  -------------------^^    -----------
 [_n_]^^    next hunk       [_b_] keep base          [_u_] undo
 [_p_]  prev hunk         [_m_] keep mine          [_r_] refine
 [_j_/_k_]  move up/down    [_a_] keep all           [_q_] quit
 [_N_]^^    next file       [_o_] keep other
 ^^^^                       [_c_] keep current
 ^^^^                       [_C_] combine with next"
  :bindings
  ("n" smerge-next)
  ("p" smerge-prev)
  ("N" smerge-vc-next-conflict)
  ("j" evil-next-line)
  ("k" evil-previous-line)
  ("a" smerge-keep-all)
  ("b" smerge-keep-base)
  ("m" smerge-keep-mine)
  ("o" smerge-keep-other)
  ("c" smerge-keep-current)
  ("C" smerge-combine-with-next)
  ("r" smerge-refine)
  ("u" undo-tree-undo)
  ("q" nil :exit t))

(defun hmz-init/org-prettify ()
  "Beautify Org Block Symbols"
  (interactive)
  ;; no point on checking delimiters on org-mode
  ;; (rainbow-delimiters-mode-enable)
  (prettify-symbols-mode 0)
  (setq prettify-symbols-alist '())
  (push '("TODO:" . ?⚡) prettify-symbols-alist)
  (push '("DONE:" . ?✓) prettify-symbols-alist)
  (push '("CANCELED:" . ?✗) prettify-symbols-alist)
  (push '("#+begin_src sh" . ?❯) prettify-symbols-alist)
  (push '("#+begin_src shell" . ?❯) prettify-symbols-alist)
  (push '("#+begin_src md" . ?𝐌) prettify-symbols-alist)
  (push '("#+begin_src elixir" . ?🪔) prettify-symbols-alist)
  (push '("#+begin_src markdown" . ?𝐌) prettify-symbols-alist)
  (push '("#+begin_src dockerfile" . ?🐋) prettify-symbols-alist)
  (push '("#+begin_src yaml" . ?Ӱ) prettify-symbols-alist)
  (push '("#+begin_src ruby" . ?ᚱ) prettify-symbols-alist)
  (push '("#+begin_src js" . ?J) prettify-symbols-alist)
  (push '("#+begin_src sql" . ?☷) prettify-symbols-alist)
  (push '("#+begin_src elisp" . ?ε) prettify-symbols-alist)
  (push '("#+end_src" . ?❮) prettify-symbols-alist)
  (push '("#+header:" . ?☰) prettify-symbols-alist)
  (push '("#+begin_example" . ?❝) prettify-symbols-alist)
  (push '("#+end_example" . ?❞) prettify-symbols-alist)
  (push '("#+begin_comment" . ?❝) prettify-symbols-alist)
  (push '("#+end_comment" . ?❞) prettify-symbols-alist)
  (push '("#+begin_notes" . ?❝) prettify-symbols-alist)
  (push '("#+end_notes" . ?❞) prettify-symbols-alist)
  (push '("#+begin_quote" . ?❝) prettify-symbols-alist)
  (push '("#+end_quote" .  ?❞) prettify-symbols-alist)
  (push '("#+author:" .  "—") prettify-symbols-alist)
  (push '("#+title:" .  " ❯ ") prettify-symbols-alist)

  (push '("[ ]" . "☐") prettify-symbols-alist)
  (push '("[X]" . "☑" ) prettify-symbols-alist)
  (push '("[-]" . "❍" ) prettify-symbols-alist)
  (push '("#+DOWNLOADED.*$" . "❍" ) prettify-symbols-alist)
  (prettify-symbols-mode 1))

(add-hook 'org-mode-hook 'hmz-init/org-prettify)

;; my org-mode settings
(defun hmz-init/org-config ()
  (interactive)

  ;; org-mode block syntax highlight (untested)
  (setq org-src-fontify-natively t)

  (ignore-errors
    (drag-stuff-mode 1)
    (spacemacs/toggle-visual-line-navigation-on))

  (setq org-log-done nil)
  (org-indent-mode t)
  (setq-local word-wrap nil))

;; make frames reusable (one is aware of the other)
(add-to-list 'display-buffer-alist
             '("." nil (reusable-frames . t)))

(add-hook 'org-mode-hook 'hmz-init/org-config)

;; brew install coreutils
(if (executable-find "gls")
    (progn
      (setq insert-directory-program "gls")
      (setq dired-listing-switches "-lFaGh1v --group-directories-first"))
  (setq dired-listing-switches "-ahlF"))

;; change granularity from emacs to the vim behavior
(setq evil-want-fine-undo 'fine)

;; magit
(setq
 magit-diff-refine-hunk 'all
 magit-diff-adjust-tab-width t
 magit-diff-paint-whitespace 'all
 magit-diff-highlight-trailing 'all
 magit-diff-highlight-indentation nil)


;; macro to comment things
(defmacro comment (&rest body)
  "Comment out one or more s-expressions."
  nil)

;; put save file on my own .spacemacs.d dir
(setq persistent-scratch-save-file "~/.spacemacs.d/.persistent-scratch")


;; keep undo tree across restarts
(setq undo-tree-auto-save-history t)

;; keep undo tree files in proper place
(setq undo-tree-history-directory-alist '(("." . "~/.spacemacs.d/undo")))

;; org-mode grap-link shortcut
;; (add-hook 'org-mode-hook
;;           (lambda () (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link)))

  (setq org-use-property-inheritance t)

;; C-o for add heading above in org-mode
;; TODO: move it to a layer/file about org-mode
(defun org-insert-heading-above ()
  (interactive)
  (move-beginning-of-line nil)
  (org-insert-heading))

(defun hmz-custom/ibuffer-mode-hook ()
  (spacemacs/toggle-truncate-lines-off))

(add-hook 'ibuffer-mode-hook 'hmz-custom/ibuffer-mode-hook)

(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "C-o") 'org-insert-heading-above)))

(defun hmz-prog-mode-hook ()
  (interactive)

  (treemacs-follow-mode 1)

  (setq-default fill-column 80)

  (ignore-errors
    (lsp-mode -1)
    (lsp-ui-mode -1)
    (lsp-disconnect)
    (lsp-ui-mode -1))

  (when (and buffer-read-only
         (fboundp 'color-theme-buffer-local))
    (color-theme-buffer-local 'color-theme-classic (current-buffer)))

  (setq lsp-ui-doc-enable nil)

  (setq mouse-wheel-tilt-scroll t)
  (setq mouse-wheel-flip-direction t)

  ;; autofill is a little nuts lately
  (auto-fill-mode -1)

  (setq indent-guide-char "•")
  (setq indent-guide-mode 1)


  ;; projectile will make slower indexing but use .projectile for ignore
  (setq projectile-use-native-indexing t)
  (setq projectile-enable-caching t)

  (setq require-final-newline t)

  (which-function-mode 0)

  (face-remap-add-relative 'default '(:height 140))

  (linum-mode -1)

  (flyspell-mode t)
  (flyspell-prog-mode)

  ;; FIXME: make me work
  ;; BUG: it's not activating when prog-mode fires
  ;; TODO: fix all that garbage
  ;; highlights FIXME, TODO, etc
  (if (featurep 'fic-mode)
      (fic-mode t))

  (flycheck-mode 1)


  (display-line-numbers-mode 1)

  (smartparens-global-mode t)
  (global-evil-matchit-mode 1)

  (visual-line-mode t)
  (adaptive-wrap-prefix-mode 1))


(add-hook 'prog-mode-hook 'hmz-prog-mode-hook)
(add-hook 'text-mode-hook 'hmz-prog-mode-hook)

;; Shiny symbols like eclipse
(spacemacs/toggle-automatic-symbol-highlight-on)

;; make tab and shift tab move between MRU buffers
(define-key evil-normal-state-map (kbd "<S-tab>") 'previous-buffer)
(define-key evil-normal-state-map (kbd "<tab>") 'next-buffer)

;; just use git
(setq vc-handled-backends '(Git))

;; change executable for rspec
(defun rspec-compile-on-line ()
  (interactive)
  (progn
    (window-configuration-to-register 9)
    (compile (format "cd %s;bundle exec spring rspec -f doc %s:%s"
                     (get-closest-gemfile-root)
                     (file-relative-name (buffer-file-name) (get-closest-gemfile-root))
                     (line-number-at-pos)
                     ) t)))

;; Shiny symbols like eclipse
(spacemacs/toggle-automatic-symbol-highlight-on)

;; Thou shall not pass the eightiegh column of thy code
(global-column-enforce-mode 1)

(define-fringe-bitmap 'right-curly-arrow
  [#b00000000
   #b00000000
   #b00000000
   #b00000000
   #b01110000
   #b00010000
   #b00010000
   #b00000000])
(define-fringe-bitmap 'left-curly-arrow
  [#b00000000
   #b00001000
   #b00001000
   #b00001110
   #b00000000
   #b00000000
   #b00000000
   #b00000000])

  ;; (defun my-esc (prompt)
  ;;   "Functionality for escaping generally. Includes exiting Evil
  ;;    insert state and C-g binding. "
  ;;   (cond
  ;;    ((or (evil-insert-state-p)
  ;;         (evil-normal-state-p)
  ;;         ;; (evil-replace-state-p)
  ;;         (evil-visual-state-p)) [escape])
  ;;    (t (keyboard-quit))
  ;;    ))



(defun hmz-init/evil-keyboard-quit (&optional prompt)
  "Keyboard quit and force normal state."
  (interactive)
  ;; (cond (evil-mode (evil-force-normal-state))
  ;;       (t (keyboard-escape-quit)))
  ;; (keyboard-escape-quit)
  (evil-force-normal-state)
  [escape]
  ()
  )

(global-set-key (kbd "C-g") 'hmz-init/evil-keyboard-quit)
(define-key key-translation-map (kbd "C-g") #'hmz-init/evil-keyboard-quit)
(global-set-key (kbd "s-w") 'delete-window-or-frame)

(use-package evil-magit
  :after (magit evil)
  :config
  (define-key transient-map (kbd "<escape>") 'transient-quit-one)
  (define-key transient-map (kbd "C-g") 'transient-quit-one))



(add-hook 'minibuffer-setup-hook 'hmz-init/minibuffer-setup)
(defun hmz-init/minibuffer-setup ()
  (setq evil-emacs-state-cursor '("SkyBlue2" bar))
  (set (make-local-variable 'face-remapping-alist)
       '((default :height 1.5))))

;; Always follow symlinks
(setq vc-follow-symlinks t)
;; Stylize Echo Area (interestingly it ends up applying other faces styles)
(with-current-buffer (get-buffer " *Echo Area 0*")   ; the leading space character is correct
  (setq-local face-remapping-alist
              '((default (:height 1.3 :foreground "#CCC") variable-pitch)))) ; etc.


(linum-mode 0)
(display-line-numbers-mode 1)
(global-display-line-numbers-mode t)

;; org-mode prettify symbols
(defun hmz-init/org-prettify ()
  "Beautify Org Block Symbols"
  (interactive)

  ;; no point on checking delimiters on org-mode
  (rainbow-delimiters-mode-disable)

  (prettify-symbols-mode 0)
  (setq prettify-symbols-alist '())
  (push '("TODO:" . ?⚡) prettify-symbols-alist)
  (push '("WAIT:" . ?⏳) prettify-symbols-alist)
  (push '("DONE:" . ?✓) prettify-symbols-alist)
  (push '("Q:" . ??) prettify-symbols-alist)
  (push '("CANCELED:" . ?✗) prettify-symbols-alist)
  (push '("#+begin_src sh" . ?❯) prettify-symbols-alist)
  (push '("#+begin_src shell" . ?❯) prettify-symbols-alist)
  (push '("#+begin_src md" . ?𝐌) prettify-symbols-alist)
  (push '("#+begin_src elixir" . ?🪔) prettify-symbols-alist)
  (push '("#+begin_src markdown" . ?𝐌) prettify-symbols-alist)
  (push '("#+begin_src dockerfile" . ?🐋) prettify-symbols-alist)
  (push '("#+begin_src yaml" . ?Ӱ) prettify-symbols-alist)
  (push '("#+begin_src ruby" . ?ᚱ) prettify-symbols-alist)
  (push '("#+begin_src js" . ?J) prettify-symbols-alist)
  (push '("#+begin_src sql" . ?☷) prettify-symbols-alist)
  (push '("#+begin_src elisp" . ?ε) prettify-symbols-alist)
  (push '("#+end_src" . ?❮) prettify-symbols-alist)
  (push '("#+header:" . ?☰) prettify-symbols-alist)
  (push '("#+begin_example" . ?❝) prettify-symbols-alist)
  (push '("#+end_example" . ?❞) prettify-symbols-alist)
  (push '("#+begin_comment" . ?❝) prettify-symbols-alist)
  (push '("#+end_comment" . ?❞) prettify-symbols-alist)
  (push '("#+begin_notes" . ?❝) prettify-symbols-alist)
  (push '("#+end_notes" . ?❞) prettify-symbols-alist)
  (push '("#+begin_quote" . ?❝) prettify-symbols-alist)
  (push '("#+end_quote" .  ?❞) prettify-symbols-alist)
  (push '("[ ]" . "☐") prettify-symbols-alist)
  (push '("[X]" . "☑" ) prettify-symbols-alist)
  (push '("[-]" . "❍" ) prettify-symbols-alist)
  (push '("#+DOWNLOADED.*$" . "❍" ) prettify-symbols-alist)
  (prettify-symbols-mode 1))

(add-hook 'org-mode-hook 'hmz-init/org-prettify)

;; magit open in full window
(setq magit-status-buffer-switch-function 'switch-to-buffer)
(setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)

;; avoid leaving stall branch information by VC
(setq auto-revert-check-vc-info nil)

;; avoid if tramp performance
(global-auto-revert-mode t)

;; 28.0 makes it much better; plus yascroll been broken lately
(scroll-bar-mode 0)

;; Trackpads send a lot more scroll events than regular mouse wheels,
;; so the scroll amount and acceleration must be tuned to smooth it out.
(setq
 ;; If the frame contains multiple windows, scroll the one under the cursor
 ;; instead of the one that currently has keyboard focus.
 mouse-wheel-follow-mouse 't

 mac-mouse-wheel-mode nil
 mac-mouse-wheel-smooth-scroll nil
 ;; Completely disable mouse wheel acceleration to avoid speeding away.
 mouse-wheel-progressive-speed nil
 ;; The most important setting of all! Make each scroll-event move 2 lines at
 ;; a time (instead of 5 at default). Simply hold down shift to move twice as
 ;; fast, or hold down control to move 3x as fast. Perfect for trackpads.
 mouse-wheel-scroll-amount '(3 ((shift) . 1) ((meta) . 10)))

(setq jiralib-url "https://sondermind-jira.atlassian.net")

(add-to-list 'load-path "/Users/HMz/.emacs.d/straight/repos/rspec-simple/")
(require 'rspec-simple)

;; Salve all Projectile buffers
(global-set-key (kbd "s-S") 'projectile-save-project-buffers)
(spacemacs/set-leader-keys "p s" 'projectile-save-project-buffers)

(defun hmz-init/before-save (save-fun &rest args)
  (set-buffer-modified-p t)
  (message "Saving... %s" buffer-file-name)
  (when (derived-mode-p 'vue-mode 'js-mode 'js2-mode 'typescript-mode)
    ;; (ignore-errors (prettier-js))
    )
  (if (and buffer-file-name (file-exists-p (buffer-file-name)))
      (progn
        (set-buffer-modified-p t)
        (apply save-fun args))
    (if (y-or-n-p (concat "Buffer " (buffer-name) " has no file on disk! Create it?"))
        (apply save-fun args))))

(advice-add 'save-buffer :around #'hmz-init/before-save)

(spacemacs/toggle-vi-tilde-fringe-off)

;; ;; Breadcrumb in modeline: https://www.reddit.com/r/emacs/comments/qxzadv/moving_lspmode_breadcrumbs_to_modeline/
;; (add-hook 'lsp-configure-hook (lambda ()
;;                                 (lsp-headerline-breadcrumb-mode 1)))

;; (spaceline-define-segment ol/lsp-breadcrumb-spaceline
;;   (when (bound-and-true-p lsp-mode)
;;     (when (functionp 'lsp-headerline--build-string)
;;       (replace-regexp-in-string "^>  " "" (concat
;;                                            (lsp-headerline--build-string)
;;                                            "")))))

;; bm layer customs
(define-key evil-normal-state-map (kbd "<left-fringe> <mouse-5>") 'bm-next-mouse)
(define-key evil-normal-state-map (kbd "<left-fringe> <mouse-4>") 'bm-previous-mouse)
(define-key evil-normal-state-map (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)
(define-key evil-normal-state-map (kbd "M-t") 'bm-toggle)
(define-key evil-normal-state-map (kbd "M-n") 'bm-next)
(define-key evil-normal-state-map (kbd "M-p") 'bm-previous)

;; this is overwritten by some autocomplete mode, redefining
(define-key evil-normal-state-map (kbd "C-i") 'evil-jump-forward)



(setq bm-marker 'bm-marker-right)

;; adapted from https://superuser.com/questions/1017094/emacs-jump-to-the-next-line-with-same-indentation
(defun jump-to-upper-indent (direction)
  (interactive)
  (let ((start-indent (current-indentation)))
    (while
        (and
         ;; not end-of-buffer
         (not (bobp))
         ;; the line is forwarded
         (zerop (forward-line (or direction 1)))
         ;; indentation at point is = or > than start
         (or (zerop (current-indentation))
             (>= (current-indentation)  start-indent)))))
  (back-to-indentation))


(global-set-key [?\M-{] #'(lambda () (interactive) (jump-to-upper-indent -1)))
(global-set-key [?\M-}] 'jump-to-upper-indent)

(evil-leader/set-key "/" 'spacemacs/helm-project-do-ag)
(setq helm-ag-base-command "ag --nocolor --nogroup")

(defun find-next-file (&optional backward)
  "Find the next file (by name) in the current directory. With prefix arg, find the previous file."
  (interactive "P")
  (when buffer-file-name
    (let* ((file (expand-file-name buffer-file-name))
           (files (cl-remove-if (lambda (file) (or (cl-first (file-attributes file))
                                              (string= (substring (file-name-nondirectory file) 0 1) ".")
                                              ))
                                (sort (directory-files (file-name-directory file) t nil t) 'string<)))

           (pos (mod (+ (cl-position file files :test 'equal) (if backward -1 1))
                     (length files))))
      (find-file (nth pos files))))

  )

(spacemacs/set-leader-keys "fN" (lambda () "Goto Notes" (interactive) (find-file "~/Documents/org/notes.org")))
(spacemacs/set-leader-keys "fp" #'(lambda () "Previous File"
                                    (interactive)
                                    (setq current-prefix-arg '(4)) ;; emulate prefix
                                    (call-interactively 'find-next-file)

                                    ))
(spacemacs/set-leader-keys "fn" #'(lambda () "Next File" (interactive) (call-interactively 'find-next-file)))

;; (require 'ob-js)

(add-to-list org-babel-load-languages '((js . t) (emacs-lisp . t) (shell . t)))

;; (add-to-list 'org-babel-tangle-lang-exts '("js" . "js"))

(org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . js-mode))

(setq split-width-threshold nil)

(defun org-to-clipboard-as-markdown ()
  (interactive)
  (let ((org-export-with-toc nil))
    (with-current-buffer (org-md-export-as-markdown)
      (clipboard-kill-region (point-min) (point-max))
      (kill-buffer))))

;; Convert org to markdown and save it to the Clipboard
(defun hmz/org-md-to-clipboard ()
  (interactive)
  (save-window-excursion
    (let ((org-export-with-toc nil))
      (let ((buf (org-export-to-buffer 'md "*tmp*" nil nil t t)))
        (save-excursion
          (set-buffer buf)
          (simpleclip-set-contents (buffer-string))
          (kill-buffer-and-window)
          )))))

(server-start)


(provide 'hmz-custom)
