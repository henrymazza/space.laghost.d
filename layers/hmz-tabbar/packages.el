(defvar hmz-tabbar-packages
  '(
    tabbar
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar hmz-tabbar-excluded-packages '()
  "List of packages to exclude.")

(defun hmz-tabbar/init-tabbar ()
  "Tabbar customizations"
  (use-package tabbar
    :defer t
    :init
    (tabbar-mode 1)

    (custom-set-variables
     '(tabbar-separator (quote (1.2))))

    (custom-set-faces
     '(tabbar-default ((t (:inherit header-line-format :height 1.0 :background "#2E3440" :weight thin :foreground "#AAAAAA" :family "San Francisco"))))
     '(tabbar-modified ((t (:inherit tabbar-default :foreground "SeaGreen"))))
     '(tabbar-button ((t (:inherit tabbar-default))))
     '(tabbar-selected ((t (:inherit tabbar-default :overline "white" :foreground "white"))))
     '(tabbar-highlight ((t (:inherit tabbar-default :foreground "deep sky blue" :underline nil :overline t))))

     '(tabbar-selected-modified ((t (:inherit tabbar-selected :foreground "Spring Green"))))

     '(tabbar-unselected ((t (:inherit tabbar-default )))))

    (add-to-list 'all-the-icons-icon-alist
                 '("\\.lua$" all-the-icons-wicon "moon-waning-crescent-5" :face all-the-icons-cyan))

    :config

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
                    (tab-is-active (tabbar-selected-p tab (tabbar-current-tabset))))

      (setq icon-face (plist-get (text-properties-at 0 the-icon) 'face))

      (require 'org)
      (concat
       (propertize
        the-icon
        'face (with-eval-after-load 'org
                (org-combine-plists
                 icon-face (if tab-is-active
                               '(:height 1.2 :overline t)
                             '(:height 1.2 :foreground "#81A1C1"))))
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
        'display '(raise 0.2)
        'pointer 'hand)
       tabbar-separator-value)))

    (defsubst tabbar-line-button (name)
      "Return the display representation of button NAME.
That is, a propertized string used as an `header-line-format' template
element."
      (let ((label (if tabbar-button-label-function
                       (funcall tabbar-button-label-function name)
                     (cons name name)))
            (glyph (cond ((eq name 'home) (all-the-icons-wicon "alien" :face '(:height 1.2) :display (list 'space :width (car tabbar-separator))))
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
              (concat (when (eq name 'home) " ")
                      (propertize glyph
                          'tabbar-button name
                          'face (with-eval-after-load 'org
                                  (org-combine-plists
                                   '(:inherit tabbar-default)
                                   (plist-get (text-properties-at 0 glyph) 'face)
                                   '(:foreground "orange" )))
                          'display '(raise 0.0)
                          'mouse-face 'tabbar-button-highlight
                          'pointer 'hand
                          'local-map (tabbar-make-button-keymap name)
                          'help-echo 'tabbar-help-on-button))

              (concat (when (eq name 'home) " ")
                      (propertize glyph
                          'tabbar-button name
                          'face (org-combine-plists
                                 '(:inherit tabbar-default)
                                 (plist-get (text-properties-at 0 glyph) 'face)
                                 '(:foreground "#AAAAAA"))
                          'display '(raise 0.0)
                          'mouse-face 'tabbar-button-highlight
                          'pointer 'hand
                          'local-map (tabbar-make-button-keymap name)
                          'help-echo 'tabbar-help-on-button))
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
