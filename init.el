;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

;; Pre Window Initialization code

(unless (bound-and-true-p mac-auto-operator-composition-mode)
    (let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
                   (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
                   (36 . ".\\(?:>\\)")
                   (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
                   (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
                   (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
                   (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
                   (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
                   ;; (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
                   (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
                   (48 . ".\\(?:x[a-zA-Z]\\)")
                   (58 . ".\\(?:::\\|[:=]\\)")
                   (59 . ".\\(?:;;\\|;\\)")
                   (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
                   (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
                   (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
                   (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
                   (91 . ".\\(?:]\\)")
                   (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
                   (94 . ".\\(?:=\\)")
                   (119 . ".\\(?:ww\\)")
                   (123 . ".\\(?:-\\)")
                   (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
                   (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
                   )
                 ))
      (dolist (char-regexp alist)
        (set-char-table-range composition-function-table (car char-regexp)
                              `([,(cdr char-regexp) 0 font-shape-gstring])))))


(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to
   ;; load. If it is the symbol `all' instead
  ;; of a list then all discovered layers will be installed.
  dotspacemacs-configuration-layers
  '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
    (auto-completion :variables
                     auto-completion-return-key-behavior 'complete
                     auto-completion-tab-key-behavior 'complete
                     auto-completion-complete-with-key-sequence nil
                     auto-completion-complete-with-key-sequence-delay 0.01)

    ;; custom layers
    hmz-tabbar
    hmz-misc
    (hmz-color-identifiers
     :variables hmz-color-identifiers-saturation 20)

    better-defaults
    ;; cb-yasnippet
    ;; (colors :variables colors-colorize-identifiers 'all)
    emacs-lisp
    evil-cleverparens
    evil-commentary
    git
    html
    javascript
    lua
    markdown
    osx
    ruby-on-rails
    (ruby :variables ruby-version-manager 'rbenv)
    (spell-checking :variables
                    spell-checking-enable-by-default nil)
    syntax-checking
    ;; themes-megapack
    typography
    ;; uninpaired
    version-control
    vinegar
    (shell :variables
           shell-default-position 'bottom
           shell-default-height 30
           shell-enable-smart-eshell t
           shell-default-shell 'eshell
           shell-default-full-span nil)
    )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
  dotspacemacs-additional-packages '(all-the-icons ember-mode sublimity persistent-scratch)
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages nil))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; Default theme
   dotspacemacs-default-theme 'dracula
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'hybrid
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'emacs-lisp-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-light dracula tango-dark tango)
                         ;; tango
                         ;; dracula
                         ;; nord
                         ;; spacemacs-dark
                         ;; solarized-dark
                         ;; monokai
                         ;; hc-zenburn)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Fira Code Light"
                              :size 18
                              :weight normal
                              :width normal
                              :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state t
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 95
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 100
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling nil
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers '(:disabled-for-modes text-mode)
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters nil
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '(ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'all

   ;; dotspacemacs-frame-title-format "%I@%S"

   dotspacemacs-show-transient-state-title nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."

  ;; Don't replace copied text with killed region
  (setq save-interprogram-paste-before-kill t)

  ;; avoid slowness
  (setq inhibit-compacting-font-caches t)

  ;; show garbage collection
  (setq garbage-collection-messages nil)

  ;; Hide title bar
  ;; (setq initial-frame-alist '((undecorated . t)))

  (add-to-list 'default-frame-alist '(undecorated . t))

  ;; make those tildes disapear
  (setq indicate-empty-lines nil)

  ;; keep undo tree across restarts
  (setq undo-tree-auto-save-history t)

  ;; keep undo tree files in proper place
  (setq undo-tree-history-directory-alist '(("." . "~/.spacemacs.d/undo")))
)

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place you code here."

  ;; Blink cursor so I know where I am!
  (blink-cursor-mode 1)

  ;; disable current line highlight
  (global-hl-line-mode -1)

  ;; windows divider
  (window-divider-mode 1)

  ;; Make insert cursor a vertical Bar. Keep default color.
  (setq evil-emacs-state-cursor '("SkyBlue2" bar))

  ;; really! disabel it!
  (scroll-bar-mode -1)

  ;; space in between lines
  (setq-default line-spacing 2)

  ;; keep scratch buffer throughout restarts
  (persistent-scratch-setup-default)

  ;; put save file on my own .spacemacs.d dir
  (setq persistent-scratch-save-file "~/.spacemacs.d/.persistent-scratch")

  ;; settings for window systems
  (when (window-system)
    ;;TODO make this conditional to screen size
    (set-frame-height (selected-frame) 32)
    (set-frame-position (selected-frame) 250 30)
    )

  ;; Ember Mode
  (add-hook 'js-mode-hook (lambda () (ember-mode t)))
  (add-hook 'web-mode-hook (lambda () (ember-mode t)))

  ;; Trackpads send a lot more scroll events than regular mouse wheels,
  ;; so the scroll amount and acceleration must be tuned to smooth it out.
  (setq
   ;; If the frame contains multiple windows, scroll the one under the cursor
   ;; instead of the one that currently has keyboard focus.
   mouse-wheel-follow-mouse 't
   ;; Completely disable mouse wheel acceleration to avoid speeding away.
   mouse-wheel-progressive-speed t
   ;; The most important setting of all! Make each scroll-event move 2 lines at
   ;; a time (instead of 5 at default). Simply hold down shift to move twice as
   ;; fast, or hold down control to move 3x as fast. Perfect for trackpads.
   mouse-wheel-scroll-amount '(2 ((shift) . 4) ((meta) . 6)))

  (define-key evil-normal-state-map (kbd "C-h") 'help-command)
  (define-key evil-normal-state-map (kbd "C-a") 'rotate-word-at-point)

  ;; Treat wrapped line scrolling as single lines
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

  ;; command-T
  (global-set-key (kbd "s-t") 'helm-projectile-find-file)
  (setq projectile-enable-caching t)

  ;; open files with command + o
  (global-set-key (kbd "s-o") 'find-file)

  ;; my old pal C-k
  (define-key evil-normal-state-map (kbd "C-k") 'kill-this-buffer)

  ;; spacemacs as default git editor
  (global-git-commit-mode t)

  ;; hide mode line
  (setq-default mode-line-format nil)

  (add-hook 'css-mode-hook (lambda () (rainbow-mode 1)))
  (add-hook 'prog-mode-hook
            (lambda ()
              ;; (hidden-mode-line-mode t)
              ;; (spacemacs/enable-transparency)
              ;; (rainbow-identifiers-mode t)
              ;; (rainbow-delimiters-mode-enable)
              ;; (rainbow-mode t)
              (visual-line-mode t)))

  ;; Unix Style C-h
  (global-set-key (kbd "C-?") 'help-command) ;; this isn't working...
  (global-set-key (kbd "M-?") 'mark-paragraph)
  (global-set-key (kbd "C-h") 'delete-backward-char)
  (global-set-key (kbd "M-h") 'backward-kill-word)
  (global-set-key (kbd "C-g") 'evil-force-normal-state)

  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2)
  (setq-default c-basic-offset 2)
  (setq indent-line-function 'insert-tab)

  ;; Coffeescript specific tabbing requirements
  (custom-set-variables '(coffee-tab-width 2))

  (defun setup-indent (n)
    ;; java/c/c++
    (setq c-basic-offset n)
    ;; web development
    (setq coffee-tab-width n) ; coffeescript
    (setq javascript-indent-level n) ; javascript-mode
    (setq js-indent-level n) ; js-mode
    (setq js2-basic-offset n) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
    (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
    (setq html-mode-markup-indent-offset n) ; web-mode, html tag in html file
    (setq web-mode-css-indent-offset n) ; web-mode, css in html file
    (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
    (setq css-indent-offset n)) ; css-mode

  (setup-indent 2)

  ;; C-w to kill word backwards
  (defun kill-region-or-backward-kill-word (&optional arg region)
    "`kill-region' if the region is active, otherwise `backward-kill-word'"
    (interactive
     (list (prefix-numeric-value current-prefix-arg) (use-region-p)))
    (if region
        (kill-region (region-beginning) (region-end))
      (backward-kill-word arg)))
  (global-set-key (kbd "C-w") 'kill-region-or-backward-kill-word)

  ;; Kill region on paste
  (delete-selection-mode 1)

  ;; ;; set rainbow-mode
  ;; (use-package rainbow-mode
  ;;   :defer t
  ;;   :init
  ;;   (setq rainbow-html-colors-major-mode-list '(css-mode
  ;;                                               less-css-mode
  ;;                                               sass-mode
  ;;                                               scss-mode))
  ;;   (dolist (mode rainbow-html-colors-major-mode-list)
  ;;     (add-hook (intern (format "%s-hook" mode)) 'rainbow-mode)))

  (setq-default create-lockfiles nil)

  (add-hook 'coffee-mode-hook 'company-mode-on)

   (defun my-esc (prompt)
     "Functionality for escaping generally.  Includes exiting Evil insert state and C-g binding. "
     (cond
      ((or (evil-insert-state-p)
           ;; (evil-normal-state-p)
           (evil-replace-state-p)
           (evil-visual-state-p)) [escape])))
   (define-key key-translation-map (kbd "C-c") 'my-esc)

   (defun hide-application ()
     "Hides Emacs if trying to close last frame."
     (condition-case nil
         (ns-do-hide-emacs)
       (error (do-applescript "
              tell application \"System Events\"
                set frontmostProcess to first process where it is frontmost
                set visible of frontmostProcess to false
              end tell"))))

   (defun delete-window-or-frame (&optional window frame force)
     (interactive)
     (if (= 1 (length (window-list frame)))
         (condition-case nil
             (progn
               ;;(kill-this-buffer)
              (delete-frame frame force))
           (error 'hide-application))
       (delete-window window)))

   (global-set-key (kbd "s-w") 'delete-window-or-frame)

   (spacemacs/set-leader-keys "SPC" 'helm-M-x)

   ;; When running ‘projectile-switch-project’ (C-c p p), ‘neotree’ will
   ;; change root automatically and avoid annoying Dired buffer.
   (setq projectile-switch-project-action 'neotree-projectile-action)


   ;; (add-hook 'minibuffer-inactive-mode-hook
   ;;           (lambda ()
   ;;             (message "fr: %S, active: %S"
   ;;                      (selected-frame) (active-minibuffer-window))))
   (add-hook 'minibuffer-setup-hook
             (lambda ()
               ;; I don't know why minibuffer have this cursor color
               (setq evil-emacs-state-cursor '("SkyBlue2" bar))
               (text-scale-set 2)))

   ;; Always follow symlinks
   (setq vc-follow-symlinks t)


   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; Messages Customs
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   (setq hmz-messages-frame nil)

   (defun hmz-make-mini-monitor ()
     (interactive)
     ;; global
     (if (and hmz-messages-frame (frame-live-p hmz-messages-frame))
         (delete-frame hmz-messages-frame)

       (setq hmz-messages-frame
             (make-frame
              '((visibility . t)
                (name . "Monitor")
                (minibuffer . nil)
                (height . 35) (width . 35)
                (top - 0) (left . 0)
                (buffer-list . '("*Messages*"))
                (unsplittable . t))))

       ;; (:eval (tabbar-line))
       ;; (message "%s" hmz-messages-frame)

       ;; (with-selected-frame hmz-messages-frame
       ;;   ;; disables tabbar completly for that window
       ;;   (setq-local header-line-format nil))

       (with-selected-window (frame-selected-window hmz-messages-frame)
         (add-hook 'focus-out-hook
                   (lambda () (spacemacs/enable-transparency hmz-messages-frame)))
         (add-hook 'focus-in-hook
                   (lambda () (spacemacs/disable-transparency hmz-messages-frame)))
         (spacemacs/enable-transparency hmz-messages-frame 70)
         (setq dotspacemacs-inactive-transparency 60)
         (tabbar-local-mode 0)
         (switch-to-buffer "*Messages*")
         (text-scale-set -2)
         (set-frame-parameter hmz-messages-frame 'unsplittable t)

         (setq-local header-line-format nil) ;; disables tabbar completly for that window
         (setq left-fringe-width 0)
         (setq right-fringe-width 0)
         (set-window-fringes (selected-window) 0 0 nil)
         (hidden-mode-line-mode 1)
         )))

       (global-set-key (kbd "s-m") 'hmz-make-mini-monitor)

       ;; keep last messages visible
       (defadvice message (after message-tail activate)
         "goto point max after a message"
         ;;don't make anything if *Messages* is current
         (unless (eq (current-buffer) "*Messages*")
           (with-current-buffer "*Messages*"
             (goto-char (point-max))

             ;; There's a problem: minibuffer help messages activates this very same function
             ;;
             ;; (if (and hmz-messages-frame (frame-live-p hmz-messages-frame))
             ;;     (with-selected-frame hmz-messages-frame
             ;;       (spacemacs/enable-transparency hmz-messages-frame 80)
             ;;       (run-with-timer 5 nil
             ;;                       (lambda ()
             ;;                         (spacemacs/enable-transparency hmz-messages-frame 20)
             ;;                         ))))

             (walk-windows (lambda (window)
                             (if (string-equal (buffer-name (window-buffer window)) "*Messages*")
                                 (set-window-point window (point-max))))
                           nil
                           t))))
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

       (message "Garbage Collections During Startup: %s" gcs-done)
       ;; Go back to sane values
       (run-with-idle-timer
        5 nil
        (lambda ()
          (setq gc-cons-threshold 1000000)
          (message "Init took %s secs, GC ran %s times. gc-cons-threshold restored to %S."
                   (emacs-init-time)
                   gcs-done
                   gc-cons-threshold)))

   (face-remap-add-relative 'linum :family "San Francisco" :height 0.6)
   (face-remap-add-relative 'header-line :family "San Francisco" :height 1.0)

   ;; smooth scroll when jumping
   (require 'sublimity)
   (require 'sublimity-scroll)
   (require 'sublimity-attractive)
   (setq sublimity-attractive-centering-width 110)
   (sublimity-mode t)

   ;; keep these configs here once customize loves to screw up
   (set-face-attribute 'linum nil :family "San Francisco" :height 0.6)
   (set-face-attribute 'header-line nil :family "San Francisco" :height 1.0)

   ;; Stylize Echo Area (interestingly it ends up applying other faces styles)
   (with-current-buffer (get-buffer " *Echo Area 0*")   ; the leading space character is correct
     (setq-local face-remapping-alist '((default (:height 0.9) variable-pitch)))) ; etc.

   ;; define hook unless already defined
   (unless (boundp 'after-load-theme-hook)
     (defvar after-load-theme-hook nil
       "Hook run after a color theme is loaded using `load-theme'.")
     (defadvice load-theme (after run-after-load-theme-hook activate)
       "Run `after-load-theme-hook'."
       (run-hooks 'after-load-theme-hook)))

   (defun customize-theme-after-load ()
     (message "THEME: %s" spacemacs--cur-theme)
     (pcase spacemacs--cur-theme
       ('spacemacs-light
        (progn (set-face-attribute 'default nil :background "gray90")))
       ('tango-dark ())
       ('tango ())
       ('dracula (message "Yeah!"))))

   (add-hook 'after-load-theme-hook 'customize-theme-after-load)
   (add-hook 'after-init-hook 'customize-theme-after-load))

;;;;;;;;;;;;;;;
;; Rotate Text
;;;;;;;;;;;;;;;
(setq max-lisp-eval-depth 10000)
(defvar rotate-text-rotations
  '(("true" "false")
    ("width" "height")
    ("if" "unless")
    ("relative" "absolute" "fixed" "static" "sticky")
    ("aliceblue" "antiquewhite" "aqua" "aquamarine" "azure" "beige" "bisque" "black" "blanchedalmond" "blue" "blueviolet" "brown" "burlywood" "cadetblue" "chartreuse" "chocolate" "coral" "cornflowerblue" "cornsilk" "crimson" "cyan" "darkblue" "darkcyan" "darkgoldenrod" "darkgray" "darkgrey" "darkgreen" "darkkhaki" "darkmagenta" "darkolivegreen" "darkorange" "darkorchid" "darkred" "darksalmon" "darkseagreen" "darkslateblue" "darkslategray" "darkslategrey" "darkturquoise" "darkviolet" "deeppink" "deepskyblue" "dimgray" "dimgrey" "dodgerblue" "firebrick" "floralwhite" "forestgreen" "fuchsia" "gainsboro" "ghostwhite" "gold" "goldenrod" "gray" "grey" "green" "greenyellow" "honeydew" "hotpink" "indianred" "indigo" "ivory" "khaki" "lavender" "lavenderblush" "lawngreen" "lemonchiffon" "lightblue" "lightcoral" "lightcyan" "lightgoldenrodyellow" "lightgray" "lightgrey" "lightgreen" "lightpink" "lightsalmon" "lightseagreen" "lightskyblue" "lightslategray" "lightslategrey" "lightsteelblue" "lightyellow" "lime" "limegreen" "linen" "magenta" "maroon" "mediumaquamarine" "mediumblue" "mediumorchid" "mediumpurple" "mediumseagreen" "mediumslateblue" "mediumspringgreen" "mediumturquoise" "mediumvioletred" "midnightblue" "mintcream" "mistyrose" "moccasin" "navajowhite" "navy" "oldlace" "olive" "olivedrab" "orange" "orangered" "orchid" "palegoldenrod" "palegreen" "paleturquoise" "palevioletred" "papayawhip" "peachpuff" "peru" "pink" "plum" "powderblue" "purple" "rebeccapurple" "red" "rosybrown" "royalblue" "saddlebrown" "salmon" "sandybrown" "seagreen" "seashell" "sienna" "silver" "skyblue" "slateblue" "slategray" "slategrey" "snow" "springgreen" "steelblue" "tan" "teal" "thistle" "tomato" "turquoise" "violet" "wheat" "white" "whitesmoke" "yellow" "yellowgreen")
    ("yes" "no"))
  "List of text rotation sets.")

(defun rotate-region (beg end)
  "Rotate all matches in `rotate-text-rotations' between point and mark."
  (interactive "r")
  (let ((regexp (rotate-convert-rotations-to-regexp
     rotate-text-rotations))
  (end-mark (copy-marker end)))
    (save-excursion
      (goto-char beg)
      (while (re-search-forward regexp (marker-position end-mark) t)
  (let* ((found (match-string 0))
         (replace (rotate-next found)))
    (replace-match replace))))))

(defun rotate-string (string &optional rotations)
  "Rotate all matches in STRING using associations in ROTATIONS.
If ROTATIONS are not given it defaults to `rotate-text-rotations'."
  (let ((regexp (rotate-convert-rotations-to-regexp
     (or rotations rotate-text-rotations)))
  (start 0))
    (while (string-match regexp string start)
      (let* ((found (match-string 0 string))
       (replace (rotate-next
           found
           (or rotations rotate-text-rotations))))
  (setq start (+ (match-end 0)
           (- (length replace) (length found))))
  (setq string (replace-match replace nil t string))))
    string))

(defun rotate-next (string &optional rotations)
  "Return the next element after STRING in ROTATIONS."
  (let ((rots (rotate-get-rotations-for
         string
         (or rotations rotate-text-rotations))))
    (if (> (length rots) 1)
  (error (format "Ambiguous rotation for %s" string))
      (if (< (length rots) 1)
    ;; If we get this far, this should not occur:
    (error (format "Unknown rotation for %s" string))
  (let ((occurs-in-rots (member string (car rots))))
    (if (null occurs-in-rots)
        ;; If we get this far, this should *never* occur:
        (error (format "Unknown rotation for %s" string))
    (if (null (cdr occurs-in-rots))
        (caar rots)
      (cadr occurs-in-rots))))))))

(defun rotate-get-rotations-for (string &optional rotations)
  "Return the string rotations for STRING in ROTATIONS."
  (remq nil (mapcar (lambda (rot) (if (member string rot) rot))
        (or rotations rotate-text-rotations))))

(defun rotate-convert-rotations-to-regexp (rotations)
  (regexp-opt (rotate-flatten-list rotations)))

(defun rotate-flatten-list (list-of-lists)
  "Flatten LIST-OF-LISTS to a single list.
Example:
  (rotate-flatten-list '((a b c) (1 ((2 3)))))
    => (a b c 1 2 3)"
  (if (null list-of-lists)
      list-of-lists
    (if (listp list-of-lists)
  (append (rotate-flatten-list (car list-of-lists))
    (rotate-flatten-list (cdr list-of-lists)))
      (list list-of-lists))))

(defun rotate-word-at-point ()
  "Rotate word at point based on sets in `rotate-text-rotations'."
  (interactive)
  (let ((bounds (bounds-of-thing-at-point 'word))
        (opoint (point)))
    (when (consp bounds)
      (let ((beg (car bounds))
            (end (copy-marker (cdr bounds))))
        (rotate-region beg end)
        (goto-char (if (> opoint end) end opoint))))))

(defun indent-or-rotate ()
  "If point is at end of a word, then else indent the line."
  (interactive)
  (if (looking-at "\\>")
      (rotate-region (save-excursion (forward-word -1) (point))
         (point))
    (indent-for-tab-command)))

(defun spacemacs//frame-title-format ()
  "Return frame title with current project name, where applicable."
  (let ((file buffer-file-name))
    (if file
        (concat (file-relative-name (projectile-expand-root file) (projectile-project-root))
                (when (and (bound-and-true-p projectile-mode)
                           (projectile-project-p))
                  (format " [%s]" (projectile-project-name))))
      "%b")))

(when (display-graphic-p)
  (setq frame-title-format '((:eval (spacemacs//frame-title-format)))))

;; function to clear read-only shell buffers
(defun clear-comint-buffer ()
  (interactive)
  (let ((old-max comint-buffer-maximum-size))
    (setq comint-buffer-maximum-size 0)
    (comint-truncate-buffer)
    (setq comint-buffer-maximum-size old-max)
    (goto-char (point-max))))

(add-hook 'comint-mode-hook
          (function (lambda ()
                      (local-set-key (kbd "s-k") 'clear-comint-buffer))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(coffee-tab-width 2 t)
 '(custom-safe-themes
   (quote
    ("19af39a10b8d3cb45beee0b78274965e79e0f70d1c338c1142b2ba1010e026de" "d3a7eea7ebc9a82b42c47e49517f7a1454116487f6907cf2f5c2df4b09b50fc1" "ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "868f73b5cf78e72ca2402e1d48675e49cc9a9619c5544af7bf216515d22b58e7" "6c35ffc17f8288be4c7866deb7437e8af33cd09930e195738cdfef911ab77274" "d8f76414f8f2dcb045a37eb155bfaa2e1d17b6573ed43fb1d18b936febc7bbc2" "7ceb8967b229c1ba102378d3e2c5fef20ec96a41f615b454e0dc0bfa1d326ea6" "5999e12c8070b9090a2a1bbcd02ec28906e150bb2cdce5ace4f965c76cf30476" "67e998c3c23fe24ed0fb92b9de75011b92f35d3e89344157ae0d544d50a63a72" "66132890ee1f884b4f8e901f0c61c5ed078809626a547dbefbb201f900d03fd8" default)))
 '(evil-shift-width 2)
 '(evil-want-Y-yank-to-eol t)
 '(fci-rule-color "#151515" t)
 '(mac-auto-operator-composition-mode t)
 '(neo-autorefresh t)
 '(neo-filepath-sort-function (lambda (f1 f2) (string< (downcase f1) (downcase f2))))
 '(neo-force-change-root t)
 '(neo-show-hidden-files nil)
 '(neo-theme (if (display-graphic-p) (quote icons) (quote arrow)))
 '(neo-vc-integration (quote (char)))
 '(neo-window-position (quote right))
 '(osx-clipboard-mode t)
 '(package-selected-packages
   (quote
    (ember-mode indicators evil-smartparens persistent-scratch command-log-mode sublimity zonokai-theme zenburn-theme zen-and-art-theme underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme tronesque-theme toxi-theme tao-theme tangotango-theme tango-plus-theme tango-2-theme sunny-day-theme sublime-themes subatomic256-theme subatomic-theme spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme seti-theme reverse-theme railscasts-theme purple-haze-theme professional-theme planet-theme phoenix-dark-pink-theme phoenix-dark-mono-theme pastels-on-dark-theme organic-green-theme omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme noctilux-theme niflheim-theme naquadah-theme mustang-theme monokai-theme monochrome-theme molokai-theme moe-theme minimal-theme material-theme majapahit-theme madhat2r-theme lush-theme light-soap-theme jbeans-theme jazz-theme inkpot-theme heroku-theme hemisu-theme hc-zenburn-theme gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme gandalf-theme flatui-theme flatland-theme firebelly-theme farmhouse-theme espresso-theme dracula-theme django-theme darktooth-theme autothemer darkokai-theme darkmine-theme darkburn-theme dakrone-theme cyberpunk-theme color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized clues-theme cherry-blossom-theme busybee-theme bubbleberry-theme birds-of-paradise-plus-theme badwolf-theme apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes afternoon-theme powerline rake inflections pcre2el spinner org-plus-contrib markdown-mode skewer-mode simple-httpd json-snatcher json-reformat multiple-cursors js2-mode hydra parent-mode projectile request haml-mode gitignore-mode fringe-helper git-gutter+ git-gutter flyspell-correct pos-tip flycheck pkg-info epl flx magit magit-popup git-commit with-editor iedit smartparens paredit anzu evil goto-chg undo-tree highlight f diminish web-completion-data s dash-functional tern company inf-ruby bind-map bind-key yasnippet packed dash helm avy helm-core async auto-complete popup esup spaceline-all-the-icons all-the-icons memoize font-lock+ xterm-color ws-butler winum which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package unfill typo toc-org tagedit tabbar spaceline smeargle slim-mode shell-pop scss-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe reveal-in-osx-finder restart-emacs rbenv rainbow-mode rainbow-identifiers rainbow-delimiters pug-mode projectile-rails popwin persp-mode pbcopy paradox osx-trash osx-dictionary orgit org-bullets open-junk-file neotree mwim multi-term move-text mmm-mode minitest markdown-toc magit-gitflow macrostep lua-mode lorem-ipsum livid-mode linum-relative link-hint less-css-mode launchctl json-mode js2-refactor js-doc ir-black-theme info+ indent-guide hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md fuzzy flyspell-correct-helm flycheck-pos-tip flx-ido fill-column-indicator feature-mode fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-commentary evil-cleverparens evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help emmet-mode elisp-slime-nav dumb-jump diff-hl company-web company-tern company-statistics column-enforce-mode color-identifiers-mode coffee-mode clean-aindent-mode chruby bundler auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(powerline-default-separator (quote chamfer))
 '(scroll-bar-mode nil)
 '(sublimity-handle-scroll-criteria
   (quote
    ((eq sublimity--prev-buf
         (current-buffer))
     (eq sublimity--prev-wnd
         (selected-window))
     (or
      (not
       (boundp
        (quote cua--rectangle)))
      (not cua--rectangle))
     (or
      (not
       (boundp
        (quote multiple-cursors-mode)))
      (not multiple-cursors-mode))
     (not
      (eq major-mode
          (quote shell-mode)))
     (not
      (memq this-command
            (quote
             (mac-mwheel-scroll evil-scroll-line-down mwheel-scroll scroll-bar-drag scroll-bar-toolkit-scroll scroll-bar-scroll-up scroll-bar-scroll-down)))))))
 '(sublimity-mode nil)
 '(sublimity-scroll-drift-length 0)
 '(sublimity-scroll-weight 7.0)
 '(window-divider-default-bottom-width 1)
 '(window-divider-default-places t)
 '(window-divider-default-right-width 1))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "nil" :slant normal :weight normal :height 181 :width normal))))
 '(font-lock-warning-face ((t (:background "DeepSkyBlue" :foreground "#ffb86c"))))
 '(fringe ((t (:foreground "DeepSkyBlue" :background unspecified))))
 '(header-line ((t (:weight thin :family "San Francisco"))))
 '(linum ((t (:family "San Francisco" :height 0.6))))
 '(neo-dir-link-face ((t (:foreground "DeepSkyBlue" :family "san francisco"))))
 '(neo-file-link-face ((t (:foreground "White" :family "San Francisco")))))
