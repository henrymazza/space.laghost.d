(defconst hmz-misc-packages
  '(
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

(defun spacemacs/post-neotree ()
  (use-package neotree
    :init
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
                ))))
