;; -*- coding: utf-8; -*-           jujuba
(defvar hmz-tabbar-packages
  '(
    tabbar
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defun hmz-tabbar/init-tabbar ()
  (use-package tabbar
    :defer t

    :init
    ;; init me!
    (tabbar-mode 1)

    ;; safari like back and forward tabs
    (global-set-key [(control tab)] 'tabbar-forward-tab)
    (global-set-key [(control shift tab)] 'tabbar-backward-tab)

    ;; make tab and shift tab move between groups when in Evil Mode (tm)
    (define-key evil-normal-state-map (kbd "<tab>") 'next-buffer)
    (define-key evil-normal-state-map (kbd "<S-tab>") 'previous-buffer)

    ;; Used some spacemacs space to cycle between tabbar groups
    (spacemacs/set-leader-keys "SPC" 'helm-M-x
      "[" 'tabbar-backward-group
      "]" 'tabbar-forward-group)


    ;; map mouse wheel events on header line
    (global-set-key [header-line wheel-right] 'tabbar-press-scroll-right)
    (global-set-key [header-line double-wheel-right] 'tabbar-press-scroll-right)
    (global-set-key [header-line triple-wheel-right] 'tabbar-press-scroll-right)
    (global-set-key [header-line wheel-left] 'tabbar-press-scroll-left)
    (global-set-key [header-line double-wheel-left] 'tabbar-press-scroll-left)
    (global-set-key [header-line triple-wheel-left] 'tabbar-press-scroll-left)

    :config
    (defun plist-merge (&rest plists)
      (if plists
          (let ((result (copy-sequence (car plists))))
            (while (setq plists (cdr plists))
              (let ((plist (car plists)))
                (while plist
                  (setq result (plist-put result (car plist) (car (cdr plist)))
                        plist (cdr (cdr plist))))))
            result)
        nil))

    ;; override so we can change default value instead of custom one
    (setq tabbar-separator (list 1.2))

    (defun hmz-tabbar-refresh-faces ()
      "Refreshes faces dependent of theme faces."

      (set-face-attribute 'tabbar-default nil
                          :inherit 'header-line
                          :foreground 'unspecified
                          :background 'unspecified
                          :underline nil
                          :weight 'light
                          :box nil)

      (set-face-attribute 'tabbar-selected-modified nil
                          :box nil
                          :foreground (face-attribute 'font-lock-builtin-face :foreground)
                          :inherit 'tabbar-selected
                          :overline t
                          :weight 'normal)

      (set-face-attribute 'tabbar-selected nil
                          :box nil
                          :foreground (face-attribute 'font-lock-function-name-face :foreground)
                          :inherit 'tabbar-default
                          :overline t
                          :weight 'normal)

      (set-face-attribute 'tabbar-highlight nil
                          :inherit 'tabbar-default
                          :foreground (face-attribute
                                       'font-lock-keyword-face :foreground)
                          :underline nil
                          :overline t
                          :box nil)

      (set-face-attribute 'tabbar-modified nil
                          :box nil
                          :foreground (face-attribute 'font-lock-builtin-face :foreground)
                          :background 'unspecified
                          :inherit 'tabbar-default)

      (set-face-attribute 'tabbar-unselected nil
                          :foreground 'unspecified
                          :background 'unspecified
                          :box nil
                          :inherit 'tabbar-default)

      (set-face-attribute 'tabbar-button nil
                          :height 1.5
                          :inherit 'tabbar-default)
      )

    (hmz-tabbar-refresh-faces)

    (add-to-list 'all-the-icons-icon-alist
                 '("\\.lua$" all-the-icons-wicon "moon-waning-crescent-3" :face all-the-icons-cyan))

    ;; Override function that writes tab names so we can insert
    ;; an stylized text with icons
    (defsubst tabbar-line-tab (tab)
      "Return the display representation of tab TAB.
That is, a propertized string used as an `header-line-format' template
element.
Call `tabbar-tab-label-function' to obtain a label for TAB."
      (let*
          ((tab-face (cond ((and (tabbar-selected-p tab (tabbar-current-tabset))
                                 (tabbar-modified-p tab (tabbar-current-tabset)))
                            'tabbar-selected-modified)
                           ((tabbar-selected-p tab (tabbar-current-tabset))
                            'tabbar-selected)
                           ((tabbar-modified-p tab (tabbar-current-tabset))
                            'tabbar-modified)
                           (t 'tabbar-unselected)))

           (the-icon (all-the-icons-icon-for-file
                      (replace-regexp-in-string "<.*>" "" (format "%s"(tabbar-tab-value tab)))))

           (tab-is-active (tabbar-selected-p tab (tabbar-current-tabset)))

           (icon-face (plist-get (text-properties-at 0 the-icon) 'face))
           )

        (concat
         (propertize
          the-icon
          'face (plist-merge
                 ;; (get icon-face 'foreground)
                 (plist-get (text-properties-at 0 the-icon) 'face)
                 `(:background ,(tabbar-background-color))
                 (if tab-is-active
                     `(:overline ,(face-attribute tab-face :foreground nil 'default))
                   `(:foreground ,(face-attribute 'header-line :foreground nil 'default)))
                 )
          'display (if tab-is-active '(raise 0.0) '(raise 0.0))
          'tabbar-tab tab
          'local-map (tabbar-make-tab-keymap tab)
          'help-echo 'tabbar-help-on-tab
          'mouse-face 'tabbar-highlight
          )
         (propertize
          (concat
           " "
           (if tabbar-tab-label-function
               (funcall tabbar-tab-label-function tab)
             tab))
          'tabbar-tab tab
          'local-map (tabbar-make-tab-keymap tab)
          'help-echo 'tabbar-help-on-tab
          'mouse-face 'tabbar-highlight
          'face tab-face
          'display `(raise ,(symbol-value 'hmz-tabbar-raise-text))
          'pointer 'hand)
         tabbar-separator-value)))

    (defsubst tabbar-line-button (name)
      "Return the display representation of button NAME.
That is, a propertized string used as an `header-line-format' template
element."
      (let* ((label (if tabbar-button-label-function
                        (funcall tabbar-button-label-function name)
                      (cons name name)))
             (glyph (cond ((eq name 'home)
                           (concat " "
                                   (all-the-icons-wicon "alien"
                                                        :face '(:inherit tabbar-default :height 1.2))))
                          ((eq name 'scroll-left) (all-the-icons-material "navigate_before"))
                          ((eq name 'scroll-right) (all-the-icons-material "navigate_next"))
                          (t "X")))

             (raise-amount 0.0)

             (tabset-name (if (eq name 'scroll-left)
                              (propertize (format "%s" (tabbar-current-tabset))
                                          'face '(:inherit tabbar-default
                                                           :height 1.3)
                                          'display '(raise 0.1)) "")))

        ;; This isn't pretty, but won't break existing code.
        ;; Perhaps other thing's gonna work, but that's what I
        ;; came with for now.
        ;; (run-with-timer 1
        ;;   1 (lambda ()
        ;;      ;; set to nil to force refresh without interfeering
        ;;      ;; with existing code.
        ;;      (setq tabbar-scroll-left-button-value nil)
        ;;      (setq tabbar-scroll-right-button-value nil)
        ;;      (setq tabbar-home-button-value nil)))

        (tabbar-set-template tabset nil)
        ;; Cache the display value of the enabled/disabled buttons in
        ;; variables `tabbar-NAME-button-value'.
        (set (intern (format "tabbar-%s-button-value" name))
             (cons
              (concat
               (propertize glyph
                           'tabbar-button name
                           'face (plist-merge
                                  '(:inherit tabbar-default)
                                  (plist-get (text-properties-at (- (length glyph) 1) glyph) 'face)
                                  `(:foreground ,(face-attribute 'font-lock-keyword-face :foreground nil))
                                  )
                           'display '(raise raise-amount)
                           ;; (list 'space :width (car tabbar-separator))
                           'mouse-face 'tabbar-button-highlight
                           'pointer 'hand
                           'local-map (tabbar-make-button-keymap name)
                           'help-echo 'tabbar-help-on-button)
               (unless (string-equal tabset-name "tabbar-tabsets-tabset") tabset-name))

              (concat
               (propertize glyph
                           'tabbar-button name
                           'face (plist-merge
                                  '(:inherit tabbar-default)
                                  (plist-get (text-properties-at 0 glyph) 'face))
                           'display '(raise raise-amount)
                           'mouse-face 'tabbar-button-highlight
                           'pointer 'hand
                           'local-map (tabbar-make-button-keymap name)
                           'help-echo 'tabbar-help-on-button)
               (unless (string-equal tabset-name "tabbar-tabsets-tabset") tabset-name)
               )))))

    (defadvice tabbar-line-format (after tabbar-button-cache-clearer 1 (tabset) activate)
      "Clear cached button values each time `tabbar-line-format' is called so tabbset name gets refreshed."
      (setq tabbar-scroll-left-button-value nil)
      (setq tabbar-scroll-right-button-value nil)
      (setq tabbar-home-button-value nil))

    (defun tabbar-buffer-tab-label (tab)
      "Return a label for TAB. That is, a string used to represent it on the tab bar. This was overriden to clean up unwanted chars."

      (let ((label (if tabbar--buffer-show-groups
                       (replace-regexp-in-string
                        "*" "" (format "%s" (tabbar-tab-tabset tab)))
                     (format "%s" (tabbar-tab-value tab)))))
        ;; Unless the tab bar auto scrolls to keep the selected tab
        ;; visible, shorten the tab label to keep as many tabs as possible
        ;; in the visible area of the tab bar.
        (if tabbar-auto-scroll-flag
            label
          (tabbar-shorten
           label (max 1 (/ (window-width)
                           (length (tabbar-view
                                    (tabbar-current-tabset)))))))))

    ;; Tabbar Groups Definition
    (defun tabbar-buffer-groups ()
      "Returns the name of the tab group names the current buffer belongs to.
      There are two groups: Emacs buffers (those whose name starts with '*', plus
      dired buffers), and the rest."
      (list (cond
             ((string-equal "*scratch*" (buffer-name)) "Scratch")
             ((string-equal "*Messages*" (buffer-name)) "*Messages*")
             ((string-equal "*" (substring (buffer-name) 0 1)) "emacs")
             ((string-equal " " (substring (buffer-name) 0 1)) "hidden")
             ((eq major-mode 'dired-mode) "emacs")
             ((eq projectile-mode t) (if (boundp projectile-project-name)
                                         (projectile-project-name)
                                       ("project")))
             (t "user"))))


    (defun hmz-tabbar-refresh-tabs ()
      (tabbar-mode 0)
      (setq tabbar-scroll-left-button-value nil)
      (setq tabbar-scroll-right-button-value nil)
      (setq tabbar-home-button-value nil)

      (hmz-tabbar-refresh-faces)

      (tabbar-mode 1))

    (unless (boundp 'after-load-theme-hook)
      (defvar after-load-theme-hook nil
        "Hook run after a color theme is loaded using `load-theme'.")
      (defadvice load-theme (after run-after-load-theme-hook activate)
        "Run `after-load-theme-hook'."
        (run-hooks 'after-load-theme-hook))
      )

    (add-hook 'after-load-theme-hook 'hmz-tabbar-refresh-tabs)
    (add-hook 'after-save-hook 'hmz-tabbar-refresh-tabs)
    (add-hook 'first-change-hook 'hmz-tabbar-refresh-tabs)
    ))
