(defconst hmz-misc-packages
  '(
    neotree
    spaceline-all-the-icons
    indicators
    ))

(defun hmz-misc/init-indicators ()
  (use-package indicators
    :config
    ;; (set-face-attribute 'font-lock-warning-face nil
    ;;  :background "gray50")
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
    (setq neo-auto-indent-point t)
    (setq neo-autorefresh t)
    (setq neo-banner-message "")
    (setq neo-create-file-auto-open t)
    (setq neo-filepath-sort-function (lambda (f1 f2) (string< (downcase f1) (downcase f2))))
    (setq neo-force-change-root t)
    (setq neo-show-hidden-files t)
    (setq neo-show-updir-line nil)
    (setq neo-smart-open t)
    (setq neo-theme (if (display-graphic-p) (quote icons) (quote arrow)))
    (setq neo-vc-integration (quote (char)))
    (setq neo-window-fixed-size nil)
    (setq neo-window-position (quote right))
    (setq neo-window-width 24)

    :config

    (defun neo-buffer--insert-dir-entry (node depth expanded)
      "Overriden function to get rid of useless typography."
      (let ((node-short-name (neo-path--file-short-name node)))
        (insert-char ?\s (* (- depth 1) 2)) ; indent
        (when (memq 'char neo-vc-integration)
          (insert-char ?\s 2))
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

    (defun neo-buffer--insert-fold-symbol (name &optional node-name)
      "Overriden to make it less noisy. Made to work with non-monospaced fonts."
      (let ((n-insert-image (lambda (n)
                              (insert-image (neo-buffer--get-icon n))))
            (n-insert-symbol (lambda (n)
                               (neo-buffer--insert-with-face
                                n 'neo-expand-btn-face))))
        (cond
         ((and (display-graphic-p) (equal neo-theme 'icons))
          (unless (require 'all-the-icons nil 'noerror)
            (error "Package `all-the-icons' isn't installed"))
          (setq-local tab-width 1)
          (or (and (equal name 'open) (insert (format " %s " (all-the-icons-octicon "triangle-down" :height 1.0 :v-adjust 0.0 :face '(:foreground "grey50")))))
              (and (equal name 'close) (insert (format " %s "(all-the-icons-octicon "triangle-right" :height 1.0 :v-adjust -0.0 :face '(:foreground "grey50")))))
              (and (equal name 'leaf)  (insert (format " %s " (all-the-icons-icon-for-file node-name))))))
         (t
          (or (and (equal name 'open)  (funcall n-insert-symbol "- "))
              (and (equal name 'close) (funcall n-insert-symbol "+ ")))))))


    (defun neo-opens-outwards ()
      "Reveals Neotree expanding frame and tries to compensate internal size."
      (interactive)
      (if (neo-global--window-exists-p)
          (progn
            (set-frame-width (selected-frame) (- (frame-width) 24))
            (neotree-hide))

        (let ((origin-buffer-file-name (buffer-file-name)))
          (neotree-find (projectile-project-root))
          (neotree-find origin-buffer-file-name)
          (set-frame-width (selected-frame) (+ (frame-width) 24)))))

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
        (neotree-refresh t ))
      )

    (defun neo-global--do-autorefresh ()
      "Overriden version of neotree refresh function that doesn't try to refresh buffers that are not visiting a file and generating error and jumping cursor as result."
      (interactive)
      (when (and neo-autorefresh (neo-global--window-exists-p) buffer-file-name)
          (neotree-refresh t)
        ))

    ))
