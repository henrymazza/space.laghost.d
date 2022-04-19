;; here are simple elisp customizations that may break and so cat get turned off easily

(defun delete-window-or-frame (&optional window frame force)
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
(global-set-key (kbd "C-g") 'evil-force-normal-state)
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
  (push '("[ ]" . "☐") prettify-symbols-alist)
  (push '("[X]" . "☑" ) prettify-symbols-alist)
  (push '("[-]" . "❍" ) prettify-symbols-alist)
  (push '("#+DOWNLOADED.*$" . "❍" ) prettify-symbols-alist)
  (prettify-symbols-mode 1))

(add-hook 'org-mode-hook 'hmz-init/org-prettify)

;; my org-mode settings
(defun hmz-init/org-config ()
  (interactive)
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
(add-hook 'org-mode-hook
          (lambda () (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link)))


  (setq org-use-property-inheritance t)


;; C-o for add heading above in org-mode
;; TODO: move it to a layer/file about org-mode
(defun org-insert-heading-above ()
  (interactive)
  (move-beginning-of-line nil)
  (org-insert-heading))

(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "C-o") 'org-insert-heading-above)))

(defun hmz-prog-mode-hook ()
  (interactive)

  ;; projectile will make slower indexing but use .projectile for ignore
  (setq projectile-use-native-indexing t)
  (setq projectile-enable-caching t)

  (setq require-final-newline t)

  (which-function-mode 0)

  (face-remap-add-relative 'default '(:height 140))

  (linum-mode -1)
  (auto-fill-mode 1)

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

  (defun my-esc (prompt)
    "Functionality for escaping generally. Includes exiting Evil
     insert state and C-g binding. "
    (cond
     ((or (evil-insert-state-p)
          (evil-normal-state-p)
          (evil-replace-state-p)
          (evil-visual-state-p)) [escape])))
  (define-key key-translation-map (kbd "C-g") 'my-esc)

  (global-set-key (kbd "s-w") 'delete-window-or-frame)

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
(scroll-bar-mode 1)

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
 mouse-wheel-scroll-amount '(6 ((shift) . 1) ((meta) . 10)))

(provide 'hmz-custom)
