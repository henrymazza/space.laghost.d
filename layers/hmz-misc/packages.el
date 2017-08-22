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
                 :managed t
                 ;; :fringe 'left-fringe
                 ;; :relative nil
                 ;; :face header-line-format
                 :bitmap 'hollow-square
                 :priority 210)

                )))
  )

(defun hmz-misc/init-spaceline-all-the-icons ()
  "Spaceline customizations"
  (use-package spaceline-all-the-icons
    :ensure spaceline
    :config
    (spaceline-all-the-icons-theme)
    )
  )

(defun hmz-misc/init-neotree ()
  (use-package neotree
    :init

    :config
    (defun neo-opens-outwards ()
      "Reveals Neotree expanding frame so internal size keeps the same."
      (interactive)
      (if (neo-global--window-exists-p)
          (progn
            (set-frame-width (selected-frame) (- (frame-width) 16))
            (neotree-hide)
            )
        (let ((origin-buffer-file-name (buffer-file-name)))
          (neotree-find (projectile-project-root))
          (neotree-find origin-buffer-file-name)
          (set-frame-width (selected-frame) (+ (frame-width) 16)))))
    (global-set-key (kbd "s-r") 'neo-opens-outwards)


    (add-hook 'neotree-mode-hook
              (lambda ()
                ;; (face-remap-add-relative 'default :background-color "white")
                (hidden-mode-line-mode t)

                ;; custom doesn't work, neither does setting on init file
                (setq neo-buffer--show-hidden-file-p nil)

                ;; makes the icons smaller, once there's no face settings
                ;; for them.
                (text-scale-set -2)

                ;; Set width here so it takes scaled font size
                (setq neo-window-width 16)
                (setq neo-window-fixed-size nil)
                ))

    (defun neo-global--do-autorefresh ()
      "Overriden version of neotree refresh function that doesn't try to refresh buffers that are not visiting a file."
      (interactive)
      (when (and neo-autorefresh (neo-global--window-exists-p) buffer-file-name)
          (neotree-refresh t)
        ))
    ))
