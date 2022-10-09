;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

;; troubleshoot
(setq debug-on-error nil)
(setq debug-on-quit nil)
(setq warning-minimum-level :emergency)

;; it may cause problems with spacemacs own loader
(setq straight-use-package-by-default nil)

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' willl
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; List of additional paths where to look for configuration layers/../.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to loader.
   dotspacemacs-configuration-layers
   '(go
     csv
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------

     elixir
     python ;; required
     ruby-on-rails
     typography
     (ibuffer :variables ibuffer-group-buffers-by 'projects)
     (auto-completion :variables
                      auto-completion-complete-with-key-sequence "jk"
                      auto-completion-complete-with-key-sequence nil
                      auto-completion-complete-with-key-sequence-delay 0.01
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-sort-by-usage t
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-use-company-box t
                      auto-completion-use-company-posframe t
                      spacemacs-default-company-backends '(company-files company-capf))

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
                 javascript-backend 'tide)
     (spell-checking :variables
                     spell-checking-enable-by-default t)
     ;; custom layers
     hmz-color-identifiers
     hmz-tabbar

     better-defaults
     coffeescript
     emacs-lisp

     ;; evil-cleverparens
     ;; evil-collection
     evil-commentary
     ;; evil-magit
     ;; evil-matchit
     ;; github ;; keybinding warnings
                                        ;
     git
     dtrt-indent
     html
     lua
     helm
     python ;; required?
     lsp
     markdown
     neotree
     org
     shell-scripts
     spell-checking
     sql
     syntax-checking
     tide
     typography
     version-control
     vinegar
     web-beautify
     yaml

     (ibuffer :variables ibuffer-group-buffers-by 'projects)

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


   ;; List of additional packages that will be installed without being wrapped
   ;; in a layer (generally the packages are installed only and should still be
   ;; loaded using load/require/use-package in the user-config section below in
   ;; this file). If you need some configuration for these packages, then
   ;; consider creating a layer. You can also put the configuration in
   ;; `dotspacemacs/user-config'. To use a local version of a package, use the
   ;; `:location' property: '(your-package :location "~/path/to/your-package/")
   ;; Also
   dotspacemacs-additional-packages
   '(
     bug-hunter
     docker-tramp
     dockerfile-mode
     dracula-theme
     epresent
     fic-mode
     fira-code-mode
     fringe-helper
     ido-completing-read+
     jist
     memory-usage
     ns-auto-titlebar ;; required
     org-bullets
     ox-gfm
     persistent-scratch
     rg
     simpleclip ;; required
     unobtrusive-magit-theme
     )


   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(treemacs treemacs-icons-dired)

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need to
   ;; compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;;
   ;; WARNING: pdumper does not work with Native Compilation, so it's disabled
   ;; regardless of the following setting when native compilation is in effect.
   ;;
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=$HOME/.emacs.d/.cache/dumps/spacemacs-27.1.pdmp
   ;; (default (format "spacemacs-%s.pdmp" emacs-version))
   dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. Spacelpa is currently in
   ;; experimental state please use only for testing purposes.
   ;; (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'hybrid

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

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
   ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   ;; The exceptional case is `recents-by-project', where list-type must be a
   ;; pair of numbers, e.g. `(recents-by-project . (7 .  5))', where the first
   ;; number is the project limit and the second the limit on the recent files
   ;; within a project.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Show numbers before the startup list lines. (default t)
   dotspacemacs-show-startup-list-numbers t

   ;; The minimum delay in seconds between number key presses. (default 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
   ;; *scratch* buffer will be saved and restored automatically.
   dotspacemacs-scratch-buffer-persistent t

   ;; If non-nil, `kill-buffer' on *scratch* buffer
   ;; will bury it instead of killing.
   dotspacemacs-scratch-buffer-unkillable t

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(dracula)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   dotspacemacs-default-font '("Fira Code"
                               :size 14
                               :height 120)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
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
   ;; (default "C-M-m" for terminal mode, "<M-return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   dotspacemacs-major-mode-emacs-leader-key (if window-system "<M-return>" "C-M-m")

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

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

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state t

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
   ;; borderless fullscreen. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 95

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 95

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Show the scroll bar while scrolling. The auto hide time can be configured
   ;; by setting this variable to a number. (default t)
   dotspacemacs-scroll-bar-while-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but only visual lines are counted. For example, folded lines will not be
   ;; counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers nil ;; (default nil)

   ;; Code folding method. Possible values are `evil', `origami' and `vimish'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil and `dotspacemacs-activate-smartparens-mode' is also non-nil,
   ;; `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil smartparens-mode will be enabled in programming modes.
   ;; (default t)
   dotspacemacs-activate-smartparens-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)

   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; If nil then Spacemacs uses default `frame-title-format' to avoid
   ;; performance issues, instead of calculating the frame title by
   ;; `spacemacs/title-prepare' all the time.
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Show trailing whitespace (default t)
   dotspacemacs-show-trailing-whitespace t

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; If non-nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfere with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Accept SPC as y for prompts if non-nil. (default nil)
   dotspacemacs-use-SPC-as-y nil

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert state). Currently supported keyboard layouts are:
   ;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non-nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil

   ;; If non-nil then byte-compile some of Spacemacs files.
   dotspacemacs-byte-compile nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env)
)

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
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


)

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
)

  ;; Find String in Project
  (global-set-key (kbd "s-F") 'helm-projectile-ag)
(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
  ;; ;; fix doom-modeline and neotree not starting
  (defun colors//rainbow-identifiers-ignore-keywords ()
    "Do not colorize stuff with ‘font-lock-keyword-face’."
    (setq-local rainbow-identifiers-faces-to-override
                (delq 'font-lock-keyword-face
                      rainbow-identifiers-faces-to-override)))

  (load "~/.spacemacs.d/hmz-modules")
  (load "~/.spacemacs.d/hmz-custom")
)


;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
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
 '(auto-revert-buffer-list-filter 'magit-auto-revert-buffer-p)
 '(auto-revert-verbose t)
 '(before-save-hook
   '(time-stamp whitespace-cleanup spacemacs//python-sort-imports))
 '(coffee-tab-width 2)
 '(csv-separators '("," ";"))
 '(custom-safe-themes
   '("18bec4c258b4b4fb261671cf59197c1c3ba2a7a47cc776915c3e8db3334a0d25" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "0ab2aa38f12640ecde12e01c4221d24f034807929c1f859cbca444f7b0a98b3a" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "2dff5f0b44a9e6c8644b2159414af72261e38686072e063aa66ee98a2faecf0e" "7451f243a18b4b37cabfec57facc01bd1fe28b00e101e488c61e1eed913d9db9" "e6ff132edb1bfa0645e2ba032c44ce94a3bd3c15e3929cdf6c049802cf059a2a" "eb5c79b2e9a91b0a47b733a110d10774376a949d20b88c31700e9858f0f59da7" "a41b81af6336bd822137d4341f7e16495a49b06c180d6a6417bf9fd1001b6d2b" "57bd93e7dc5fbb5d8d27697185b753f8563fe0db5db245592bab55a8680fdd8c" "890a1a44aff08a726439b03c69ff210fe929f0eff846ccb85f78ee0e27c7b2ea" "819ab08867ef1adcf10b594c2870c0074caf6a96d0b0d40124b730ff436a7496"))
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
 '(lsp-ui-doc-use-webkit t)
 '(lsp-ui-sideline-ignore-duplicate t)
 '(lsp-ui-sideline-show-symbol nil)
 '(magit-diff-adjust-tab-width t)
 '(magit-diff-highlight-trailing 'all)
 '(magit-diff-paint-whitespace 'all)
 '(magit-diff-refine-hunk 'all)
 '(magit-diff-refine-ignore-whitespace nil)
 '(magit-list-refs-sortby '("-creatordate"))
 '(magit-status-margin '(t age-abbreviated magit-log-margin-width t 11))
 '(magit-status-sections-hook
   '(magit-insert-status-headers magit-insert-merge-log magit-insert-rebase-sequence magit-insert-am-sequence magit-insert-sequencer-sequence magit-insert-bisect-output magit-insert-bisect-rest magit-insert-bisect-log magit-insert-ignored-files magit-insert-untracked-files magit-insert-unstaged-changes magit-insert-staged-changes magit-insert-stashes magit-insert-unpushed-to-pushremote magit-insert-unpushed-to-upstream-or-recent magit-insert-unpulled-from-pushremote magit-insert-unpulled-from-upstream))
 '(markdown-hide-urls t)
 '(markdown-italic-underscore t)
 '(message-sent-hook '((lambda nil (message (buffer-name)))))
 '(midnight-mode t)
 '(mode-line-in-non-selected-windows t)
 '(mode-require-final-newline t)
 '(nano-modeline-position 'bottom)
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
 '(org-blank-before-new-entry '((heading) (plain-list-item)))
 '(org-bullets-bullet-list '("◉" "○" "●" "☞"))
 '(org-ellipsis " ▼")
 '(org-export-backends '(ascii html icalendar latex md odt))
 '(org-export-with-section-numbers 2)
 '(org-fontify-done-headline nil)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-log-done nil)
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-eww ol-gnus org-habit ol-info ol-irc ol-mhe ol-rmail ol-w3m org-mac-link))
 '(org-todo-keywords
   '((sequence "TODO:(t)" "WAIT:(w)" "|" "Q:(n)" "DONE:(d)" "CANCELED:(c)")))
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
   '(google-this modern-fringes terraform-mode enh-ruby-mode psession telega dired-sidebar centaur-tabs writeroom-mode workgroups memory-usage drupal-mode phpunit phpcbf php-auto-yasnippets php-mode zones sr-speedbar evil-ruby-text-objects tempbuf wakatime-mode rspec-simple ido-completing-read+ shrink-path amx ri-mode ri smooth-scrolling ivy-youtube wgrep lv flyspell-correct-ivy counsel-projectile counsel swiper ivy doom-todo-ivy magit-todos todo-projectile hl-block hl-block-mode indent-guide-mode highlight-indent-guides-mode vi-tilde-fringe spaceline powerline evil-nerd-commenter define-word zencoding-mode yapfify yaml-mode xterm-color ws-butler winum which-key web-mode web-beautify volatile-highlights uuidgen use-package unfill typo toml-mode toc-org tide tagedit tabbar sublimity smeargle slim-mode simpleclip shell-pop scss-mode sass-mode rvm ruby-tools ruby-test-mode rubocopfmt rubocop rspec-mode robe reveal-in-osx-finder restart-emacs rbenv rainbow-mode rainbow-identifiers rainbow-delimiters racer pyvenv pytest pyenv-mode py-isort pug-mode projectile-rails prodigy popwin pip-requirements persistent-scratch pbcopy paradox osx-trash osx-dictionary orgit org-projectile org-present org-pomodoro org-mime org-download org-bullets open-junk-file ns-auto-titlebar nginx-mode mwim multi-term move-text mmm-mode minitest markdown-toc magit-gitflow macrostep lua-mode lorem-ipsum livid-mode live-py-mode linum-relative link-hint launchctl json-mode js2-refactor js-doc itail indent-guide hy-mode hungry-delete htmlize highlight-parentheses highlight-numbers highlight-indentation highlight-indent-guides helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag handlebars-sgml-mode google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-gutter-fringe gh-md gcmh fuzzy flyspell-correct-helm flx-ido fill-column-indicator fic-mode feature-mode fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-commentary evil-cleverparens evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help emmet-mode ember-mode elisp-slime-nav dumb-jump dracula-theme doom-themes doom-modeline discover-my-major diminish diff-hl cython-mode csv-mode company-web company-tern company-statistics company-anaconda column-enforce-mode coffee-mode clean-aindent-mode chruby cargo bundler bpr auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))
 '(pdf-view-midnight-colors (cons "#f8f8f2" "#282a36"))
 '(persp-auto-save-num-of-backups 10 nil nil "Customized with use-package persp-mode")
 '(persp-autokill-buffer-on-remove 'kill-weak nil nil "Customized with use-package persp-mode")
 '(persp-interactive-completion-system 'ido nil nil "Customized with use-package persp-mode")
 '(persp-keymap-prefix "" nil nil "Customized with use-package persp-mode")
 '(persp-kill-foreign-buffer-behaviour 'kill)
 '(persp-nil-name "nil" nil nil "Customized with use-package persp-mode")
 '(pixel-scroll-mode nil)
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
 '(rubocopfmt-include-unsafe-cops t)
 '(rubocopfmt-use-bundler-when-possible nil)
 '(rustic-ansi-faces
   ["#282a36" "#ff5555" "#50fa7b" "#f1fa8c" "#61bfff" "#ff79c6" "#8be9fd" "#f8f8f2"])
 '(safe-local-variable-values
   '((rubocopfmt-rubocop-command . "rubocop")
     (rubocopfmt-rubocop-command . "/Users/HMz/.gem/bin/rubocop --cache false")
     (rubocopfmt-rubocop-command . "/Users/HMz/.gem/bin/rubocop")
     (eval progn
           (pp-buffer)
           (indent-buffer))
     (column-enforce-column . 125)
     (flycheck-eslintrc "/Users/HMz/Development/GoDaddy/nemo/nemo/app/ui/.eslintrc")
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
 '(tabbar-mode t nil (tabbar))
 '(tempbuf-kill-hook nil)
 '(tooltip-use-echo-area t)
 '(tramp-copy-size-limit 1000000)
 '(tramp-inline-compress-start-size 1000000)
 '(tramp-verbose 10)
 '(use-dialog-box t)
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
 '(column-enforce-face ((t (:underline "gold"))))
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
 '(git-gutter:added ((t (:foreground "medium spring green" :weight bold))))
 '(git-gutter:modified ((t (:foreground "deep pink" :weight bold))))
 '(header-line ((t (:background "#44475a" :underline "gray20" :height 1.0 :family "San Francisco"))))
 '(hi-yellow ((t nil)))
 '(highlight-indent-guides-character-face ((t (:foreground "#3df1410a539f"))))
 '(hl-line ((t nil)))
 '(hydra-face-red ((t (:foreground "#FF0000" :weight bold))))
 '(indent-guide-face ((t (:inherit font-lock-comment-face :foreground "#669" :slant normal))))
 '(line-number ((t (:background "#282a36" :foreground "#565761" :slant normal :height 0.8))))
 '(line-number-current-line ((t (:inherit (font-lock-keyword-face hl-line line-number)))))
 '(link ((t (:foreground "SkyBlue1" :underline nil :height 1.05 :family "San Francisco"))))
 '(linum ((t (:inherit hl-line :background "#282a36" :foreground "#565761" :slant italic))))
 '(magit-blame-heading ((t (:inherit magit-blame-highlight :extend t :background "black" :slant normal :weight normal))))
 '(magit-blame-highlight ((t (:inherit (font-lock-comment-face hl-line) :height 0.8 :family "San Francisco"))))
 '(magit-blame-name ((t (:inherit font-lock-variable-name-face))))
 '(magit-diff-our ((t (:background "cornflower blue"))))
 '(magit-diff-our-highlight ((t (:background "dodger blue"))))
 '(magit-log-author ((t (:foreground "dark gray" :family "San Francisco"))))
 '(magit-section-heading ((t (:extend t :foreground "#ff79c6" :weight bold))))
 '(magit-section-highlight ((t (:extend t :background "#464752"))))
 '(minibuffer-prompt ((t (:foreground "#ff79c6" :weight bold :height 0.9 :family "San Francisco"))))
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
 '(org-block ((t (:extend t :background "#1f1f3a" :foreground "powder blue"))))
 '(org-block-begin-line ((t (:inherit (org-meta-line org-block) :extend t :overline "#666" :height 1.0))))
 '(org-block-end-line ((t (:inherit (org-block-begin-line org-block) :extend t :overline nil))))
 '(org-done ((t (:foreground "cyan" :height 1.2))))
 '(org-headline-done ((t (:inherit org-headline-todo :weight bold :height 1.2))))
 '(org-level-1 ((t (:inherit link :extend nil :foreground "tomato3" :underline nil :weight bold :height 1.3 :family "San Francisco"))))
 '(org-level-2 ((t (:inherit nil :extend nil :foreground "goldenrod" :weight bold :height 1.1))))
 '(org-level-3 ((t (:extend nil :foreground "#50fa7b" :weight bold :height 1.1))))
 '(org-level-7 ((t (:extend nil :foreground "light salmon" :weight normal))))
 '(org-link ((t (:inherit link :foreground "SkyBlue2" :underline nil))))
 '(org-meta-line ((t (:inherit (fixed-pitch font-lock-comment-face) :foreground "#666"))))
 '(org-quote ((t (:inherit org-block :foreground "gray80" :slant italic))))
 '(org-todo ((t (:background "#373844" :foreground "#ffb86c" :weight bold :height 1.2))))
 '(org-verbatim ((t (:inherit font-lock-variable-name-face :family "Fira Code"))))
 '(origami-fold-replacement-face ((t (:inherit 'font-lock-builtin-face))))
 '(outshine-level-1 ((t (:inherit outline-1 :weight bold :height 1.1 :family "San Francisco"))))
 '(spacemacs-transient-state-title-face ((t (:inherit mode-line :height 0.8))))
 '(tab-line ((t (:inherit variable-pitch :background "#44475a" :foreground "#bd93f9" :underline t :height 1.0))))
 '(tabbar-default ((t (:inherit (hl-line header-line) :box nil :underline nil :weight light :height 0.8))))
 '(tabbar-icon-unselected ((t (:box nil :inherit 'tabbar-default :underline t))))
 '(tabbar-selected ((t (:inherit tabbar-default :background "#282a36" :box nil :overline nil :weight bold))))
 '(which-key-posframe-border ((t (:inherit default :background "gray50" :underline t))))
 '(window-divider ((t (:foreground "black"))))
 '(yascroll:thumb-fringe ((t (:inherit font-lock-comment-face :background "MediumPurple4" :foreground "MediumPurple4")))))
)
