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

        ;; highlight current line
        (hl-line-mode t)

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

    (defun neo-global--do-autorefresh ()
      "Overriden version of neotree refresh function that doesn't try to refresh buffers that are not visiting a file."
      (interactive)
      (when (and neo-autorefresh (neo-global--window-exists-p) buffer-file-name)
          (neotree-refresh t)
        ))
    ))
