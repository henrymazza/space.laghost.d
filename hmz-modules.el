(setq use-package-verbose 'debug)

(add-to-list 'load-path (expand-file-name "~/.spacemacs.develop.d/straight/repos/all-the-icons"))

(use-package all-the-icons
  :straight t
  :disabled
  :catch t
  :demand t)

;; * Tabbar
;; ;; (use-package tabbar
;; ;;     :straight t
;; ;;     :disabled
;; ;;     :demand t
;; ;;     :catch t
;; ;;     :bind ("s-b" . tabbar-mode)
;; ;;     :after (helm-lib all-the-icons)
;; ;;     :config
;; ;;       (defun ido-switch-tab-group ()
;; ;;         "Switch tab groups using ido."
;; ;;       (interactive)
;; ;;         (let* ((tab-buffer-list (mapcar
;; ;;                 #'(lambda (b)
;; ;;                     (with-current-buffer b
;; ;;                       (list (current-buffer)
;; ;;                             (buffer-name)
;; ;;                             (funcall tabbar-buffer-groups-function) )))
;; ;;                     (funcall tabbar-buffer-list-function)))
;; ;;             (groups (delete-dups
;; ;;               (mapcar #'(lambda (group)
;; ;;                 (car (car (cdr (cdr group))))) tab-buffer-list)))
;; ;;             (group-name (ido-completing-read "Groups: " groups)) )
;; ;;           (catch 'done
;; ;;             (mapc
;; ;;               #'(lambda (group)
;; ;;                 (when (equal group-name (car (car (cdr (cdr group)))))
;; ;;                   (throw 'done (switch-to-buffer (car (cdr group))))))
;; ;;               tab-buffer-list) )))

;; ;;       (defun switch-tab-group (group-name)
;; ;;         "Switch to a specific tab group."
;; ;;         (let ((tab-buffer-list (mapcar
;; ;;                 #'(lambda (b)
;; ;;                     (with-current-buffer b
;; ;;                       (list (current-buffer)
;; ;;                             (buffer-name)
;; ;;                             (funcall tabbar-buffer-groups-function) )))
;; ;;                     (funcall tabbar-buffer-list-function))))
;; ;;           (catch 'done
;; ;;             (mapc
;; ;;               #'(lambda (group)
;; ;;                 (when (equal group-name (format "%s" (car (car (cdr (cdr group))))))
;; ;;                   (throw 'done (switch-to-buffer (car (cdr group))))))
;; ;;               tab-buffer-list) )))

;; ;;       (defun switch-to-tab-group-n ()
;; ;;       "Switch to a predefined existing tab group named `N`."
;; ;;       (interactive)
;; ;;         (switch-tab-group "N"))

;; ;;       (defun switch-to-tab-group-a ()
;; ;;       "Switch to a predefined existing tab group named `A`."
;; ;;       (interactive)
;; ;;         (switch-tab-group "A"))

;; ;;       (global-set-key [(control ";")] 'switch-tab-group)

;; ;;       (define-key evil-normal-state-map (kbd "C-;") 'ido-switch-tab-group)

;; ;;     ;; END SWITCH BUFFER

;; ;;     ;; safari like back and forward tabs
;; ;;     (global-set-key [(control shift tab)] 'tabbar-backward-tab)
;; ;;     (global-set-key [(control tab)] 'tabbar-forward-tab)

;; ;;     ;; make tab and shift tab move between MRU buffers
;; ;;     (define-key evil-normal-state-map (kbd "<S-tab>") 'previous-buffer)
;; ;;     (define-key evil-normal-state-map (kbd "<tab>") 'next-buffer)

;; ;;     ;; cycle groups
;; ;;     (define-key evil-normal-state-map (kbd "s-[") 'tabbar-backward-group)
;; ;;     (define-key evil-normal-state-map (kbd "s-]") 'tabbar-forward-group)
;; ;;     (define-key evil-normal-state-map (kbd "{") 'tabbar-backward-group)
;; ;;     (define-key evil-normal-state-map (kbd "}") 'tabbar-forward-group)

;; ;;     ;; Sets command + 1 up to command + 0 as jump to group

;; ;;     (seq-do (lambda (e)
;; ;;               (global-set-key (kbd (concat "s-" (number-to-string e))) 'hmz-tabbar/goto-nth-group)
;; ;;               )
;; ;;             (number-sequence 1 9))

;; ;;     (defun hmz-tabbar/goto-nth-group ()
;; ;;       (interactive)
;; ;;       (let* ((vect (recent-keys))
;; ;;              (last-keystroke (aref vect (1- (length vect))))
;; ;;              (invoked-with-keys (key-description (vector last-keystroke)))
;; ;;              ;; start with zero
;; ;;              (integer-argument (- (aref invoked-with-keys (1- (length invoked-with-keys))) 49))
;; ;;              (new-group-tab (nth integer-argument (tabbar-tabs (tabbar-get-tabsets-tabset)))))

;; ;;         (when new-group-tab
;; ;;           (tabbar-click-on-tab new-group-tab))))

;; ;;     ;; map mouse wheel events on header line
;; ;;     (global-set-key [header-line triple-wheel-right] 'tabbar-press-scroll-right)
;; ;;     (global-set-key [header-line double-wheel-right] 'tabbar-press-scroll-right)
;; ;;     (global-set-key [header-line wheel-right] nil)
;; ;;     (global-set-key [header-line triple-wheel-left] 'tabbar-press-scroll-left)
;; ;;     (global-set-key [header-line double-wheel-left] 'tabbar-press-scroll-left)
;; ;;     (global-set-key [header-line wheel-left] nil)

;; ;;     (setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . 30)))
;; ;;     (setq mouse-wheel-progressive-speed nil)

;; ;;     :config
;; ;;     (defun plist-merge (&rest plists)
;; ;;       (if plists
;; ;;           (let ((result (copy-sequence (car plists))))
;; ;;             (while (setq plists (cdr plists))
;; ;;               (let ((plist (car plists)))
;; ;;                 (while plist
;; ;;                   (setq result (plist-put result (car plist) (car (cdr plist)))
;; ;;                         plist (cdr (cdr plist))))))
;; ;;             result)
;; ;;         nil))


;; ;;     (defun hmz-lighten-if-too-dark (icon-face)
;; ;;       "Lighen color if (TODO) it's considered too dark."
;; ;;       (color-lighten-name (face-attribute (plist-get icon-face :inherit) :foreground nil 'default) 2))

;; ;;     ;; override so we can change default value instead of custom one
;; ;;     (setq tabbar-separator (list 1.2))

;; ;;     (defun hmz-tabbar-refresh-faces ()
;; ;;       "Refreshes faces dependent of theme faces."

;; ;;       (set-face-attribute 'tabbar-default nil
;; ;;                           :inherit 'header-line
;; ;;                           :foreground 'unspecified
;; ;;                           :background 'unspecified
;; ;;                           :underline nil
;; ;;                           :weight 'light
;; ;;                           :box nil)

;; ;;       (set-face-attribute 'tabbar-selected-modified nil
;; ;;                           :box nil
;; ;;                           :foreground (face-attribute 'font-lock-keyword-face :foreground)
;; ;;                           :inherit 'tabbar-selected
;; ;;                           :overline nil
;; ;;                           :weight 'normal)

;; ;;       (set-face-attribute 'tabbar-selected nil
;; ;;                           :box nil
;; ;;                           :foreground 'unspecified
;; ;;                           :background (face-attribute 'default :background)
;; ;;                           :inherit 'tabbar-default
;; ;;                           :underline (face-attribute 'font-lock-comment-face :background)
;; ;;                           :overline nil
;; ;;                           :weight 'normal)

;; ;;       (set-face-attribute 'tabbar-highlight nil
;; ;;                           :inherit 'tabbar-default
;; ;;                           :foreground (face-attribute
;; ;;                                        'font-lock-keyword-face :foreground)
;; ;;                           :underline nil
;; ;;                           :overline nil
;; ;;                           :box nil)

;; ;;       (set-face-attribute 'tabbar-modified nil
;; ;;                           :box nil
;; ;;                           :foreground (face-attribute 'font-lock-keyword-face :foreground)
;; ;;                           :background 'unspecified
;; ;;                           :weight 'normal
;; ;;                           :inherit 'tabbar-default)

;; ;;       (set-face-attribute 'tabbar-unselected nil
;; ;;                           :foreground 'unspecified
;; ;;                           :background 'unspecified
;; ;;                           :box nil
;; ;;                           :underline 'unspecified
;; ;;                           :inherit 'tabbar-default)

;; ;;       (set-face-attribute 'tabbar-button nil
;; ;;                           :height 2.0
;; ;;                           :inherit 'tabbar-default)

;; ;;       (defface tabbar-icon-unselected '((t
;; ;;                                          :foreground "#555555"
;; ;;                                          :box nil
;; ;;                                          :inherit 'tabbar-default
;; ;;                                          ))
;; ;;         "Unselected tab's icon foreground color."
;; ;;         :group 'tabbar)

;; ;;       ;; set colors through here so it can be dinamically redone
;; ;;       (set-face-attribute 'tabbar-icon-unselected nil
;; ;;                           :foreground (face-attribute 'font-lock-comment-face :foreground)
;; ;;                           :background 'unspecified
;; ;;                           :underline (face-attribute 'font-lock-variable-name-face :foreground)))

;; ;;     (hmz-tabbar-refresh-faces)

;; ;;     (use-package all-the-icons
;; ;;       :config
;; ;;       (add-to-list 'all-the-icons-icon-alist
;; ;;                    '("\\.lua$" all-the-icons-wicon "moon-waning-crescent-3" :face all-the-icons-cyan)))

;; ;;     (defun tabbar-buffer-help-on-tab (tab)
;; ;;       "Return the help string shown when mouse is onto TAB. This function was overriden to show more useful information."
;; ;;       (if tabbar--buffer-show-groups
;; ;;           (let* ((tabset (tabbar-tab-tabset tab))
;; ;;                  (tab (tabbar-selected-tab tabset)))
;; ;;             (format "mouse-1: switch to buffer %S in group [%s]"
;; ;;                     (buffer-name (tabbar-tab-value tab)) tabset))
;; ;;         (propertize (format "%s"
;; ;;                 (file-relative-name
;; ;;                  (projectile-expand-root (buffer-file-name (tabbar-tab-value tab)))
;; ;;                  (projectile-project-root))) 'face '(:height 1.2 :weight light))))

;; ;;     ;; Override function that writes tab names so we can insert
;; ;;     ;; an stylized text with icons
;; ;;     (defsubst tabbar-line-tab (tab)
      "Return the display representation of tab TAB.;; ;;
;; ;; That is, a propertized string used as an `header-line-format' template
;; ;; element.
;; ;; Call `tabbar-tab-label-function' to obtain a label for TAB."

;; ;;       (let*
;; ;;           ((tab-face (cond ((and (tabbar-selected-p tab (tabbar-current-tabset))
;; ;;                                  (tabbar-modified-p tab (tabbar-current-tabset)))
;; ;;                             'tabbar-selected-modified)
;; ;;                            ((tabbar-selected-p tab (tabbar-current-tabset))
;; ;;                             'tabbar-selected)
;; ;;                            ((tabbar-modified-p tab (tabbar-current-tabset))
;; ;;                             'tabbar-modified)
;; ;;                            (t 'tabbar-unselected)))

;; ;;            (the-icon (all-the-icons-icon-for-file
;; ;;                       (replace-regexp-in-string "<.*>" "" (format "%s"(tabbar-tab-value tab)))))

;; ;;            (tab-is-active (tabbar-selected-p tab (tabbar-current-tabset)))

;; ;;            (icon-face (plist-get (text-properties-at 0 the-icon) 'face)))

;; ;;         (concat
;; ;;          (propertize
;; ;;                      " "
;; ;;            (if tabbar-tab-label-function
;; ;;                (funcall tabbar-tab-label-function tab)
;; ;;              tab) " "
;; ;;           'tabbar-tab tab
;; ;;           'local-map (tabbar-make-tab-keymap tab)
;; ;;           'help-echo 'tabbar-help-on-tab
;; ;;           'mouse-face 'tabbar-highlight
;; ;;           'face tab-face
;; ;;           'display `(raise  0.0);;,(symbol-value 'hmz-tabbar-raise-text))
;; ;;           'pointer 'hand)
;; ;;          (propertize
;; ;;           the-icon
;; ;;           'face (plist-merge
;; ;;                  ;; (get icon-face 'foreground)
;; ;;                  (plist-get (text-properties-at 0 the-icon) 'face)
;; ;;                  `(:background ,(face-attribute 'tabbar-default :background nil 'default))
;; ;;                  (if tab-is-active
;; ;;                      `(:overline nil;; ,(face-attribute tab-face :foreground nil 'default)
;; ;;                                  :foreground ,(hmz-lighten-if-too-dark icon-face)
;; ;;                                  :background ,(face-attribute 'tabbar-selected :background nil 'default))
;; ;;                    `(:foreground ,(face-attribute 'tabbar-icon-unselected :foreground nil 'default)))
;; ;;                  )
;; ;;           'display (if tab-is-active '(raise 0.0) '(raise 0.0))
;; ;;           'tabbar-tab tab
;; ;;           'local-map (tabbar-make-tab-keymap tab)
;; ;;           'help-echo 'tabbar-help-on-tab
;; ;;           'mouse-face 'tabbar-highlight)

;; ;;          (propertize
;; ;;           (concat
;; ;;            " "
;; ;;            (if tabbar-tab-label-function
;; ;;                (funcall tabbar-tab-label-function tab) tab) " ")
;; ;;           'tabbar-tab tab
;; ;;           'local-map (tabbar-make-tab-keymap tab)
;; ;;           'help-echo 'tabbar-help-on-tab
;; ;;           'mouse-face 'tabbar-highlight
;; ;;           'face tab-face
;; ;;           'display `(raise 0.2) ;;,(symbol-value 'hmz-tabbar-raise-text))
;; ;;           'pointer 'hand)
;; ;;          tabbar-separator-value)))

;; ;;     (defsubst tabbar-line-button (name)
;; ;;       "Return the display representation of button NAME.
;; ;; That is, a propertized string used as an `header-line-format' template
;; ;; element."
;; ;;       (position
;; ;;        (tabbar-current-tabset)
;; ;;        (mapcar #'cdr
;; ;;                (tabbar-tabs (tabbar-get-tabsets-tabset))))

;; ;;       (let* ((label (if tabbar-button-label-function
;; ;;                         (funcall tabbar-button-label-function name)
;; ;;                       (cons name name)))

;; ;;              (glyph
;; ;;               (cond ((eq name 'home)
;; ;;                      (concat " "
;; ;;                              (all-the-icons-wicon
;; ;;                               (nth

;; ;;                                ;; Use current group to define icon
;; ;;                                (or (position
;; ;;                                     (tabbar-current-tabset)
;; ;;                                     (mapcar #'cdr
;; ;;                                             (tabbar-tabs (tabbar-get-tabsets-tabset)))
;; ;;                                     ) 7)

;; ;;                                ;; Use current window number to define the icon
;; ;;                                ;; (if winum-mode (winum-get-number) 1)

;; ;;                                    '("alien" "fire" "lightning" "barometer" "meteor" "earthquake" "snowflake-cold" "fire" "raindrop" "solar-eclipse" "night-clear" "raindrops" "sprinkle"))
;; ;;                               :face '(:inherit tabbar-default :height 1.2))))

;; ;;                           ((eq name 'scroll-left) (all-the-icons-material "chevron_left"))
;; ;;                           ((eq name 'scroll-right) (all-the-icons-material "chevron_right"))
;; ;;                           (t "X")))

;; ;;              (raise-amount 0.0)

;; ;;              (tabset-name (if (eq name 'scroll-left)
;; ;;                               (propertize (format "%s" (tabbar-current-tabset))
;; ;;                                           'face '(:inherit tabbar-default
;; ;;                                                            :height 1.3)
;; ;;                                           'display '(raise 0.1)) "")))

;; ;;         (tabbar-set-template tabset nil)
;; ;;         ;; Cache the display value of the enabled/disabled buttons in
;; ;;         ;; variables `tabbar-NAME-button-value'.
;; ;;         (set (intern (format "tabbar-%s-button-value" name))
;; ;;              (cons
;; ;;               (concat
;; ;;                (propertize glyph
;; ;;                            'tabbar-button name
;; ;;                            'face (plist-merge
;; ;;                                   '(:inherit tabbar-default)
;; ;;                                   (plist-get (text-properties-at (- (length glyph) 1) glyph) 'face)
;; ;;                                   `(:foreground ,(face-attribute 'font-lock-keyword-face :foreground nil))
;; ;;                                   )
;; ;;                            'display '(raise raise-amount)
;; ;;                            ;; (list 'space :width (car tabbar-separator))
;; ;;                            'mouse-face 'tabbar-button-highlight
;; ;;                            'pointer 'hand
;; ;;                            'local-map (tabbar-make-button-keymap name)
;; ;;                            'help-echo 'tabbar-help-on-button)
;; ;;                (unless (string-equal tabset-name "tabbar-tabsets-tabset") tabset-name))

;; ;;               (concat
;; ;;                (propertize glyph
;; ;;                            'tabbar-button name
;; ;;                            'face (plist-merge
;; ;;                                   '(:inherit tabbar-default)
;; ;;                                   (plist-get (text-properties-at 0 glyph) 'face))
;; ;;                            'display '(raise raise-amount)
;; ;;                            'mouse-face 'tabbar-button-highlight
;; ;;                            'pointer 'hand
;; ;;                            'local-map (tabbar-make-button-keymap name)
;; ;;                            'help-echo 'tabbar-help-on-button)
;; ;;                (unless (string-equal tabset-name "tabbar-tabsets-tabset") tabset-name)
;; ;;                )))))

;; ;;     (defadvice tabbar-line-format (after tabbar-button-cache-clearer 1 (tabset) activate)
;; ;;       "Clear cached button values each time `tabbar-line-format' is called
;; ;;        so tabbset name gets refreshed."
;; ;;       (setq tabbar-scroll-left-button-value nil)
;; ;;       (setq tabbar-scroll-right-button-value nil)
;; ;;       (setq tabbar-home-button-value nil))

;; ;;     (defun tabbar-buffer-tab-label (tab)
;; ;;       "Return a label for TAB. That is, a string used to represent it on the
;; ;;        tab bar. This was overriden to clean up unwanted chars."

;; ;;       (let ((label (if tabbar--buffer-show-groups
;; ;;                        (replace-regexp-in-string
;; ;;                         "*" "" (format "%s" (tabbar-tab-tabset tab)))
;; ;;                      (format "%s" (tabbar-tab-value tab)))))
;; ;;         ;; Unless the tab bar auto scrolls to keep the selected tab
;; ;;         ;; visible, shorten the tab label to keep as many tabs as possible
;; ;;         ;; in the visible area of the tab bar.
;; ;;         (if tabbar-auto-scroll-flag
;; ;;             label
;; ;;           (tabbar-shorten
;; ;;            label (max 1 (/ (window-width)
;; ;;                            (length (tabbar-view
;; ;;                                     (tabbar-current-tabset)))))))))

;; ;;     (defun advice-unadvice (sym)
;; ;;       "Remove all advices from symbol SYM."
;; ;;       (interactive "Function symbol: ")
;; ;;       (advice-mapc (lambda (advice _props) (advice-remove sym advice)) sym))

;; ;;     (defun my-make-throttler-3 ()
;; ;;       (lexical-let ((last-time (+ 10 (float-time) ))
;; ;;                     (last-args 'dummy)
;; ;;                     (last-val ()))
;; ;;         (lambda (&rest args)
;; ;;           (if (and (< 10 (- (float-time) last-time))
;; ;;                    (equal args last-args))
;; ;;               last-val
;; ;;             (setq last-time (float-time))
;; ;;             (setq last-args args)
;; ;;             (setq last-val (apply args))))))

;; ;;     (advice-unadvice 'tabbar-buffer-update-groups)
;; ;;     (advice-add 'tabbar-buffer-update-groups :around (my-make-throttler-3))

;; ;;     (defun tabbar-buffer-update-groups ()
;; ;;       "Update tab sets from groups of existing buffers.
;; ;;   Return the the first group where the current buffer is."
;; ;;       ;; (message "update groups")
;; ;;       (let ((bl (sort
;; ;;                  (mapcar
;; ;;                   ;; for each buffer, create list: buffer, buffer name, groups-list
;; ;;                   ;; sort on buffer name; store to bl (buffer list)
;; ;;                   #'(lambda (b)
;; ;;                       (with-current-buffer b
;; ;;                         (list (current-buffer)
;; ;;                                 (format "%10s" (nth 0 (nth 5 (file-attributes (buffer-file-name )))))
;; ;;                               ;; (format "%10d" (buffer-chars-modified-tick))
;; ;;                               (if tabbar-buffer-groups-function
;; ;;                                   (funcall tabbar-buffer-groups-function)
;; ;;                                 '("Common")))))
;; ;;                   (and tabbar-buffer-list-function
;; ;;                        (funcall tabbar-buffer-list-function)))
;; ;;                  #'(lambda (e1 e2)
;; ;;                      (string-lessp (nth 1 e1) (nth 1 e2))))))
;; ;;         ;; If the cache has changed, update the tab sets.
;; ;;         (unless (equal bl tabbar--buffers)
;; ;;           ;; Add new buffers, or update changed ones.
;; ;;           (dolist (e bl) ;; loop through buffer list
;; ;;             (dolist (g (nth 2 e)) ;; for each member of groups-list for current buffer
;; ;;               (let ((tabset (tabbar-get-tabset g))) ;; get group from group name
;; ;;                 (if tabset ;; if group exists
;; ;;                     ;; check if current buffer is same as any cached buffer
;; ;;                     ;; (search buffer list for matching buffer)
;; ;;                     (unless (equal e (assq (car e) tabbar--buffers)) ;; if not,...
;; ;;                       ;; This is a new buffer, or a previously existing
;; ;;                       ;; buffer that has been renamed, or moved to another
;; ;;                       ;; group.  Update the tab set, and the display.
;; ;;                       (tabbar-add-tab tabset (car e) t) ;; add to end of tabset
;; ;;                       (tabbar-set-template tabset nil))
;; ;;                   ;;if tabset doesn't exist, make a new tabset with this buffer
;; ;;                   (tabbar-make-tabset g (car e))))))
;; ;;           ;; Remove tabs for buffers not found in cache or moved to other
;; ;;           ;; groups, and remove empty tabsets.
;; ;;           (mapc 'tabbar-delete-tabset ;; delete each tabset named in following list:
;; ;;                 (tabbar-map-tabsets ;; apply following function to each tabset:
;; ;;                  #'(lambda (tabset)
;; ;;                      (dolist (tab (tabbar-tabs tabset)) ;; for each tab in tabset
;; ;;                        (let ((e (assq (tabbar-tab-value tab) bl))) ;; get buffer
;; ;;                          (or (and e (memq tabset ;; skip if buffer exists and tabset is a member of groups-list for this buffer
;; ;;                                           (mapcar 'tabbar-get-tabset
;; ;;                                                   (nth 2 e))))
;; ;;                              (tabbar-delete-tab tab)))) ;; else remove tab from this set
;; ;;                      ;; Return empty tab sets
;; ;;                      (unless (tabbar-tabs tabset)
;; ;;                        tabset)))) ;; return list of tabsets, replacing non-empties with nil
;; ;;           ;; NOTE: it looks like tabbar--buffers is getting nil'ed somewhre,
;; ;;           ;; using an alternative cache.
;; ;;           ;; The new cache becomes the current one.
;; ;;            (setq tabbar--buffers bl)

;; ;;           ))
;; ;;       ;; Return the first group the current buffer belongs to.
;; ;;       (car (nth 2 (assq (current-buffer) tabbar--buffers))))

;; ;;     ;; Tabbar Groups Definition
;; ;;     (defun tabbar-buffer-groups ()
;; ;;       "Returns the name of the tab group names the current buffer belongs to.
;; ;;       There are two groups: Emacs buffers (those whose name starts with '*', plus
;; ;;       dired buffers), and the rest."
;; ;;       (list (if (member (buffer-name)
;; ;;                         (helm-skip-entries
;; ;;                          (mapcar #'buffer-name (buffer-list))
;; ;;                          (append '("\\`[:\\*]\\(Back\\|Help\\)")
;; ;;                                  helm-boring-buffer-regexp-list)
;; ;;                          helm-white-buffer-regexp-list))
;; ;;                 (cond
;; ;;                  ((file-remote-p default-directory)
;; ;;                   (string-join
;; ;;                    `( ,(file-remote-p default-directory 'user)
;; ;;                       ,(file-remote-p default-directory 'host))
;; ;;                    "@")
;; ;;                   )

;; ;;                  ((string-match-p "*" (buffer-name))
;; ;;                   (if (or (get-buffer-process (current-buffer))
;; ;;                           (eq major-mode 'eshell-mode))
;; ;;                       "proc"
;; ;;                     "limbo"))
;; ;;                  ((eq major-mode 'dired-mode) "dired")
;; ;;                  ((string-match-p "magit" (symbol-name major-mode))
;; ;;                   "magit")
;; ;;                  ((projectile-project-p) (projectile-project-name))
;; ;;                  ((buffer-file-name) "other")
;; ;;                  (t "limbo"))
;; ;;               "limbo")))

;; ;;     (defun hmz-tabbar-refresh-tabs ()
;; ;;       (if tabbar-mode
;; ;;           (progn(tabbar-mode 0)
;; ;;                 (setq tabbar-scroll-left-button-value nil)
;; ;;                 (setq tabbar-scroll-right-button-value nil)
;; ;;                 (setq tabbar-home-button-value nil)

;; ;;                 (hmz-tabbar-refresh-faces)

;; ;;                 (tabbar-mode 1))))

;; ;;     (unless (boundp 'after-load-theme-hook)
;; ;;       (defvar after-load-theme-hook nil
;; ;;         "Hook run after a color theme is loaded using `load-theme'.")
;; ;;       (defadvice load-theme (after run-after-load-theme-hook activate)
;; ;;        "Run `after-load-theme-hook'."
;; ;;         (run-hooks 'after-load-theme-hook)))

;; ;;     (add-hook 'after-load-theme-hook 'hmz-tabbar-refresh-tabs)
;; ;;     (add-hook 'after-save-hook 'hmz-tabbar-refresh-tabs)
;; ;;     (add-hook 'first-change-hook 'hmz-tabbar-refresh-tabs)

;; ;;     ;; init me!
;; ;;   (tabbar-mode 1)
;; ;;   ;; redefine tabbar-add-tab so that it alphabetizes / sorts the tabs
;; ;;   ;; TODO: better treat non-file buffers in sort
;; ;;   (defun tabbar-add-tab (tabset object &optional append)
;; ;;     "Add to TABSET a tab with value OBJECT if there isn't one there yet.
;; ;;   If the tab is added, it is added at the beginning of the tab list,
;; ;;   unless the optional argument APPEND is non-nil, in which case it is
;; ;;   added at the end."
;; ;;     (let ((tabs (tabbar-tabs tabset)))
;; ;;       (if (tabbar-get-tab object tabset)
;; ;;           tabs
;; ;;         (let* (
;; ;;             (tab (tabbar-make-tab object tabset))
;; ;;             (tentative-new-tabset
;; ;;               (if append
;; ;;                 (append tabs (list tab))
;; ;;                 (cons tab tabs)))
;; ;;             (new-tabset
;; ;;               (sort
;; ;;                 tentative-new-tabset
;; ;;                 #'(lambda (e1 e2)
;; ;;                     (setq file1 (buffer-local-value 'buffer-file-name (get-buffer (car e1)))
;; ;;                           file2 (buffer-local-value 'buffer-file-name (get-buffer (car e2))))
;; ;;                     (if (and file1 file2)
;; ;;                       (not (time-less-p
;; ;;                             (file-attribute-modification-time
;; ;;                              (file-attributes (expand-file-name file1)))
;; ;;                             (file-attribute-modification-time

;; ;;                              (file-attributes (expand-file-name file2)))
;; ;;                             ))
;; ;;                       t)

;; ;;                     ))))
;; ;;           (tabbar-set-template tabset nil)
;; ;;           (set tabset new-tabset))))))



;; * Here =hmz-misc= packages
(use-package indicators
  :straight t
  :disabled
  :config
  (add-hook 'prog-mode
            (lambda ()
              (ind-create-indicator
               'point
               :managed t))))

(use-package magithub
  :straight t
  :disabled
  :after magit
  :catch t
  :config
  (magithub-feature-autoinject t)
  (setq magithub-clone-default-directory "~/github"))

(use-package magit-popup
  :straight t
  :demand t)

(use-package git-link
  :straight t
  :after magit)

(use-package forge
  :straight t
  :after magit)

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

(use-package evil-magit
  :straight t
  :config (evil-magit-init))

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
  :after dash
  :straight (outshine :type git :host github :repo "alphapapa/outshine")
  :config
  (defvar outline-minor-mode-prefix "\M-#")
  (add-hook 'prog-mode-hook 'outshine-mode)
  )

(use-package helm-org-rifle
  :straight t)

(use-package org-super-links
  :straight (org-super-links :type git :host github :repo "toshism/org-super-links")
  :after (org helm-org-rifle)
  :bind (("C-c s s" . sl-link)
     ("C-c s l" . sl-store-link)
     ("C-c s C-l" . sl-insert-link)))

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

  (doom-modeline-mode 1))

(use-package yascroll
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

(use-package which-key-posframe
  :straight t
  :load-path "path/to/which-key-posframe.el"
  :init
  (setq which-key-posframe-poshandler 'posframe-poshandler-window-top-center)
  :config
  (which-key-posframe-mode))

(use-package ivy-posframe
  :straight t
  :disabled
  :init
  ;; display at `ivy-posframe-style'
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
  (ivy-posframe-mode 1)
  )

(use-package company-posframe
  :straight t
  :config
  (company-posframe-mode))

(use-package undohist
  :straight t
  :demand
  :config
  (undohist-initialize))

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

(use-package dired-sidebar
  :straight t
  :commands (dired-sidebar-toggle-sidebar))

(use-package centaur-tabs
    :straight t
    ;; :defer t
    ;; only load if hmz-tabbar isn't config's part
    :init
    (setq centaur-tabs-set-icons t)
    (setq centaur-tabs-plain-icons nil)
    (setq centaur-tabs-gray-out-icons 'buffer)
    (setq centaur-tabs-gray-out-icons nil)
    (setq centaur-tabs-set-bar 'over)
    (setq centaur-tabs-set-bar 'under)
    (setq centaur-tabs-set-bar 'under)
    (setq centaur-tabs-set-close-button nil)
    (setq centaur-tabs-set-modified-marker t)
    (setq centaur-tabs--buffer-show-groups nil)
    (setq centaur-tabs-cycle-scope 'tabs)
    (setq centaur-tabs-show-navigation-buttons nil)
    (setq centaur-tabs-show-navigation-buttons t)
    (setq centaur-tabs-adjust-buffer-order t)
    (setq centaur-tabs-background-color "black")
    (setq centaur-tabs-plain-icons nil)
    (setq centaur-tabs-set-icons t)
    (setq centaur-tabs-set-left-close-button nil)
    (setq centaur-tabs-modified-marker "#")

    :config
    (centaur-tabs-mode 1)
    ;; Safari like key-bindings
    (global-set-key [(control shift tab)] 'centaur-tabs-backward)
    (global-set-key [(control tab)] 'centaur-tabs-forward))

(use-package direx
  :straight t
  :disabled
  :init)

(use-package persp-mode
  :straight t
  :demand t
  :after projectile
  :custom
  (persp-auto-save-num-of-backups 10)
  (persp-autokill-buffer-on-remove 'kill-weak)
  (persp-interactive-completion-system 'ido)
  (persp-keymap-prefix "")
  (persp-nil-name "nil")

  :config
  (persp-def-auto-persp "dotfiles"
                        :mode 'prog-mode)

  (persp-def-auto-persp "ruby"
                        :buffer-name "\\.rb")

  (persp-def-auto-persp "elisp"
                        :buffer-name "\\.el")

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

(use-package persp-mode-projectile-bridge
  :straight t
  :demand t
  :after (projectile persp-mode)
  :init
  (add-hook 'persp-mode-projectile-bridge-mode-hook
            #'(lambda ()
                (if persp-mode-projectile-bridge-mode
                    (persp-mode-projectile-bridge-find-perspectives-for-all-buffers)
                  (persp-mode-projectile-bridge-kill-perspectives))))

  :config
  (persp-mode-projectile-bridge-mode 1))

(use-package sublimity
  :straight t
  :init
  (require 'sublimity)
  (require 'sublimity-scroll)
  (require 'sublimity-attractive)
  (setq sublimity-attractive-centering-width 110)
  (sublimity-mode t))

(use-package tempbuf
    :straight t
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

(use-package rspec-simple
  :straight (rspec-simple :type git :host github :repo "code-mancers/rspec-simple"))

(use-package amx
  :straight t
  :demand t
  :catch t
  ;; :disabled
  :init
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

  (progn
    (setq-default amx-history-length 32
                  amx-save-file (concat spacemacs-cache-directory
                                        ".amx-items"))
    ;; define the key binding at the very end in order to allow the user
    ;; to o
    (add-hook 'emacs-startup-hook
              (lambda () (spacemacs/set-leader-keys
                           dotspacemacs-emacs-command-key 'spacemacs/amx)))
    (spacemacs/set-leader-keys ":" 'spacemacs/amx-major-mode-commands)
    (spacemacs/set-leader-keys "SPC" 'spacemacs/amx)
    (global-set-key (kbd "M-x") 'spacemacs/amx)
    (global-set-key (kbd "M-X") 'spacemacs/amx-major-mode-commands)))

(straight-use-package 'ri)

(use-package wakatime-mode
  :straight t
  :init
  (setq wakatime-python-path "/usr/local/bin/python3")
  :config
  (global-wakatime-mode t))

(use-package hl-block-mode
  :straight (hl-block-mode :type git :host github :repo "emacsmirror/hl-block-mode")
  :disabled
  :config
  (global-hl-block-mode t))

(use-package evil-ruby-text-objects
  :straight t
  :disabled
  :init
  (add-hook 'ruby-mode-hook 'evil-ruby-text-objects-mode)
  (add-hook 'enh-ruby-mode-hook 'evil-ruby-text-objects-mode))

(use-package indent-guide
  :straight t
  :if window-system
  :init
  (setq indent-guide-delay 0.8)
  (setq indent-guide-char "·")
  (setq indent-guide-threshold 1)

  ;; retard removing highlights so I can find myself after long jumps in big
  ;; blocks
  (defun indent-guide-pre-command-hook ()
    ;; some commands' behavior may affected by indent-guide overlays, so
    ;; remove all overlays in pre-command-hook.
    (run-with-timer 0.4 nil
                    (lambda () (indent-guide-remove))))

  (add-hook 'prog-mode-hook
            (lambda() (indent-guide-mode t))))

(use-package doom-todo-ivy
  ;; :disabled
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

(use-package rubocopfmt
  :straight (rubocopfmt :type git :host github :repo "jimeh/rubocopfmt.el")
  :init
  (add-to-list 'load-path "~/.spacemacs.d/layers/hmz-misc/local")
  (add-hook 'ruby-mode-hook #'rubocopfmt-mode))

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
  (message "Killed buffer %s" p)
  ) (process-buffer proc)))
      (alert (process-name proc) :title string))

    (setq my-ansi-escape-re
      (rx (or
    (and (or ?\233 (and ?\e ?\[))
   (zero-or-more (char (?0 . ?\?)))
   (zero-or-more (char ?\s ?- ?\/))
   (char (?@ . ?~)))
    (char "
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
       ((string-equal "
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

    (spacemacs/set-leader-keys "a b" 'bpr-spawn)

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

(use-package ember-mode
  :straight t
  :config
  (defun ember--file-project-root (file)
    "Overriden function so it come back to the old behavior and
       search by app dir."
    (locate-dominating-file file "app"))

  (add-hook 'coffee-mode-hook (lambda () (ember-mode t)))
  (add-hook 'js-mode-hook (lambda () (ember-mode t)))
  (add-hook 'web-mode-hook (lambda () (ember-mode t))))

(use-package switch-buffer-functions
  :straight t
  :config
  (setq switch-buffer-functions nil)
  (add-hook 'switch-buffer-functions
            (lambda (prev cur)
              (unless (or (string= (buffer-name) "*Messages*")
                          (string= (buffer-name) neo-buffer-name))
                (if (and (not hmz-neotree-hidden) (buffer-file-name))
                    (neotree-refresh t)

                  (neotree-hide))))))

;; NOTE: the following two are incompatible with Ruby code so they are
;; disabled for good
(use-package vimish-fold
  :ensure
  :disabled
  :after evil)

(use-package evil-vimish-fold
  :ensure
  :disabled
  :after vimish-fold
  :hook ((prog-mode conf-mode text-mode) . evil-vimish-fold-mode))

(provide 'hmz-modules)

;; ===============================================================