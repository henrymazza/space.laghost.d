;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

;; Pre Window Initialization code

;; (require 'iso-transl)

(setq debug-on-error t)

;; it may cause problems with spacemacs own loader
(setq straight-use-package-by-default nil)

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to
   ;; load. If it is the symbol `all' instead
  ;; of a list then all discovered layers will be installed.
  dotspacemacs-configuration-layers
  '(
    better-defaults
    bm
    csv
    dtrt-indent
    elixir
    emacs-lisp
    evil-cleverparens
    evil-collection
    evil-commentary
    evil-magit
    evil-matchit
    git
    github
    hmz-color-identifiers
    hmz-tabbar
    html
    lsp
    lua
    markdown
    neotree
    nginx
    prodigy ;; required (for process definitions below)
    python ;; required
    ruby-on-rails
    shell-scripts
    sql
    syntax-checking
    themes
    tide
    typography
    vinegar
    web-beautify
    yaml

    (ibuffer :variables ibuffer-group-buffers-by 'projects)

    (version-control :variables
      version-control-diff-tool 'git-gutter)

    (auto-completion :variables
                     auto-completion-complete-with-key-sequence "jk"
                     auto-completion-complete-with-key-sequence nil
                     auto-completion-complete-with-key-sequence-delay 0.01
                     auto-completion-enable-snippets-in-popup t
                     auto-completion-enable-sort-by-usage t
                     auto-completion-return-key-behavior 'complete
                     auto-completion-tab-key-behavior 'cycle
                     auto-completion-use-company-box nil
                     spacemacs-default-company-backends '(company-files company-capf))

    ;; Javascript
    react
    (typescript :variables
                typescript-backendd 'tide)

    (javascript :variables
                javascript-import-tool 'import-js
                javascript-lsp-linter nil
                javascript-fmt-tool 'web-beautify
                ;; javascript-fmt-on-save t
                js2-mode-show-strict-warnings nil
                lsp-headerline-breadcrumb-enable nil
                javascript-backend 'lsp)

    (spacemacs-layouts :variables
                       spacemacs-layouts-restrict-spc-tab nil
                       dotspacemacs-auto-resume-layouts t)

    (org :variables
         org-enable-org-journal-support t)

    (ruby :variables
          ruby-version-manager 'rbenv
          ruby-enable-enh-ruby-mode nil)

    (spell-checking :variables
        spell-checking-enable-by-default t)

    (shell :variables
           shell-default-position 'bottom
           shell-default-height 30
           shell-enable-smart-eshell t
           shell-default-shell 'eshell
           shell-default-full-span nil)

    (osx :variables
         osx-command-as 'super))

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
  dotspacemacs-additional-packages
  '(
    fira-code-mode
    bug-hunter
    discover-my-major
    docker-tramp
    dockerfile-mode
    dracula-theme
    fic-mode
    fringe-helper
    ido-completing-read+
    jist
    memory-usage
    ns-auto-titlebar ;; required
    org-bullets
    ox-gfm
    persistent-scratch
    prodigy
    simpleclip ;; required
    sr-speedbar
    sublimity
    unobtrusive-magit-theme)

   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages
   '(
     ws-butler
     git-gutter+
     fancy-battery
     smex
     vi-tilde-fringe
     ivy)

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  (setq epa-pinentry-mode 'loopback)
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; Default theme
   dotspacemacs-default-theme 'doom-dracula
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
   ;; when the current branch is not `de
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
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
        (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'emacs-lisp-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(dracula spacemacs-light tango-dark tango)
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
   dotspacemacs-default-font '(
                               ;; "DejaVu Sans Mono"
                               "Fira Code"
             ;; "Inconsolata"
             ;; "Anonymous Pro Minus"
            :size 14
            :height 120
            :weight normal
            :width normal
            :powerline-scale 1.0)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout t
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts t
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 100
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
   dotspacemacs-use-ido t
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
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
   dotspacemacs-inactive-transparency 85
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling nil
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers '(:disabled-for-modes text-mode)
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters nil
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
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
   dotspacemacs-whitespace-cleanup 'changed

   dotspacemacs-frame-title-format "%I@%S"

   dotspacemacs-show-transient-state-title nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."

  (add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode)) ;; auto-enable for .js/.jsx files
  (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
  (defun web-mode-init-hook ()
    "Hooks for Web mode.  Adjust indent."
    (setq web-mode-markup-indent-offset 4))

  (add-hook 'web-mode-hook  'web-mode-init-hook)

  ;; allow remembering risky variables
  (defun risky-local-variable-p (sym &optional _ignored) nil)


  ;; Command to list ignored files:
  ;; $ git ls-files --others --ignored --exclude-standard --directory
  (defun magit-ignored-files ()
    (magit-git-items "ls-files" "--others" "--ignored" "--exclude-standard" "-z" "--directory"))

  (defun magit-insert-ignored-files ()
    (-when-let (files (magit-ignored-files))
      (magit-insert-section (ignored)
        (magit-insert-heading "Ignored files:")
        (magit-insert-un/tracked-files-1 files nil)
        (insert ?\n))))

  ;; Load Ruby Executer for org-mode
  (with-eval-after-load 'org
    (org-babel-do-load-languages 'org-babel-load-languages '((ruby . t) (js . t)
    (plantuml . t)
    )))

  ;; magit pre-commit config
  (add-hook 'server-switch-hook 'magit-commit-diff)
  (with-eval-after-load 'magit
    (setq magit-git-environment
          (append magit-git-environment
                  (list "OVERCOMMIT_COLOR=0"))))

  ;; magit open in full window
  (setq magit-status-buffer-switch-function 'switch-to-buffer)
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)

  ;; projectile will make slower indexing but use .projectile for ignore
  (setq projectile-use-native-indexing t)
  (setq projectile-enable-caching t)

  (customize-set-variable 'tramp-verbose 10 "Enable remote command traces")
  ;; to speed up tramp
  (setq remote-file-name-inhibit-cache nil)
  (setq vc-ignore-dir-regexp (format "%s\|%s" vc-ignore-dir-regexp tramp-file-name-regexp))

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

  (setq org-todo-keyword-faces
        '(("TODO" . (:foreground "#df6903" :weight bold))
          ("WAIT" . "#654474")
          ("CANCELED" . (:foreground "white" :background "#4d4d4d" :weight bold))
          ("DELEGATED" . "pink")
          ("POSTPONED" . "#008080")))

  ;; my org-mode settings
  (defun hmz-init/org-config ()
    (interactive)
    (ignore-errors
      (drag-stuff-mode 1)
      (spacemacs/toggle-visual-line-navigation-on))

    (setq org-log-done nil)
    (org-indent-mode t)
    (org-bullets-mode 1)
    (setq-local word-wrap nil))

  (add-hook 'org-mode-hook 'hmz-init/org-config)

  ;; echo-area customization
  ;; (with-current-buffer " *Echo Area 0*" (face-remap-add-relative 'default '(:height 180 :weight bold)))

  ;; make frames reusable (one is aware of the other)
  (add-to-list 'display-buffer-alist
               '("." nil (reusable-frames . t)))

  ;; make frames reusable II, the revenge?!
  ;; NOTE: this is the obsolete version (since 24.3)
  (setq display-buffer-reuse-frames t)

  ;; brew install coreutils
  (if (executable-find "gls")
      (progn
        (setq insert-directory-program "gls")
        (setq dired-listing-switches "-lFaGh1v --group-directories-first"))
  (setq dired-listing-switches "-ahlF"))

  ;; change granularity from emacs to the vim behavior
  (setq evil-want-fine-undo 'fine)

  ;; More tasks state options for org-mode
  (setq org-todo-keywords
        '((sequence "TODO:(t)" "WAIT:(w)" "|" "DONE:(d)" "CANCELED:(c)" "DELEGATED:(t)" "POSTPONED:(p)")))

  (setq use-package-always-defer nil)

  ;; straight.el init begins here
  (defvar bootstrap-version)
  (let ((bootstrap-file
   (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
  (bootstrap-version 5))
    (unless (file-exists-p bootstrap-file)
      (with-current-buffer
    (url-retrieve-synchronously
     "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
     'silent 'inhibit-cookies)
  (goto-char (point-max))
  (eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage))

  (straight-use-package 'use-package)

  ;; straight.el init ends here

  ;; https://github.com/mohsenil85/evil-evilified-state.git
  ;; (use-package evil-evilified-state
  ;;   :straight (evil-evilified-state :type git :host github :repo "mohsenil85/evil-evilified-state")
  ;;   :disabled
  ;;   :catch t
  ;;   :demant t)

  ;; UTF-8 I said!
  (add-to-list 'file-coding-system-alist '("\\.el" . utf-8-unix) )
  (prefer-coding-system 'utf-8)
  (set-clipboard-coding-system 'utf-16le)
  ;; (set-clipboard-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-keyboard-coding-system 'utf-8-unix)
  (set-language-environment 'utf-8)
  (set-selection-coding-system 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (setq locale-coding-system 'utf-8)
  (setq utf-translate-cjk-mode nil)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
  ;; MORE copy and paste
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-language-environment 'utf-8)
  (set-selection-coding-system 'utf-8)
  (setq locale-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)

  (defun hmz-init/popwin-config ()
    (interactive)
    (with-current-buffer))

  (remove-hook 'popwin-mode-hook 'hmz-init/popwin-config)

  ;; ;; fix doom-modeline and neotree not starting
  (defun colors//rainbow-identifiers-ignore-keywords ()
    "Do not colorize stuff with ‘font-lock-keyword-face’."
    (setq-local rainbow-identifiers-faces-to-override
    (delq 'font-lock-keyword-face
          rainbow-identifiers-faces-to-override)))

  ;; fix projectile-rails projec ts bugging helm buffers
  (setq projectile-rails-expand-snippet nil)

  ;; try to fix SPC bb bug
  (push '(persp . :never) frameset-filter-alist)

  ;; just auto-fill comments
  (setq comment-auto-fill-only-comments t)

  ;; ruby autocompletion through robe-mode
  ;; (eval-after-load 'company
  ;; '(push 'company-robe company-backends))

  ;; CSV hacks
  (add-hook 'csv-mode-hook
    (lambda ()
      (define-key csv-mode-map (kbd "C-c C-M-a")
        (defun csv-align-visible (&optional arg)
    "Align visible fields"
    (interactive "P")
    (csv-align-fields nil (window-start) (window-end))))))

  (setq csv-separators '("," ";" "    "))

  ;; Kill every buffer not associated with a file
  ;; https://emacs.stackexchange.com/questions/35906/how-can-i-automatically-close-buffers-when-the-underlying-file-is-deleted
  (defun buffer-backed-by-file-p (buffer)
    (let ((backing-file (buffer-file-name buffer)))
      (if (buffer-modified-p buffer)
    t
  (if backing-file
      (file-exists-p (buffer-file-name buffer))
    t))))

  (defun hmz-init/kill-orphan-buffers  ()
    (interactive)
    (mapc 'kill-buffer (-remove 'buffer-backed-by-file-p (buffer-list))))

  ;; avoid for tramp performance
  (global-auto-revert-mode nil)

  ;; projectile don't go well with tramp
  (defadvice projectile-project-root (around ignore-remote first activate)
    (unless (file-remote-p default-directory) ad-do-it))

  ;; turn off magic comments for any ruby mode
  (setq enh-ruby-add-encoding-comment-on-save nil)
  (setq ruby-insert-encoding-magic-comment nil)

  ;; try to fix "unrecognized entry undo list ..."
  ;; seems promising
  (setq undo-tree-enable-undo-in-region nil)

  (setq initial-buffer-choice t)

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

  (setq-default auto-fill-function 'do-auto-fill)

  ;; magit
  (setq;;-default
   magit-diff-refine-hunk 'all
   magit-diff-adjust-tab-width t
   magit-diff-paint-whitespace 'all
   magit-diff-highlight-trailing 'all
   ;; BUG magit can't commit if the following var is t
   magit-diff-highlight-indentation nil)

  ;; UTF-8 snippet from msteringemacs.org -- don't know how useful
  ;; it is.
  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  ;; backwards compatibility as default-buffer-file-coding-system
  ;; is deprecated in 23.2.
  (if (boundp 'buffer-file-coding-system)
      (setq-default buffer-file-coding-system 'utf-8)
    (setq default-buffer-file-coding-system 'utf-8))

  ;; Treat clipboard input as UTF-8 string first; compound text next, etc.
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

  ;; macro to comment things
  (defmacro comment (&rest body)
    "Comment out one or more s-expressions."
    nil)

  ;; put save file on my own .spacemacs.d dir
  (setq persistent-scratch-save-file "~/.spacemacs.d/.persistent-scratch")

  ;; Don't replace copied text with killed region
  (setq save-interprogram-paste-before-kill t)

  ;; avoid slowness
  (setq inhibit-compacting-font-caches t)

  ;; show garbage collection
  (setq garbage-collection-messages nil)

  ;; Hide title bar
  ;; (setq initial-frame-alist '((undecorated . t)))
  ;; (add-to-list 'default-frame-alist '(undecorated . t))

  ;; perhaps it reduces errors with undo-tree
  (setq undo-tree-enable-undo-in-region nil)

  ;; keep undo tree across restarts
  (setq undo-tree-auto-save-history nil)

  ;; keep undo tree files in proper place
  (setq undo-tree-history-directory-alist '(("." . "~/.spacemacs.d/undo")))

  ;; disable smooth scroll on railwaycat's emacs fork
  (setq mac-mouse-wheel-smooth-scroll nil)


)

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loa,
you should place you code here."

  ;; expect bugs with this as auto-completion layer has some incompatibilities
  ;; NOTE: the mode itself should call it
  ;; (global-company-mode)

  ;; fix tabs in dired
  (add-hook 'dired-mode-hook (lambda () (setq tab-width 2)))

  ;; trying to stop newline at end of file madness
  (setq mode-require-final-newline t)

  ;; org-mode grap-link shortcut
  (add-hook 'org-mode-hook
            (lambda () (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link)))

  (setq org-use-property-inheritance t)

  ;; disable centaur and similar in ispell choices
  (add-hook 'ispell-update-post-hook
            (lambda ()
              (with-current-buffer ispell-choices-buffer
                (setq header-line-format nil))))

  ;; dockerfile-mode config
  (put 'dockerfile-image-name 'safe-local-variable #'stringp)

  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

  ;; manualy fix python indentation
  (setq python-indent-guess-indent-offset nil)
  (setq python-indent-offset 4)

  ;; C-o for add heading above in org-mode
  ;; TODO: move it to a layer/file about org-mode
  (defun org-insert-heading-above ()
    (interactive)
    (move-beginning-of-line nil)
    (org-insert-heading))

  (add-hook 'org-mode-hook
            (lambda ()
              (define-key org-mode-map (kbd "C-o") 'org-insert-heading-above)))

  ;; fix for broken HELM on spacemacs
  (with-eval-after-load 'helm
    (setq helm-display-function 'helm-default-display-buffer))

  ;; from https://emacs.stackexchange.com/questions/3900/command-to-visit-github-pull-request-of-current-branch-with-magit
  (defun endless/visit-pull-request-url ()
    "Visit the current branch's PR on Github."
    (interactive)
    (browse-url (format "https://github.com/%s/pull/new/%s"
                        (replace-regexp-in-string
                         "\\`.+github\\.com:\\(.+\\)\\.git\\'" "\\1"
                         (magit-get "remote" (magit-get-push-remote) "url"))
                        (magit-get-current-branch))))


  ;; change rspec compilation faces
  ;; (setq rspec-compilation-mode-hook nil)
  (add-hook 'rspec-compilation-mode-hook
            #'(lambda ()
                (with-current-buffer "*rspec-compilation*"
                  (face-remap-add-relative 'default
                                           '(:family "crystal" :background "gray10")))
                ))

  (setq display-buffer-reuse-frames t)
  (windmove-default-keybindings)

  ;; (hmz-pos/posprocess)
  (defun hmz-pos/posprocess ()
    (setq hmz-pos/name "*hmz-rspec-compilation*")
    (start-process "hmz-rspec"
                   hmz-pos/name
                   "/usr/local/opt/coreutils/libexec/gnubin/sleep" "10")

    (defun hmz-rspec-sentinel (process event)
      (princ (format "Process: %s had the event '%s'" process event))
      (run-with-timer 5 nil (lambda ()
                              (posframe-delete hmz-pos/name))))

    (set-process-sentinel (get-process "hmz-rspec") 'hmz-rspec-sentinel)

    (posframe-show "*Messages*" ;;hmz-pos/name
                   :internal-border-width 5
                   :width 350
                   :height 800
                   :position (cons -10 -10)
                   :font-height 100
                   :internal-border-color "gray70")

    (with-current-buffer hmz-pos/name
      (spacemacs/enable-transparency hmz-messages-frame 50))
    (posframe-delete-all))

  ;; prettify symbols for org-mode
  (defun hmz-init/org-mode-prettify-symbols ()
    "Beautify Org Checkbox Symbol"
    (interactive)
    (push '("[ ]" . "☐") prettify-symbols-alist)
    (push '("[X]" . "☑" ) prettify-symbols-alist)
    (push '("[-]" . "❍" ) prettify-symbols-alist)
    (prettify-symbols-mode 1))

  (add-hook 'org-mode-hook 'hmz-init/org-mode-prettify-symbols)

  ;; config C-o as yasnippet expansion and defaults to open line if everything
  ;; fails
  (global-set-key "\C-o" 'aya-open-line)

  (defun aya-open-line ()
    "Call `open-line', unless there are abbrevs or snippets at point.
In that case expand them.  If there's a snippet expansion in progress,
move to the next field. Call `open-line' if nothing else applies."
    (interactive)
    (cond ((expand-abbrev))

          ((yas--snippets-at-point)
           (yas-next-field-or-maybe-expand))

          ((ignore-errors
             (yas-expand)))

          (t
           (open-line 1))))


  ;; (defun flyspell-ignore-http-and-https ()
  ;;   "Function used for `flyspell-generic-check-word-predicate' to ignore stuff starting with \"http\" or \"https\"."
  ;;   (save-excursion
  ;;     (forward-whitespace -1)
  ;;     (when (looking-at " ")
  ;;       (forward-char)
  ;;       (not (looking-at "https?\\b")))))
  ;; sadly, Emacs does not handle all scroll events on OSX. Hence, inertia

  ;; Mouse Scrolling Config
  ;;   scrolling does not work properly. This is the closest approximation I could
  ;;   come up with.
  (setq mouse-wheel-progressive-speed nil)
  (setq redisplay-dont-pause t)
  (defun up-single () (interactive) (scroll-up 1))
  (defun down-single () (interactive) (scroll-down 1))
  (defun up-double () (interactive) (scroll-up 2))
  (defun down-double () (interactive) (scroll-down 2))
  (defun up-triple () (interactive) (scroll-up 5))
  (defun down-triple () (interactive) (scroll-down 5))

  (global-set-key [wheel-down] 'up-single)
  (global-set-key [wheel-up] 'down-single)
  (global-set-key [double-wheel-down] 'up-double)
  (global-set-key [double-wheel-up] 'down-double)
  (global-set-key [triple-wheel-down] 'up-triple)
  (global-set-key [triple-wheel-up] 'down-triple)

  (setq mouse-wheel-scroll-amount '(1 ((shift) . 4) ((meta) . 8)))

  ;; (put 'text-mode 'flyspell-mode-predicate 'flyspell-ignore-http-and-https)

  (require 'window-purpose)

  (defun hmz-prog-mode-hook ()
    (interactive)

    ;; projectile will make slower indexing but use .projectile for ignore
    (setq projectile-use-native-indexing t)
    (setq projectile-enable-caching t)

    (setq require-final-newline t)

    ;; recognize camelized words, underline, as word boundary
    (subword-mode 1)

    (which-function-mode 0)

    (face-remap-add-relative 'default '(:height 140))

    (linum-mode -1)
    (auto-fill-mode 1)

    (flyspell-mode t)
    (flyspell-prog-mode)

    (display-line-numbers-mode t)

    ;; FIXME: make me work
    ;; BUG: it's not activating when prog-mode fires
    ;; TODO: fix all that garbage
    ;; highlights FIXME, TODO, etc
    (if (featurep 'fic-mode)
        (fic-mode t))

    (flycheck-mode 1)

    (smartparens-global-mode t)
    (global-evil-matchit-mode 1)

    (visual-line-mode t))

  (add-hook 'prog-mode-hook 'hmz-prog-mode-hook)
  (add-hook 'text-mode-hook 'hmz-prog-mode-hook)

  ;; try to fix a new bug (infinite recursion?)

  ;; disable vc in tramp dirs (too radical!)
  ;; (setq vc-ignore-dir-regexp
  ;;       (format "\\(%s\\)\\|\\(%s\\)"
  ;;               vc-ignore-dir-regexp
  ;;               tramp-file-name-regexp))

  (global-auto-highlight-symbol-mode 1)


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
  ;; auto refresh
  (add-hook 'ibuffer-mode-hook (lambda () (ibuffer-auto-mode 1)))

  (defun hmz-init/before-save (save-fun &rest args)
    (set-buffer-modified-p t)
    (message "Saving... %s" buffer-file-name)
    (if (file-exists-p (buffer-file-name))
        (progn
          (set-buffer-modified-p t)
          (apply save-fun args))
      (if (y-or-n-p (concat "Buffer " (buffer-name) " has no file on disk! Create it?"))
          (apply save-fun args))))


  (advice-add 'save-buffer :around #'hmz-init/before-save)

  ;; Monkey Patch (or use functional magic) to show only first name of the
  ;; author in magit-log, as well abbrev. date.
  (use-package magit-log
    :init
    (progn
      ;; (setq magit-log-margin '(t age magit-log-margin-width t 18)) ;Default value
      (setq magit-log-margin '(t age-abbreviated magit-log-margin-width :author 11)))
    :config
    (progn
      ;; Abbreviate author name. I added this so that I can view Magit log without
      ;; too much commit message truncation even on narrow screens (like on phone).
      (defun modi/magit-log--abbreviate-author (&rest args)
        "The first arg is AUTHOR, abbreviate it.
      First Last  -> F Last
      First.Last  -> F Last
      Last, First -> F Last
      First       -> First (no change).

      It is assumed that the author has only one or two names."
        ;; ARGS               -> '((REV AUTHOR DATE))
        ;; (car ARGS)         -> '(REV AUTHOR DATE)
        ;; (nth 1 (car ARGS)) -> AUTHOR
        (let* ((author (nth 1 (car args)))
               (author-abbr (if (string-match-p "," author)
                                ;; Last, First -> F Last
                                (replace-regexp-in-string "\\(.*?\\), *\\(.*\\)" "\\1" author)
                              ;; First Last -> F Last
                              (replace-regexp-in-string "\\(.*\\)[. ]+\\(.*\\)" "\\1" author))))
          (setf (nth 1 (car args)) author-abbr))
        (car args))                       ;'(REV AUTHOR-ABBR DATE)
      (advice-add 'magit-log-format-margin :filter-args #'modi/magit-log--abbreviate-author)))

  ;; linum-mode is the old ways
  (global-linum-mode -1)

  ;; hilight current line
  (global-hl-line-mode 1)

  ;; this is better than fancy-battery
  (display-battery-mode nil)

  ;; cycle throgh frames (macOS's windows)
  ;; * in insert mode it reads command +
  (global-set-key (kbd "s-`") 'next-multiframe-window)
  (global-set-key (kbd "s-1") 'next-multiframe-window)

  ;; Initialize title bar appearence manager
  (use-package ns-auto-titlebar
    :if (memq window-system '(mac ns))
    :config
    (ns-auto-titlebar-mode))

  ;; TODO IT DOESN'T WORK!!!
  ;; disable mode-line in helm
  (setq helm-display-header-line nil)
  (setq helm-mode-line-string nil)
  (redraw-display)

  ;; avoid leaving stall branch information by VC
  (setq auto-revert-check-vc-info nil)

  (defun prodigy-strip-ctrl-m (output)
    "Strip  line endings from OUTPUT."
    (s-replace "" "" output)
    (s-replace "" "\n" output)

    )

  (prodigy-define-service
    :name "Vavato's Spring Server"
    :command "spring"
    :args '("server" "start" "SKIP_COV=true")
    :env '(("SKIP_COV" "true"))
    :cwd "/Users/HMz/Development/Vavato/vavato-backend/"
    :tags '(vavato work)
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop t)

  (prodigy-define-service
    :name "Vavato's Guard Backend"
    :command "guard"
    :args '("-f" "doc" "SKIP_COV=true")
    :cwd "/Users/HMz/Development/Vavato/vavato-backend/"
    :tags '(vavato work)
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop t)

  (prodigy-define-service
    :name "Vavato's Rails Backend"
    :command "rails"
    :args '("s")
    :cwd "/Users/HMz/Development/Vavato/vavato-backend/"
    :tags '(vavato work)
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop t)

  (prodigy-define-service
    :name "Vavato's Angular Fronted"
    :command "npm"
    :args '("start")
    :cwd "/Users/HMz/Development/Vavato/vavato-frontend/"
    :tags '(vavato work)
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop t)

  (prodigy-define-service
    :name "Uni Webserver"
    :command "/Users/HMz/Development/uni/bin/rails"
    :args '("s")
    :cwd "/Users/HMz/Development/uni/"
    :url "localhost"
    :port 3000
    :tags '(work)
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop t)

  (prodigy-define-service
    :name "Uni Chef Recipe on Weberver"
    :command "ssh"
    :args '("sampa3.officina.me"
            "-t"
            "sudo"
            "chef-client"
            "-o"
            "\"recipe[uni]\"")
    :cwd "/Users/HMz/Development/uni/"
    :tags '(work)
    :kill-process-buffer-on-stop t)

  ;; (prodigy-define-service
  ;;   :name "Uni Frontend Build Server"
  ;;   :command "ember"
  ;;   :args '("serve")
  ;;   :cwd "/Users/HMz/Development/uni-fe/"
  ;;   :url "localhost"
  ;;   :port 4200
  ;;   :tags '(work)
  ;;   :stop-signal 'sigkill
  ;;   :kill-process-buffer-on-stop t)

  ;; (prodigy-define-service
  ;;   :name "Uni Test Server"
  ;;   :command "ember"
  ;;   :args '("test" "--serve" "--watcher" "node")
  ;;   :cwd "/Users/HMz/Development/uni-fe/"
  ;;   :tags '(work)
  ;;   :stop-signal 'sigkill
  ;;   :kill-process-buffer-on-stop t)

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

  ;; enable transparency for each new frame
  (add-hook 'after-make-frame-functions 'spacemacs/enable-transparency)
  (spacemacs/enable-transparency)

  ;; highlight indent
  ;; (setq highlight-indent-guides-method 'character)
  ;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

  ;; separate system clipboard from kill ring
  (simpleclip-mode 1)

  ;; for use mainly with eshell
  (defalias 'ff 'find-file)
  (defalias 'ffo 'find-file-other-window)

  ;; disable sublimity mode in magit-log buffers
  (add-hook 'magit-log-mode-hook
            (lambda ()
              (sublimity-mode -1)))

  ;; increase term buffer size
  (add-hook 'term-mode-hook
            (lambda ()
              (setq term-buffer-maximum-size 10000)))

  ;; map control-r to helm search history
  (add-hook 'eshell-mode-hook
            (lambda ()
              (local-set-key (kbd "C-r") 'helm-eshell-history)))

  ;; Emacs Lisp handies
  (spacemacs/set-leader-keys-for-major-mode 'emacs-lisp-mode "e p" 'eval-print-last-sexp)

  ;; keep scratch buffer throughout restarts
  ;; (persistent-scratch-setup-default)

  ;; Blink cursor so I know where I am!
  (blink-cursor-mode 1)

  ;; Make insert cursor a vertical Bar. Keep default color.
  (setq evil-emacs-state-cursor '("SkyBlue2" bar))

  ;; really! disabel it!
  (if (window-system)
      (scroll-bar-mode -1))

  ;; space in between lines
  (setq-default line-spacing 2)

  ;; More space to breath
  (setq line-spacing 5)

  (add-hook 'sgml-mode-hook 'zencoding-mode)
  (add-hook 'web-mode-hook (lambda ()
                             (zencoding-mode)
                             (snippet-mode 0)
                             (rainbow-identifiers t)))

  ;; Clear unused buffers
  (midnight-mode t)
  (add-to-list 'clean-buffer-list-kill-never-regexps ".*NeoTree.*")

  ;; Eval and Print ERROR: not working so far
  (evil-define-key 'nomal emacs-lisp-mode-map (kbd "e p") 'eval-print-last-sexp)
  (evil-define-key 'visual emacs-lisp-mode-map (kbd "e p") 'eval-print-last-sexp)

  ;; Find a better char for truncated lines
  (set-display-table-slot standard-display-table 0 ?\ )

  ;; Multiple Cursors
  (global-set-key (kbd "C-c m c") 'mc/edit-lines)

  ;; Find String in Project
  (global-set-key (kbd "s-F") 'helm-projectile-ag)

;;;###autoload
  (defun projectile-save-project-buffers ()
    "Save all project buffers."
    (interactive)
    (dolist (buf (projectile-project-buffers))
      (with-current-buffer buf
        (when (and buffer-file-name (buffer-modified-p))
          (save-buffer)))))

  ;; Salve all Projectile buffers
  (global-set-key (kbd "s-S") 'projectile-save-project-buffers)
  (spacemacs/set-leader-keys "p s" 'projectile-save-project-buffers)

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

  (define-key evil-normal-state-map (kbd "C-h") 'help-command)
  (define-key evil-normal-state-map (kbd "C-a") 'rotate-word-at-point)

  ;; Treat wrapped line scrolling as single lines
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

  ;; command-`
  ;; (global-set-key (kbd "s-`") 'next-multiframe-window)

  ;; command-t
  (global-set-key (kbd "s-t") 'helm-projectile-find-file)
  (global-set-key (kbd "H-t") 'helm-projectile-find-file)

  ;; open files with command + o
  (global-set-key (kbd "s-o") 'find-file)
  (global-set-key (kbd "H-o") 'find-file)

  ;; kill buffers: c-k didn't work right
  (global-set-key (kbd "s-k") 'kill-this-buffer)
  (global-set-key (kbd "H-k") 'kill-this-buffer)

  ;; spacemacs as default git editor
  (global-git-commit-mode t)

  ;; (global-git-gutter+-mode nil)
  ;; (git-gutter-mode -1)

  (defun hmz-markdown-mode-hook ()
    "My customizations for markdown-mode."
    (interactive)

    ;;narrower columns
    (make-variable-buffer-local 'sublimity-attractive-centering-width)
    (setq sublimity-attractive-centering-width 60)

    ;; variable width font in markdown-mode
    (variable-pitch-mode t)

    ;; essential
    (visual-line-mode t))

  (add-hook 'markdown-mode-hook 'hmz-markdown-mode-hook)

  ;; flycheck is ugly
  (global-flycheck-mode -1)

  ;;(global-company-mode t)

  ;; Unix Style C-h
  (global-set-key (kbd "C-?") 'help-command) ;; this isn't working...
  (global-set-key (kbd "M-?") 'mark-paragraph)
  (global-set-key (kbd "C-h") 'delete-backward-char)
  (global-set-key (kbd "M-h") 'backward-kill-word)
  ;; (global-set-key (kbd "C-g") 'evil-force-normal-state)

  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2)
  (setq-default c-basic-offset 2)
  (setq indent-line-function 'insert-tab)

  (defun hmz-dotfile/setup-indent (&optional n)
    (interactive
     (unless n (setq n 2))
     (setq web-mode-markup-indent-offset n)
     ;; java/c/c++
     (setq c-basic-offset n)
     ;; web development
     (setq coffee-tab-width n) ; coffeescript
     (setq javascript-indent-level n) ; javascript-mode
     (setq js-indent-level n) ; js-mode
     (setq js2-basic-offset n) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
     (setq-default indent-tabs-mode nil)
     (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
     (setq html-mode-markup-indent-offset n) ; web-mode, html tag in html file
     (setq web-mode-css-indent-offset n) ; web-mode, css in html file
     (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
     (setq css-indent-offset n))) ; css-mode

  (hmz-dotfile/setup-indent 2)

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

  (defun bsl/filter-buffers (buffer-list)
    (delq nil (mapcar
               (lambda (buffer)
                 (cond
                  ((eq (with-current-buffer buffer major-mode)  'dired-mode) nil)
                  ((eq (with-current-buffer buffer major-mode)  'org-mode) nil)
                  ((eq (with-current-buffer buffer major-mode)  'org-agenda-mode) nil)
                  (t buffer)))
               buffer-list)))

  (advice-add 'helm-skip-boring-buffers :filter-return 'bsl/filter-buffers)

  (setq-default create-lockfiles nil)

  (defun my-esc (prompt)
    "Functionality for escaping generally. Includes exiting Evil
     insert state and C-g binding. "
    (cond
     ((or (evil-insert-state-p)
          ;; (evil-normal-state-p)
          (evil-replace-state-p)
          (evil-visual-state-p)) [escape])))
  (define-key key-translation-map (kbd "C-g") 'my-esc)
  ;; (define-key key-translation-map (kbd "C-c") 'my-esc)

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

  (add-hook 'minibuffer-setup-hook 'hmz-init/minibuffer-setup)
  (defun hmz-init/minibuffer-setup ()
    (setq evil-emacs-state-cursor '("SkyBlue2" bar))
       (set (make-local-variable 'face-remapping-alist)
          '((default :height 1.5))))

  ;; Always follow symlinks
  (setq vc-follow-symlinks t)

   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Messages Customs
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq hmz-messages-frame nil)

  (defun hmz-hide-mini-monitor ()
    (interactive)
    (setq hmz-neotree-hidden t)
    (if (and hmz-messages-frame (frame-live-p hmz-messages-frame))
        (delete-frame hmz-messages-frame)))

  (add-hook 'kill-emacs-hook 'hmz-hide-mini-monitor)

  (defun hmz-make-mini-monitor ()
    (interactive)
    ;; global
    (if (and hmz-messages-frame (frame-live-p hmz-messages-frame))
        (delete-frame hmz-messages-frame)

      (let ((original-frame (selected-frame)))
        (setq hmz-messages-frame
              (make-frame
               '((visibility . t)
                 (name . "Monitor")
                 (vertical-scroll-bars . t)


                 (minibuffer . t)
                 (height . 22) (width . 120)
                 (top . 1000) (left . 0)
                 (unsplittable . t))))

        (with-selected-window (frame-selected-window hmz-messages-frame)
          ;;TODO: (handle-switch-frame)
          (switch-to-buffer "*Messages*" nil t)
          (hidden-mode-line-mode t)    ;
          (spacemacs/enable-transparency hmz-messages-frame 90)
          (setq dotspacemacs-inactive-transparency 70)
          (if (featurep 'tabbar)
              (tabbar-local-mode 0))
          (set-background-color "black")
          (set-foreground-color "medium spring green")

          (setq mode-line-format nil)

          (setq buffer-face-mode-face `(:background "#333333"))
          (buffer-face-mode 1)
          (text-scale-set -1)
          (set-frame-parameter hmz-messages-frame 'unsplittable t)
          (set-window-dedicated-p (selected-window) t)

          (spacemacs/toggle-maximize-buffer)

          (setq-local header-line-format nil) ;; disables tabbar completly for that window
          (setq left-fringe-width 0)
          (setq right-fringe-width 0)
          (set-window-fringes (selected-window) 0 0 nil))
        ;; (message "%s" original-frame)
        ;; (select-frame-set-input-focus original-frame)

        ;; (setq hmz-neotree-hidden nil)
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
  ;; should be handled by gcmh from now on
  ;; Go back to sane values
  ;; (run-with-idle-timer
  ;;  15 nil
  ;;  (lambda ()
  ;;    (setq gc-cons-threshold 1000000)
  ;;    (message "Init took %s secs, GC ran %s times. gc-cons-threshold restored to %S."
  ;;             (init-time)
  ;;             gcs-done
  ;;             gc-cons-threshold)))

  ;; (face-remap-add-relative 'header-line :family "San Francisco" :height 1.0)

  ;; keep these configs here once customize loves to screw up
  (set-face-attribute 'header-line nil :family "San Francisco" :height 1.0)

  ;; Stylize Echo Area (interestingly it ends up applying other faces styles)
  (with-current-buffer (get-buffer " *Echo Area 0*")   ; the leading space character is correct
    (setq-local face-remapping-alist
                '((default (:height 1.3 :foreground "#CCC") variable-pitch)))) ; etc.

  (defun add-margin-to-mb ()
   (setq minibuffer-temporary-goal-position (* 2 (frame-width))))
  (add-hook 'minibuffer-setup-hook 'add-margin-to-mb)

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
  (add-hook 'after-init-hook 'customize-theme-after-load)

  ;; ) ;; end user-config

  (message "> MID1 user config")
;;;;;;;;;;;;;;;
  ;; Rotate Text
;;;;;;;;;;;;;;;
  (setq max-lisp-eval-depth 10000)
  (setq rotate-text-rotations
        '(("true" "false")
          ("width" "height")
          ("enable" "disable")
          ("add-hook" "remove-hook")
          ("enabled" "disabled")
          ("describe" "context")
          ("create" "build")
          ("t" "nil")
          ("it" "skip")
          ("if" "unless")
          ("top" "bottom")
          ("left" "right")
          ("0" "1" "2" "3" "4" "5" "6" "7" "8" "9")
          ("relative" "absolute" "fixed" "static" "sticky")
          ("yes" "no"))
        )

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

  (defun hmz-init/frame-title-format ()
    "Return frame title with current project name, where applicable."
    (let ((file buffer-file-name))
      (if (and file (projectile-project-p))
          (concat ;;(file-relative-name (projectile-expand-root file) (projectile-project-root))
           (when (and (bound-and-true-p projectile-mode)
                      (projectile-project-p))
             (format "[%s]" (projectile-project-name))
             ))
        "%b")))

  (setq frame-title-format '((:eval (hmz-init/frame-title-format))))

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

  (define-key global-map (kbd "C-0") 'iterm-here)

  (defun iterm-here ()
    (interactive)
    (dired-smart-shell-command "open -a iTerm $PWD" nil nil))

  ;; (require 'hmz-modules (concat (expand-file-name user-emacs-directory) "../.spacemacs.d/hmz-modules.el"))

  (ido-mode 1)
) ;; end user-config

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ahs-default-range 'ahs-range-whole-buffer)
 '(ahs-idle-interval 1.0)
 '(alert-default-style 'notifier)
 '(ansi-color-names-vector
   ["dim gray" "orange red" "medium spring green" "gold" "dodger blue" "purple" "turquoise1" "#eeeeec"])
 '(auto-revert-buffer-list-filter 'magit-auto-revert-buffer-p)
 '(auto-revert-verbose t)
 '(before-save-hook
   '(time-stamp whitespace-cleanup spacemacs//python-sort-imports))
 '(centaur-tabs-backward-tab-text " ⤶ ")
 '(centaur-tabs-close-button " × ")
 '(centaur-tabs-forward-tab-text " ⤷ ")
 '(centaur-tabs-modified-marker "⦿")
 '(centaur-tabs-set-close-button t)
 '(coffee-tab-width 2)
 '(csv-separators '("," ";") t)
 '(custom-safe-themes
   '("76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "2dff5f0b44a9e6c8644b2159414af72261e38686072e063aa66ee98a2faecf0e" "7451f243a18b4b37cabfec57facc01bd1fe28b00e101e488c61e1eed913d9db9" "e6ff132edb1bfa0645e2ba032c44ce94a3bd3c15e3929cdf6c049802cf059a2a" "eb5c79b2e9a91b0a47b733a110d10774376a949d20b88c31700e9858f0f59da7" "a41b81af6336bd822137d4341f7e16495a49b06c180d6a6417bf9fd1001b6d2b" "57bd93e7dc5fbb5d8d27697185b753f8563fe0db5db245592bab55a8680fdd8c" "890a1a44aff08a726439b03c69ff210fe929f0eff846ccb85f78ee0e27c7b2ea" "819ab08867ef1adcf10b594c2870c0074caf6a96d0b0d40124b730ff436a7496" default))
 '(default-justification 'left)
 '(desktop-minor-mode-table
   '((defining-kbd-macro nil)
     (isearch-mode nil)
     (vc-mode nil)
     (vc-dired-mode nil)
     (erc-track-minor-mode nil)
     (company-posframe-mode nil)))
 '(diff-font-lock-prettify t)
 '(dired-hide-details-hide-information-lines nil)
 '(dired-k-human-readable t)
 '(dired-k-padding 1)
 '(dired-listing-switches "-al" nil nil "Customized with use-package dired")
 '(dired-recursive-copies 'always)
 '(dired-recursive-deletes 'top)
 '(display-buffer-alist '(("." nil (reusable-frames . t))))
 '(doom-modeline-buffer-encoding nil)
 '(doom-modeline-height 15)
 '(doom-modeline-indent-info nil)
 '(doom-modeline-mode t)
 '(ember-completion-system 'helm)
 '(ember-serve-command "ember serve  --output-path dist")
 '(ember-test-command "ember test --serve")
 '(epg-pinentry-mode nil)
 '(evil-want-Y-yank-to-eol t)
 '(exec-path-from-shell-arguments '("-l" "-i"))
 '(exec-path-from-shell-check-startup-files t t)
 '(exec-path-from-shell-debug nil t)
 '(exec-path-from-shell-variables '("PATH" "MANPATH" "TMPDIR" "GOPATH" "KUBECONFIG"))
 '(fci-rule-color "#6272a4")
 '(fic-highlighted-words '("FIXME" "TODO" "BUG" "HACK" "XXX" "OPTIMIZE" "NOTE"))
 '(fill-column 100)
 '(gist-ask-for-filename nil)
 '(gist-view-gist nil)
 '(git-gutter-fr:side 'left-fringe)
 '(global-auto-highlight-symbol-mode t)
 '(global-prettify-symbols-mode t)
 '(global-visual-line-mode t)
 '(helm-boring-buffer-regexp-list
   '("\\` " "\\`\\*helm" "\\`\\*Echo Area" "\\`\\*Minibuf" "magit-.*: .*" "\\*" "magit: .*"))
 '(helm-completion-style 'emacs)
 '(helm-mode-fuzzy-match t)
 '(highlight-indent-guides-character 183)
 '(highlight-indent-guides-method 'character)
 '(highlight-indent-guides-mode nil t)
 '(highlight-indentation-offset 4)
 '(ibuffer-default-sorting-mode 'recency)
 '(ibuffer-formats
   '((mark modified read-only locked " "
           (name 30 30 :left :elide)
           " "
           (size 9 -1 :right)
           " "
           (mode 16 16 :left :elide)
           " " filename-and-process)
     (mark " "
           (name 16 -1)
           " " filename)))
 '(ibuffer-sidebar-width 22)
 '(indicate-buffer-boundaries '((t) (top . left) (bottom . left)))
 '(inhibit-eol-conversion t)
 '(ispell-highlight-face 'flyspell-incorrect)
 '(jdee-db-active-breakpoint-face-colors (cons "#1E2029" "#bd93f9"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1E2029" "#50fa7b"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1E2029" "#565761"))
 '(line-spacing 3)
 '(magit-diff-highlight-trailing 'all)
 '(magit-status-margin '(t age-abbreviated magit-log-margin-width t 11))
 '(magit-status-sections-hook
   '(magit-insert-status-headers magit-insert-merge-log magit-insert-rebase-sequence magit-insert-am-sequence magit-insert-sequencer-sequence magit-insert-bisect-output magit-insert-bisect-rest magit-insert-bisect-log magit-insert-ignored-files magit-insert-untracked-files magit-insert-unstaged-changes magit-insert-staged-changes magit-insert-stashes magit-insert-unpushed-to-pushremote magit-insert-unpushed-to-upstream-or-recent magit-insert-unpulled-from-pushremote magit-insert-unpulled-from-upstream))
 '(markdown-hide-urls t)
 '(markdown-italic-underscore t)
 '(message-sent-hook '((lambda nil (message (buffer-name)))))
 '(midnight-mode t)
 '(mode-line-in-non-selected-windows t)
 '(neo-hide-cursor t)
 '(neo-theme 'arrow)
 '(neo-vc-integration '(face char) t)
 '(neo-vc-state-char-alist
   '((up-to-date . 32)
     (edited . 10041)
     (added . 10029)
     (removed . 10006)
     (missing . 33)
     (needs-merge . 77)
     (conflict . 9552)
     (unlocked-changes . 33)
     (needs-update . 85)
     (ignored . 32)
     (user . 85)
     (unregistered . 32)
     (nil . 8942)))
 '(neo-window-position 'right)
 '(neo-window-width 40 t)
 '(nil nil t)
 '(objed-cursor-color "#ff5555")
 '(org-agenda-files
   '("~/Documents/org/TODOs.org" "~/Development/GoDaddy/sellbrite/TODOs.org" "/Users/HMz/Development/GoDaddy/nemo/TODOs.org"))
 '(org-blank-before-new-entry '((heading) (plain-list-item)))
 '(org-bullets-bullet-list '("◉" "○" "●" "☞"))
 '(org-directory "~/Documents/org")
 '(org-ellipsis " ▼")
 '(org-export-backends '(ascii html icalendar latex md odt))
 '(org-export-with-section-numbers 2)
 '(org-fontify-done-headline nil)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-log-done nil)
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-eww ol-gnus org-habit ol-info ol-irc ol-mhe ol-rmail ol-w3m org-mac-link))
 '(org-todo-keywords
   '((sequence "TODO:(t)" "WAIT:(w)" "|" "DONE:(d)" "CANCELED:(c)")))
 '(origami-parser-alist
   '((ruby-mode origami-markers-parser "do" "end")
     (java-mode . origami-java-parser)
     (c-mode . origami-c-parser)
     (c++-mode . origami-c-style-parser)
     (perl-mode . origami-c-style-parser)
     (cperl-mode . origami-c-style-parser)
     (js-mode . origami-c-style-parser)
     (js2-mode . origami-c-style-parser)
     (js3-mode . origami-c-style-parser)
     (go-mode . origami-c-style-parser)
     (php-mode . origami-c-style-parser)
     (python-mode . origami-python-parser)
     (emacs-lisp-mode . origami-elisp-parser)
     (lisp-interaction-mode . origami-elisp-parser)
     (clojure-mode . origami-clj-parser)))
 '(package-selected-packages
   '(google-this modern-fringes terraform-mode enh-ruby-mode psession telega dired-sidebar centaur-tabs writeroom-mode workgroups memory-usage drupal-mode phpunit phpcbf php-auto-yasnippets php-mode zones sr-speedbar evil-ruby-text-objects tempbuf wakatime-mode rspec-simple ido-completing-read+ shrink-path amx ri-mode ri smooth-scrolling ivy-youtube wgrep lv flyspell-correct-ivy counsel-projectile counsel swiper ivy doom-todo-ivy magit-todos todo-projectile hl-block hl-block-mode indent-guide-mode highlight-indent-guides-mode vi-tilde-fringe spaceline powerline evil-nerd-commenter define-word zencoding-mode yapfify yaml-mode xterm-color ws-butler winum which-key web-mode web-beautify volatile-highlights uuidgen use-package unfill typo toml-mode toc-org tide tagedit tabbar sublimity smeargle slim-mode simpleclip shell-pop scss-mode sass-mode rvm ruby-tools ruby-test-mode rubocopfmt rubocop rspec-mode robe reveal-in-osx-finder restart-emacs rbenv rainbow-mode rainbow-identifiers rainbow-delimiters racer pyvenv pytest pyenv-mode py-isort pug-mode projectile-rails prodigy popwin pip-requirements persistent-scratch pbcopy paradox osx-trash osx-dictionary orgit org-projectile org-present org-pomodoro org-mime org-download org-bullets open-junk-file ns-auto-titlebar nginx-mode mwim multi-term move-text mmm-mode minitest markdown-toc magit-gitflow macrostep lua-mode lorem-ipsum livid-mode live-py-mode linum-relative link-hint launchctl json-mode js2-refactor js-doc itail indent-guide hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation highlight-indent-guides helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag handlebars-sgml-mode google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-gutter-fringe gh-md gcmh fuzzy flyspell-correct-helm flx-ido fill-column-indicator fic-mode feature-mode fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-commentary evil-cleverparens evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help emmet-mode ember-mode elisp-slime-nav dumb-jump dracula-theme doom-themes doom-modeline discover-my-major diminish diff-hl cython-mode csv-mode company-web company-tern company-statistics company-anaconda column-enforce-mode coffee-mode clean-aindent-mode chruby cargo bundler bpr auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))
 '(pdf-view-midnight-colors (cons "#f8f8f2" "#282a36"))
 '(persp-auto-save-num-of-backups 10 nil nil "Customized with use-package persp-mode")
 '(persp-autokill-buffer-on-remove 'kill-weak nil nil "Customized with use-package persp-mode")
 '(persp-interactive-completion-system 'ido nil nil "Customized with use-package persp-mode")
 '(persp-keymap-prefix "" nil nil "Customized with use-package persp-mode")
 '(persp-kill-foreign-buffer-behaviour 'kill)
 '(persp-nil-name "nil" nil nil "Customized with use-package persp-mode")
 '(popwin-mode t)
 '(popwin:popup-window-height 8)
 '(popwin:popup-window-width 80)
 '(popwin:special-display-config
   '(("^\\*RuboCop.+\\*$" :regexp t :height 0.4 :position bottom :noselect t :dedicated t :stick t :tail t)
     ("*rspec-compilation*" :width 0.33 :position bottom :noselect t :dedicated t :stick t :tail t)
     ("*rake-compilation*" :height 0.4 :position bottom :noselect t :dedicated t :stick t)
     ("*projectile-rails-generate*" :height 0.4 :position bottom :noselect t :dedicated t :stick t)
     ("*projectile-rails-compilation*" :height 0.4 :position bottom :noselect t :dedicated t :stick t)
     ("*Bundler*" :height 0.4 :position bottom :noselect t :dedicated t :stick t)
     ("*Google Translate*" :height 0.4 :position bottom :noselect t :dedicated t :stick t)
     ("^*WoMan.+*$" :regexp t :position bottom)
     ("*nosetests*" :position bottom :noselect nil :dedicated t :stick t)
     ("*grep*" :position bottom :noselect nil :dedicated t :stick t)
     ("*ert*" :position bottom :noselect nil :dedicated t :stick t)
     ("*undo-tree Diff*" :height 0.3 :position bottom :noselect nil :dedicated t :stick t)
     ("*undo-tree*" :width 60 :position right :noselect nil :dedicated t :stick t)
     ("*Async Shell Command*" :position bottom :noselect nil :dedicated t :stick t)
     ("*Shell Command Output*" :position bottom :noselect nil :dedicated t :stick t)
     ("*compilation*" :height 0.4 :position bottom :noselect t :dedicated t :stick t)
     ("*Process List*" :height 0.4 :position bottom :noselect nil :dedicated t :stick t)
     ("*Help*" :height 0.4 :position bottom :noselect t :dedicated t :stick t)))
 '(popwin:universal-display-config '(t))
 '(prettify-symbols-unprettify-at-point 'right-edge)
 '(projectile-indexing-method 'hybrid)
 '(rainbow-identifiers-cie-l*a*b*-lightness 50)
 '(rainbow-identifiers-cie-l*a*b*-saturation 20)
 '(rainbow-identifiers-faces-to-override '(font-lock-variable-name-face))
 '(require-final-newline t)
 '(rspec-autosave-buffer t)
 '(rspec-spec-command "rspec -f doc")
 '(rspec-use-docker-when-possible t)
 '(rubocopfmt-rubocop-command "/Users/HMz/Development/GoDaddy/nemo/rubocop_wrapper.sh")
 '(rubocopfmt-use-bundler-when-possible nil)
 '(rustic-ansi-faces
   ["#282a36" "#ff5555" "#50fa7b" "#f1fa8c" "#61bfff" "#ff79c6" "#8be9fd" "#f8f8f2"])
 '(safe-local-variable-values
   '((eval progn
           (pp-buffer)
           (indent-buffer))
     (eval progn
           (pp-buffer))
     (column-enforce-column . 125)
     (rubocopfmt-rubocop-command . "/Users/HMz/Development/GoDaddy/nemo/rubocop_wrapper.sh")
     (rubocopfmt-mode . -1)
     (typescript-backend . tide)
     (typescript-backend . lsp)
     (javascript-backend . tide)
     (javascript-backend . tern)
     (javascript-backend . lsp)))
 '(shell-pop-cleanup-buffer-at-process-exit t)
 '(shell-pop-full-span nil t)
 '(shell-pop-restore-window-configuration t)
 '(shell-pop-window-position "bottom" t)
 '(shell-pop-window-size 30 t)
 '(sp-highlight-pair-overlay nil)
 '(sp-highlight-wrap-overlay nil)
 '(sp-highlight-wrap-tag-overlay nil)
 '(speedbar-use-images nil)
 '(sublimity-attractive-centering-width 120)
 '(sublimity-mode t)
 '(sublimity-scroll-weight 2.0)
 '(tempbuf-kill-hook nil)
 '(tooltip-use-echo-area t)
 '(tramp-copy-size-limit 1000000)
 '(tramp-inline-compress-start-size 1000000)
 '(tramp-verbose 10 t)
 '(use-dialog-box t)
 '(use-package-always-demand t)
 '(use-package-check-before-init t)
 '(use-package-compute-statistics t)
 '(use-package-defaults
   '((:straight
      '(t)
      straight-use-package-by-default)
     (:config
      '(t)
      t)
     (:init nil t)
     (:catch t
             (lambda
               (name args)
               (not use-package-expand-minimally)))
     (:defer use-package-always-defer
             (lambda
               (name args)
               (and use-package-always-defer
                    (not
                     (plist-member args :defer))
                    (not
                     (plist-member args :demand)))))
     (:demand use-package-always-demand
              (lambda
                (name args)
                (and use-package-always-demand
                     (not
                      (plist-member args :defer))
                     (not
                      (plist-member args :demand)))))
     (:ensure
      (list use-package-always-ensure)
      (lambda
        (name args)
        (and use-package-always-ensure
             (not
              (plist-member args :load-path)))))
     (:pin use-package-always-pin use-package-always-pin)))
 '(use-package-expand-minimally nil)
 '(use-package-minimum-reported-time 0)
 '(use-package-verbose 'debug)
 '(vc-annotate-background "#282a36")
 '(vc-annotate-color-map
   (list
    (cons 20 "#50fa7b")
    (cons 40 "#85fa80")
    (cons 60 "#bbf986")
    (cons 80 "#f1fa8c")
    (cons 100 "#f5e381")
    (cons 120 "#face76")
    (cons 140 "#ffb86c")
    (cons 160 "#ffa38a")
    (cons 180 "#ff8ea8")
    (cons 200 "#ff79c6")
    (cons 220 "#ff6da0")
    (cons 240 "#ff617a")
    (cons 260 "#ff5555")
    (cons 280 "#d45558")
    (cons 300 "#aa565a")
    (cons 320 "#80565d")
    (cons 340 "#6272a4")
    (cons 360 "#6272a4")))
 '(vc-annotate-very-old-color nil)
 '(volatile-highlights-mode t)
 '(wakatime-api-key "79de0de9-6375-48d1-b78f-440418c5e5a0")
 '(wakatime-cli-path "/usr/local/bin/wakatime")
 '(wakatime-python-bin "/usr/local/bin/python3")
 '(web-mode-markup-indent-offset 2)
 '(workgroups-mode t)
 '(yascroll:delay-to-hide 1.5)
 '(yascroll:disabled-modes '(Custom-mode org-mode))
 '(yascroll:scroll-bar '(right-fringe left-fringe text-area)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ahs-definition-face ((t (:weight bold))))
 '(ahs-edit-mode-face ((t (:weight bold))))
 '(ahs-face ((t (:weight bold))))
 '(ahs-plugin-whole-buffer-face ((t nil)))
 '(all-the-icons-dorange ((t (:foreground "tan3"))))
 '(all-the-icons-lmaroon ((t (:foreground "burlywood3"))))
 '(all-the-icons-maroon ((t (:foreground "burlywood3"))))
 '(anzu-match-2 ((t (:foreground "deep sky blue"))))
 '(anzu-replace-highlight ((t (:box (:line-width 2 :color "sienna1")))))
 '(bm-persistent-face ((t (:overline "DarkGoldenrod4"))))
 '(bold ((t (:weight bold))))
 '(custom-button ((t (:background "lightgrey" :foreground "black" :box 2))))
 '(custom-button-mouse ((t (:background "grey90" :foreground "black" :box 2))))
 '(custom-button-pressed ((t (:background "gray" :foreground "black" :box 2))))
 '(evil-search-highlight-persist-highlight-face ((t (:inherit lazy-highlight))))
 '(fic-face ((t (:weight bold))))
 '(flyspell-duplicate ((t (:underline "DarkOrange"))))
 '(flyspell-incorrect ((t (:background "#220000" :overline nil :underline "#ff5555"))))
 '(font-lock-comment-face ((t (:foreground "LightSteelBlue3"))))
 '(font-lock-warning-face ((t (:background "#373844" :foreground "#ffb86c" :underline (:color "red" :style wave)))))
 '(fringe ((t (:foreground "DeepSkyBlue" :background unspecified))))
 '(header-line ((t (:background "#44475a" :underline "gray20" :height 1.0 :family "San Francisco"))))
 '(hi-yellow ((t nil)))
 '(highlight-indent-guides-character-face ((t (:foreground "#3df1410a539f"))))
 '(hl-line ((t nil)))
 '(hydra-face-red ((t (:foreground "#FF0000" :weight bold))))
 '(indent-guide-face ((t (:inherit font-lock-constant-face :slant normal))))
 '(line-number ((t (:background "#282a36" :foreground "#565761" :slant normal :height 0.8))))
 '(line-number-current-line ((t (:inherit (font-lock-keyword-face hl-line line-number)))))
 '(link ((t (:foreground "SkyBlue1" :underline nil :height 1.05 :family "San Francisco"))))
 '(linum ((t (:inherit hl-line :background "#282a36" :foreground "#565761" :slant italic))))
 '(magit-blame-highlight ((t (:inherit (font-lock-comment-face hl-line) :height 0.8 :family "San Francisco"))))
 '(magit-blame-name ((t (:inherit font-lock-variable-name-face))) t)
 '(magit-log-author ((t (:foreground "dark gray" :family "San Francisco"))))
 '(magit-section-heading ((t (:extend t :foreground "#ff79c6" :weight bold))))
 '(minibuffer-prompt ((t (:foreground "#ff79c6" :weight bold :height 1.2 :family "San Francisco"))))
 '(mode-line ((t (:foreground "White" :box (:line-width 1 :color "#44475a") :height 0.9 :family "San Francisco"))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#373844" :foreground "#f8f8f2" :height 120))))
 '(neo-banner-face ((t (:inherit font-lock-constant-face :weight bold :family "San Francisco"))))
 '(neo-button-face ((t (:underline nil :family "San Francisco"))))
 '(neo-dir-link-face ((t (:foreground "DeepSkyBlue" :family "San Francisco"))))
 '(neo-expand-btn-face ((t (:foreground "SkyBlue" :family "San Francisco"))))
 '(neo-file-link-face ((t (:foreground "White" :family "San Francisco"))))
 '(neo-root-dir-face ((t (:foreground "gray40" :weight bold))))
 '(neo-vc-added-face ((t (:foreground "#50fa7b"))))
 '(neo-vc-conflict-face ((t (:foreground "dark red"))))
 '(neo-vc-edited-face ((t (:foreground "#ff79c6"))))
 '(org-block ((t (:extend t :background "#1f1f3f" :foreground "#ffb86c"))))
 '(org-block-begin-line ((t (:inherit org-meta-line :extend t :height 1.2))))
 '(org-done ((t (:foreground "gold" :height 1.5))))
 '(org-headline-done ((t (:inherit org-headline-todo :weight bold :height 1.2))))
 '(org-level-1 ((t (:inherit link :extend nil :foreground "tomato3" :underline nil :weight bold :height 1.3 :family "San Francisco"))))
 '(org-level-2 ((t (:inherit nil :extend nil :foreground "goldenrod" :weight bold :height 1.1))))
 '(org-level-3 ((t (:extend nil :foreground "#50fa7b" :weight bold :height 1.1))))
 '(org-level-7 ((t (:extend nil :foreground "light salmon" :weight normal))))
 '(org-link ((t (:inherit link :foreground "SkyBlue2" :underline nil))))
 '(org-quote ((t (:inherit nil :background "gray20" :foreground "gray80" :slant italic))))
 '(org-todo ((t (:background "#373844" :foreground "#ffb86c" :weight bold :height 1.2))))
 '(org-verbatim ((t (:inherit font-lock-variable-name-face :family "Fira Code"))))
 '(origami-fold-replacement-face ((t (:inherit 'font-lock-builtin-face))))
 '(outshine-level-1 ((t (:inherit outline-1 :weight bold :height 1.1 :family "San Francisco"))))
 '(spacemacs-transient-state-title-face ((t (:inherit mode-line :height 0.8))))
 '(speedbar-button-face ((t nil)))
 '(speedbar-file-face ((t nil)))
 '(speedbar-highlight-face ((t nil)))
 '(speedbar-selected-face ((t nil)))
 '(speedbar-separator-face ((t nil)))
 '(speedbar-tag-face ((t nil)))
 '(tab-line ((t (:inherit variable-pitch :background "#44475a" :foreground "#bd93f9" :underline t :height 1.0))))
 '(tabbar-default ((t (:inherit (hl-line header-line) :box nil :underline nil :weight light :height 0.8))))
 '(tabbar-icon-unselected ((t (:box nil :inherit 'tabbar-default :underline t))))
 '(tabbar-selected ((t (:inherit tabbar-default :background "#282a36" :box nil :overline nil :weight bold))))
 '(which-key-posframe-border ((t (:inherit default :background "gray50" :underline t))))
 '(window-divider ((t (:foreground "black"))))
 '(yascroll:thumb-fringe ((t (:inherit font-lock-comment-face :background "MediumPurple4" :foreground "MediumPurple4")))))
)
