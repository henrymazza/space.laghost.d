(defconst hmz-misc-packages
  '(
    alert
    bpr
    ember-mode
    hide-lines
    indicators
    itail
    neotree
    spaceline-all-the-icons
    switch-buffer-functions
    (list-processes+ :location local)))

(defun hmz-misc/init-itail ()
  (use-package itail))

(defun hmz-misc/init-alert ()
  (use-package alert))

(defun hmz-misc/init-list-processes+ ()
  (use-package list-processes+
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
          (list-processes+))))))

(defun hmz-misc/init-hide-lines ()
  (use-package hide-lines
    :config
    (add-hook 'after-change-major-mode-hook
              (lambda () (add-to-invisibility-spec 'hl)))))

(defun hmz-misc/init-bpr ()
  (use-package bpr
    :config

    (use-package alert
      :config
      (defun hmz-misc/mac-notify (title &optional message)
        (alert message :title title)))

    (defun hmz-misc/bpr-process-sentinel (proc string)
      (message "Sentinel called")
      )
    (defun hmz-misc/bpr-process-filter (proc string)
      (when (buffer-live-p (process-buffer proc))
        (with-current-buffer (process-buffer proc)
          ;; (let ((moving (= (point) (process-mark proc))))
          (let ((is-current (eq (process-buffer proc) (current-buffer))))
            (save-excursion
              ;; Insert the text, advancing the process marker.
              ;; (setq buffer-face-mode-face `(:background "#111111"))
              ;; (buffer-face-mode 1)
              (goto-char (process-mark proc))

              (insert string)

              (when (string-match-p "Error" string)
                (hmz-misc/mac-notify "Filter got and Error!" string))

              (ansi-color-apply-on-region (marker-position (process-mark proc)) (point))

              (set-marker (process-mark proc) (point)))

            (unless is-current (goto-char (process-mark proc)))))))

    (use-package itail
      :init
      (defun hmz-misc/bpr-clear-or-kill ()
        "If process is running clear buffer, kills it otherwise."
        (interactive)
        (if (process-live-p (get-buffer-process (current-buffer)))
            (clear-comint-buffer)
          (kill-this-buffer))))

    (defun hmz-misc/bpr-on-error (process)
      (hmz-misc/mac-notify "Error" (process-name process)))
    (defun hmz-misc/bpr-on-success (process)
      (hmz-misc/mac-notify "Success" (process-name process)))

    (defun hmz-misc/bpr-on-start (process)
      (setq tab-width 8)
      (switch-to-buffer-other-window (process-buffer process))
      (tabbar-local-mode -1) ;; often it gets hidden, I suppose this helps
      (set-process-filter process 'hmz-misc/bpr-process-filter)
      (set-process-sentinel process 'hmz-misc/bpr-process-sentinel)
      (with-current-buffer (process-buffer process)
        (save-excursion
          (local-set-key  (kbd "s-k") 'hmz-misc/bpr-clear-or-kill)
          (text-scale-decrease 2)

          (insert (format "%s" process))))

      (hmz-misc/mac-notify "Started" (process-name process)))

    (defun hmz-misc/bpr-on-completion (process)
      (hmz-misc/mac-notify (format "Ended with status %d" (process-exit-status process)) (process-name process)))

    (spacemacs/set-leader-keys "a b" 'bpr-spawn)

    (setq bpr-on-error 'hmz-misc/bpr-on-error)
    (setq bpr-on-success 'hmz-misc/bpr-on-success)
    (setq bpr-on-completion 'hmz-misc/bpr-on-completion)
    (setq bpr-on-start 'hmz-misc/bpr-on-start)

    ;; no showing progress on echo line
    (setq bpr-show-progress nil)

    ;; use ansi-color-apply-on-region function on output buffer
    (setq bpr-colorize-output t)

    ;; use comint-mode for processes output buffers instead of shell-mode
    (setq bpr-process-mode 'shell-mode)

    ;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
    ;; (add-hook 'comint-mode-hook 'ansi-color-for-comint-mode-on)

    ;; (add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

    ))

(defun hmz-misc/init-ember-mode ()
  (use-package ember-mode
    :config
    (defun ember--file-project-root (file)
      "Overriden function so it come back to the old behavior and search by app dir."
      (locate-dominating-file file "app"))

    (add-hook 'coffee-mode-hook (lambda () (ember-mode t)))
    (add-hook 'js-mode-hook (lambda () (ember-mode t)))
    (add-hook 'web-mode-hook (lambda () (ember-mode t)))))

(defun hmz-misc/init-switch-buffer-functions ()
    (use-package switch-buffer-functions
      :config
      (setq switch-buffer-functions nil)
      (add-hook 'switch-buffer-functions
                (lambda (prev cur)
                  (unless (or (string= (buffer-name) "*Messages*")
                           (string= (buffer-name) neo-buffer-name))
                    (if (and (not hmz-neotree-hidden) (buffer-file-name))
                        (neotree-refresh t)

                      (neotree-hide))
                    )))))

(defun hmz-misc/init-indicators ()
  (use-package indicators
    :config
    (add-hook 'prog-mode
              (lambda ()
                (ind-create-indicator
                 'point
                 :managed t)))))

(defun hmz-misc/init-spaceline-all-the-icons ()
  "Spaceline customizations"
  (use-package spaceline-all-the-icons
    :ensure spaceline
    :config
    (spaceline-all-the-icons-theme)))

(defun hmz-misc/post-init-neotree ()
  (use-package neotree
    :ensure neotree

    :init
    ;; I'm leaving most of these settings to customize
    (setq neo-auto-indent-point t)
    (setq neo-autorefresh nil) ;;TODO: it crawls to a death in big dirs, going to bet on refreshing on buffer change. Possibly adding a timeout for it to occur.
    (setq neo-banner-message "")
    (setq neo-create-file-auto-open t)
    (setq neo-filepath-sort-function (lambda (f1 f2) (string< (downcase f1) (downcase f2))))

    (setq neo-vc-integration (quote (face char)))
    (setq neo-force-change-root t)
    (setq neo-show-hidden-files t)
    (setq neo-show-updir-line nil)
    (setq neo-smart-open t)
    (setq neo-theme (if (display-graphic-p) (quote icons) (quote arrow)))
    (setq neo-window-fixed-size nil)
    (setq neo-window-position (quote right))

    :config
    ;; TODO find how to properly detect if a package is being used
    (defun hmz-winum-assign-func ()
      (cond
       ((equal (buffer-name) "*Calculator*")
        9)
       ((string-match-p (buffer-name) ".*\\*NeoTree\\*.*")
        2)
       (t
        nil)))

    (setq winum-assign-func 'hmz-winum-assign-func)

    (defun neo-buffer--insert-dir-entry (node depth expanded)
      "Overriden function to get rid of useless typography."
      (let ((node-short-name (neo-path--file-short-name node)))
        (insert-char ?\s (* (- depth 1) 2)) ; indent
        (when (memq 'char neo-vc-integration)

          (insert-char ?\s 3))
        (neo-buffer--insert-fold-symbol
         (if expanded 'open 'close) node)
        (insert-button (concat node-short-name "")
                       'follow-link t
                       'face neo-dir-link-face
                       'neo-full-path node
                       'keymap neotree-dir-button-keymap
                       'help-echo (neo-buffer--help-echo-message node-short-name))
        (neo-buffer--node-list-set nil node)
        (neo-buffer--newline-and-begin)))

    (defun neo-buffer--insert-file-entry (node depth)
      (let ((node-short-name (neo-path--file-short-name node))
            (vc (when neo-vc-integration (neo-vc-for-node node))))
        (insert-char ?\s (* (- depth 1) 2)) ; indent

        (insert-char ?\s 1)
        (neo-buffer--insert-fold-symbol 'leaf node-short-name)
        (insert-char ?\s 1)
        (insert-button node-short-name
                       'follow-link t
                       'face neo-file-link-face
                       'neo-full-path node
                       'keymap neotree-file-button-keymap
                       'help-echo (neo-buffer--help-echo-message node-short-name))
        (neo-buffer--node-list-set nil node)
        (neo-buffer--newline-and-begin)))

    (defun neo-buffer--insert-fold-symbol (name &optional node-name)
      "Overriden to make it less noisy. Made to work with non-monospaced fonts."
      (let ((n-insert-image (lambda (n)
                              (insert-image (neo-buffer--get-icon n))))

            (vc (when neo-vc-integration (neo-vc-for-node node)))
            (n-insert-symbol (lambda (n)
                               (neo-buffer--insert-with-face
                                n 'neo-expand-btn-face))))
        (cond
         ((and (display-graphic-p) (equal neo-theme 'icons))
          (unless (require 'all-the-icons nil 'noerror)
            (error "Package `all-the-icons' isn't installed"))
          (setq-local tab-width 1)

          (or (and (equal name 'open)
                   (insert
                    (propertize
                     (format "%s " (all-the-icons-octicon "triangle-down"))
                     'face `(:family ,(all-the-icons-octicon-family) :foreground "skyblue" :height 1.1)
                     'display '(raise -0.1))
                    ))

              (and (equal name 'close)
                   (insert
                    (propertize
                     (format " %s " (all-the-icons-octicon "triangle-right"))
                     'face `(:family ,(all-the-icons-octicon-family) :foreground  "grey40" :height 1.1 )
                     'display '(raise 0.1))
                    ))

              (and (equal name 'leaf)
                   (if vc
                       (insert (propertize (char-to-string (car vc))
                                           'face (if (memq 'face neo-vc-integration)
                                                     (cdr vc)
                                                   neo-file-link-face)))
                     (insert ""))



                   ;; (insert
                   ;;  (propertize

                   ;;   (format "%s" (char-to-string (car vc)))
                   ;;   'face `(:height 1.1 :foreground "grey30")
                   ;;   'display '(raise 0.0)))
                   )))
         (t
          (or (and (equal name 'open)  (funcall n-insert-symbol "- "))
              (and (equal name 'close) (funcall n-insert-symbol "+ ")))))))

    (defun neo-opens-outwards ()
      "Reveals Neotree expanding frame and tries to compensate internal size."
      (interactive)
      (if (neo-global--window-exists-p)
          (progn
            (setq hmz-neotree-hidden t)
            (neotree-hide))

        (let ((origin-buffer-file-name (buffer-file-name)))
          (setq hmz-neotree-hidden nil)
          (neotree-find (projectile-project-root))
          (neotree-find origin-buffer-file-name))))

    (global-set-key (kbd "s-r") 'neo-opens-outwards)

    (defun hmz-neotree-mode-hook ()
        ;; (face-remap-add-relative 'default :background-color "white")
        (hidden-mode-line-mode t)

        ;; custom doesn't work, neither does setting on init file
        (setq neo-buffer--show-hidden-file-p nil)

        ;; hide cursor when not active
        (setq cursor-in-non-selected-windows nil)

        ;; highlight current line
        (hl-line-mode t)
        ;; hl-line-mode when window not in focus
        (setq hl-line-sticky-flag t)

        ;; disable fringes
        (setq left-fringe-width 0)
        (setq right-fringe-width 0)

        ;; makes the icons smaller, once there's no face settings
        ;; for them.
        (text-scale-set -1)

        ;; Set width here so it takes scaled font size
        (setq neo-window-width 24)
        (setq neo-window-fixed-size nil))

    (add-hook 'neotree-mode-hook 'hmz-neotree-mode-hook)

    (defadvice neo-buffer--refresh (after hmz-keep-hl-line-after-buffer-refresh 1 () activate)
      "Keep hl-line active after refreshing neotree's tree."
      (hl-line-mode t)
      (setq hl-line-sticky-flag t))

    (defadvice tabbar-cycle (after hmz-refresh-neotree-upon-cycle-tabs 1 () activate)
      (when (neo-global--window-exists-p)
        (neotree-refresh t )))

    (defadvice next-buffer (after hmz-refresh-neotree-change-next-buffer 1 () activate)
      (when (not (eq buffer-file-name neo-buffer-name))
        (if (buffer-file-name)
            (neotree-refresh t)
          (neotree-hide)
          ))
      )

    (setq hmz-neotree-hidden t)

    (defadvice previous-buffer (after hmz-refresh-neotree-change-previous-buffer 1 () activate)
      (when (not (eq buffer-file-name neo-buffer-name))
        (if (or buffer-file-name (not hmz-neotree-hidden))
            (neotree-refresh t)
          (neotree-hide)
          ))
      )

    (defun neo-global--do-autorefresh ()
      "Overriden version of neotree refresh function that doesn't try to refresh buffers that are not visiting a file and generating error and jumping cursor as result."
      (interactive)
      (when (and neo-autorefresh (neo-global--window-exists-p) buffer-file-name (not (eq (current-buffer) "*NeoTree*"))
          (neotree-refresh t))))
    ))
