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
     '(tabbar-default ((t (:height 1.0 :overline t :background "#2E3440" :weight thin :foreground "#AAAAAA" :family "San Francisco"))))
     '(tabbar-modified ((t (:inherit tabbar-default :foreground "spring green"))))
     '(tabbar-button ((t (:inherit tabbar-default))))
     '(tabbar-selected ((t (:inherit tabbar-default :overline t :foreground "white"))))

     '(tabbar-selected-modified ((t (:inherit tabbar-selected :foreground "spring green"))))

     '(tabbar-unselected ((t (:inherit tabbar-default )))))



    ;; adding spaces
    (defun tabbar-buffer-tab-label (tab)
      "Return a label for TAB.
That is, a string used to represent it on the tab bar."

      (let ((label
             (if tabbar--buffer-show-groups
                 (replace-regexp-in-string "*" ""
                  (format "%s"
                          (tabbar-tab-tabset tab)))
               (format "%s" (tabbar-tab-value tab))
               )))
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

      (setq jj "mehsdfkjalkdjflkasdjf")
      (concat
        (propertize
           (concat
            (all-the-icons-icon-for-file
             (replace-regexp-in-string "<.*>" "" (format "%s"(tabbar-tab-value tab)))
             )
            (if tabbar-tab-label-function
                (funcall tabbar-tab-label-function tab)
              tab))
           'tabbar-tab tab
           'local-map (tabbar-make-tab-keymap tab)
           'help-echo 'tabbar-help-on-tab
           'mouse-face 'tabbar-highlight
           'face (cond ((and (tabbar-selected-p tab (tabbar-current-tabset))
                             (tabbar-modified-p tab (tabbar-current-tabset)))
                        'tabbar-selected-modified)
                       ((tabbar-selected-p tab (tabbar-current-tabset))
                        'tabbar-selected)
                       ((tabbar-modified-p tab (tabbar-current-tabset))
                        'tabbar-modified)
                       (t 'tabbar-unselected))
           'display '(raise 0.1)
           'pointer 'hand)
        (put-text-property 1 3 '(:family "San Francisco") jj)
        jj
       tabbar-separator-value))



    (defsubst tabbar-line-button (name)
      "Return the display representation of button NAME.
That is, a propertized string used as an `header-line-format' template
element."
      (message "%s" name)
      (let ((label (if tabbar-button-label-function
                       (funcall tabbar-button-label-function name)
                     (cons name name))))
        ;; Cache the display value of the enabled/disabled buttons in
        ;; variables `tabbar-NAME-button-value'.
        (set (intern (format "tabbar-%s-button-value"  name))
             (cons
              (propertize
               (concat " "
                       (cond ((eq name 'home) (all-the-icons-wicon "alien"))
                             ((eq name 'scroll-left) (all-the-icons-wicon "fire"))
                             ((eq name 'scroll-right) (all-the-icons-wicon "hurricane"))
                             (t "X")) " ")
                          'tabbar-button name
                          'face `(:inherit 'tabbar-default :family ,(all-the-icons-wicon-family) :height 1.5 :foreground "orange")
                          'display '(raise 0.0)
                          'mouse-face 'tabbar-button-highlight
                          'pointer 'hand
                          'local-map (tabbar-make-button-keymap name)
                          'help-echo 'tabbar-help-on-button)
              (propertize (cdr label)
                          'face 'tabbar-button
                          'pointer 'arrow)))))



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
    ;;  (defun tab(projectile-project-rootobar-add-tab-disabled (tabset object &optional append_ignored)
    ;;    "Add to TABSET a tab with value OBJECT if there isn't one there yet.
    ;; If the tab is added, it is added at the beginning of the tab list,
    ;; unless the optional argument APPEND is non-nil, in which case it is
    ;; added at the end."
    ;;    (let ((tabs (tabbar-tabs tabset)))
    ;;      (if (tabbar-get-tab object tabset)
    ;;          tabs
    ;;        (let ((tab (tabbar-make-tab object tabset)))
    ;;          (tabbar-set-template tabset nil)
    ;;          ;;(set tabset tabs)
    ;;          (set tabset (sort (cons tab tabs)
    ;;                            (lambda (a b)
    ;;                              (string< (buffer-name (car a)) (buffer-name (car b)))
    ;;                              )))

    ;;          ))))

    ))
