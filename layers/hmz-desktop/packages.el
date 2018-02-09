(defconst hmz-desktop-packages
  '(desktop))


(defun hmz-desktop/post-init-desktop ()
  (use-package desktop
    :config

    ;; At this point the desktop.el hook in after-init-hook was
    ;; executed, so (desktop-read) is avoided.
    (when (not (eq (emacs-pid) (desktop-owner))) ; Check that emacs did not load a desktop yet
      ;; Here we activate the desktop mode
      (desktop-save-mode 1)

      ;; The default desktop is saved always
      (setq desktop-save t)

      ;; The default desktop is loaded anyway if it is locked
      (setq desktop-load-locked-desktop t)

      ;; Set the location to save/load default desktop
      (setq desktop-dirname user-emacs-directory)

      ;; Make sure that even if emacs or OS crashed, emacs
      ;; still have last opened files.
      ;; (add-hook 'find-file-hook
      ;;           (lambda ()
      ;;             (run-with-timer 5 nil
      ;;                             (lambda ()
      ;;                               ;; Reset desktop modification time so the user is not bothered
      ;;                               (setq desktop-file-modtime (nth 5 (file-attributes (desktop-full-file-name))))
      ;;                               (desktop-save user-emacs-directory)))))

      ;; Read default desktop
      (if (file-exists-p (concat desktop-dirname desktop-base-file-name))
          (desktop-read desktop-dirname))

      ;; Add a hook when emacs is closed to we reset the desktop
      ;; modification time (in this way the user does not get a warning
      ;; message about desktop modifications)
      (add-hook 'kill-emacs-hook
                (lambda ()
                  ;; Reset desktop modification time so the user is not bothered
                  (setq desktop-file-modtime (nth 5 (file-attributes (desktop-full-file-name)))))))

    ;; No splash screen
    ;; (setq inhibit-splash-screen t)
    ;; (setq inhibit-startup-message t)

    (setq desktop-base-lock-name
          (convert-standard-filename (format ".emacs.desktop.lock-%d" (emacs-pid))))


    (add-hook 'after-change-major-mode-hook
              (lambda () (setq mode-line-format nil)))

    ;; If the *scratch* buffer is the current one, then create a new
    ;; empty untitled buffer to hide *scratch*
    ;; (if (string= (buffer-name) "*scratch*")
    ;;     (new-empty-buffer))
    t))
