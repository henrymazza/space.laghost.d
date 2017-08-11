;; -*- coding: utf-8; -*-
(defvar hmz-tabbar-packages
  '(
    tabbar
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defun hmz-tabbar/init-tabbar ()
  "Tabbar customizations"
  (use-package tabbar
    :defer t

    :init
    ;; init me!
    (tabbar-mode 1)

    :config
    ;; override so we can change default value instead of custom one
    (setq tabbar-separator (list 1.2))

    (set-face-attribute 'tabbar-default nil
                        :inherit 'header-line
                        :foreground 'unspecified
                        :background 'unspecified
                        :underline nil
                        :weight 'light
                        :box nil)

    (set-face-attribute 'tabbar-selected nil
                        :box nil
                        :inherit 'tabbar-default
                        :overline t
                        :foreground 'unspecified
                        :background 'unspecified
                        :weight 'normal)

    (set-face-attribute 'tabbar-selected-modified nil
                        :box nil
                        :inherit 'tabbar-selected
                        :overline t
                        :weight 'normal)

    (set-face-attribute 'tabbar-selected nil
                        :box nil
                        :inherit 'tabbar-default
                        :overline t
                        :weight 'normal)

    (set-face-attribute 'tabbar-highlight nil
                        :inherit 'tabbar-default
                        :underline nil
                        :overline t
                        :box nil)

    (set-face-attribute 'tabbar-modified nil
                        :box nil
                        :foreground 'unspecified
                        :background 'unspecified
                        :inherit 'tabbar-default)

    (set-face-attribute 'tabbar-unselected nil
                        :box nil
                        :inherit 'tabbar-default)

    (set-face-attribute 'tabbar-button nil
                        :height 1.5
                        :inherit 'tabbar-default)

    (add-to-list 'all-the-icons-icon-alist
                 '("\\.lua$" all-the-icons-wicon "moon-waning-crescent-3" :face all-the-icons-cyan))

    ;; safari like back and forward tabs
    (global-set-key [(control tab)] 'tabbar-forward-tab)
    (global-set-key [(control shift tab)] 'tabbar-backward-tab)

    ;; adding spaces
    (defun tabbar-buffer-tab-label (tab)
      "Return a label for TAB.
That is, a string used to represent it on the tab bar."

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


    (defsubst tabbar-line-tab (tab)
      "Return the display representation of tab TAB.
That is, a propertized string used as an `header-line-format' template
element.
Call `tabbar-tab-label-function' to obtain a label for TAB."
      (let
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

           (icon-face nil)
           )

        (setq icon-face (plist-get (text-properties-at 0 the-icon) 'face))

      (concat
       (propertize
        the-icon
        'face (with-eval-after-load 'org
                (org-combine-plists
                 (plist-get (text-properties-at 0 the-icon) 'face)
                 `(:background ,(tabbar-background-color))
                 (unless tab-is-active '(:foreground (face-attribute 'tabbar-default :foreground nil '(header-line default))))
                 ))
        'display (if tab-is-active '(raise 0.0) '(raise 0.0))
        'tabbar-tab tab
        'local-map (tabbar-make-tab-keymap tab)
        'help-echo 'tabbar-help-on-tab
        'mouse-face 'tabbar-highlight
        )
       (propertize
        (concat

         (if tabbar-tab-label-function
             (funcall tabbar-tab-label-function tab)
           tab))
        'tabbar-tab tab
        'local-map (tabbar-make-tab-keymap tab)
        'help-echo 'tabbar-help-on-tab
        'mouse-face 'tabbar-highlight
        'face tab-face
        'display '(raise 0.25)
        'pointer 'hand)
       tabbar-separator-value)))

    (defsubst tabbar-line-button (name)
      "Return the display representation of button NAME.
That is, a propertized string used as an `header-line-format' template
element."
      (let ((label (if tabbar-button-label-function
                       (funcall tabbar-button-label-function name)
                     (cons name name)))
            (glyph (cond ((eq name 'home) (concat " " (all-the-icons-wicon "alien" :face '(:inherit tabbar-default :height 1.2))))
                         ((eq name 'scroll-left) (all-the-icons-material "navigate_before"))
                         ((eq name 'scroll-right) (all-the-icons-material "navigate_next"))
                   (t "X")))
            (raise-amount 0.0)
            )

        (require 'org)
        ;; Cache the display value of the enabled/disabled buttons in
        ;; variables `tabbar-NAME-button-value'.
        (set (intern (format "tabbar-%s-button-value"  name))
             (cons
               (propertize glyph
                           'tabbar-button name
                           'face (with-eval-after-load 'org
                                   (org-combine-plists
                                    '(:inherit tabbar-default)
                                    (plist-get (text-properties-at (- (length glyph) 1) glyph) 'face)
                                    ))
                           'display '(raise 0.0 )
                           ;; (list 'space :width (car tabbar-separator))
                           'mouse-face 'tabbar-button-highlight
                           'pointer 'hand
                           'local-map (tabbar-make-button-keymap name)
                           'help-echo 'tabbar-help-on-button)


              (propertize glyph
                          'tabbar-button name
                          'face (org-combine-plists
                                 '(:inherit tabbar-default)
                                 (plist-get (text-properties-at 0 glyph) 'face))
                          'display '(raise 0.0)
                          'mouse-face 'tabbar-button-highlight
                          'pointer 'hand
                          'local-map (tabbar-make-button-keymap name)
                          'help-echo 'tabbar-help-on-button)
              ))))

    ;; set to nil to force refresh
    (setq tabbar-scroll-left-button-value nil)
    (setq tabbar-scroll-right-button-value nil)
    (setq tabbar-home-button-value nil)

    ;; Tabbar Groups Definition
    (defun my-tabbar-buffer-groups ()
      "Returns the name of the tab group names the current buffer belongs to.
      There are two groups: Emacs buffers (those whose name starts with '*', plus
      dired buffers), and the rest."
      (list (cond ((string-equal "*" (substring (buffer-name) 0 1)) "emacs")
                  ((string-equal " " (substring (buffer-name) 0 1)) "hidden")
                  ((eq major-mode 'dired-mode) "emacs")
                  ((eq projectile-mode t) (if (boundp projectile-project-name)
                                              (projectile-project-name)
                                            ("project")))
                  (t "user"))))

    (setq tabbar-buffer-groups-function 'my-tabbar-buffer-groups)
    ))
