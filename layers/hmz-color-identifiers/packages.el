(defvar hmz-color-identifiers-packages
  '(
    rainbow-mode
    rainbow-identifiers
    ;; rainbow-delimiters


    ;; (rainbow-identifiers-mode t)
    ;; (rainbow-delimiters-mode-enable)
    ))

(defun hmz-color-identifiers/post-rainbow-delimiters ()
  (use-package rainbow-delimiters
    :straight t
    :disabled t
    :defer 2
    :init

    (set-face-attribute 'rainbow-delimiters-unmatched-face nil
            :foreground "red"
            :inherit 'error
            :box t)
    :config
    (add-hook 'org-mode-hook
              (lambda () (rainbow-delimiters-mode-enable)))
    (add-hook 'prog-mode-hook
              (lambda () (rainbow-delimiters-mode t)
                (font-lock-fontify-buffer)))))

(defun hmz-color-identifiers/init-rainbow-identifiers ()
  "Initialization of rainbow indentifiers in hmz-color-identifiers layer."

  (use-package rainbow-identifiers
    :straight t
    :hook ((prog-mode . rainbow-identifiers-mode)
            (org-mode . rainbow-identifiers-mode))

    :init
    (defun make-local-face (face-name &rest args)
      "Make a buffer face local"
      (interactive)
      (let ((local-face (intern (concat (symbol-name face-name) "-local"))))
        ;; First create new face which is a copy of the old face
        (copy-face face-name local-face)
        (apply 'set-face-attribute local-face nil args)
        (set (make-local-variable face-name) local-face)))

    (defun default-foreground-lightness ()
      (+ 10 (* 85 (third
                   (apply #'color-rgb-to-hsl
                          (color-name-to-rgb
                           (face-attribute 'default :foreground nil)))))))

    (defun hmz-color-identifiers/regenerate-rainbow-colors ()
      (interactive)
      (use-package color)
      (setq ns-use-srgb-colorspace t)
      (loop for i from 1 to 15 do
            (let* ((lightness (default-foreground-lightness))
                   (saturation hmz-color-identifiers-saturation)
                   (angle (* 2 pi (/ i 15.0)))
                   (a (* saturation (cos angle)))
                   (b (* saturation (sin angle)))
                   (rgb-color (color-lab-to-srgb lightness a b))
                   (max-component (apply #'max rgb-color)))

              (when (> max-component 1.0)
                ;; Keep components inside RGB gamut.
                ;; (message "Warning: rainbow-identifiers-identifier-%s saturated gamut." i)
                (setq rgb-color
                      (mapcar #'(lambda (c)
                                  (/ c max-component)) rgb-color)))

              (set-face-attribute
               (intern (format "rainbow-identifiers-identifier-%s" i))
               nil
               :foreground (apply 'color-rgb-to-hex rgb-color))))

      (font-lock-flush)
      (font-lock-fontify-buffer))

    (unless (boundp 'after-load-theme-hook)
      (defvar after-load-theme-hook nil
        "Hook run after a color theme is loaded using `load-theme'.")
      (defadvice load-theme (after run-after-load-theme-hook activate)
        "Run `after-load-theme-hook'."
        (run-hooks 'after-load-theme-hook)))

    :config

    ;; (add-hook 'after-init-hook 'hmz-color-identifiers/regenerate-rainbow-colors)
    (add-hook 'after-load-theme-hook 'hmz-color-identifiers/regenerate-rainbow-colors)
    (add-hook 'prog-mode-hook
              (lambda () (rainbow-delimiters-mode t)
                (hmz-color-identifiers/regenerate-rainbow-colors)
                (font-lock-fontify-buffer)
                ))

    ))

(defun hmz-color-identifiers/init-rainbow-mode ()
  "Initialize Rainbow Mode to show color values as string backgrounds."

  (use-package rainbow-mode
    :config
    (add-hook 'css-mode-hook (lambda() (rainbow-mode t)))
    (add-hook 'sgml-mode-hook (lambda() (rainbow-mode t)))
    (add-hook 'web-mode-hook (lambda () (rainbow-mode t)))
    (add-hook 'js2-mode-hook (lambda () (rainbow-mode t)))

    ))
