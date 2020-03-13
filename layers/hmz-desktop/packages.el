(defconst hmz-desktop-packages
  '(desktop))


(defun hmz-desktop/post-init-desktop ()
  (use-package desktop
    ;; I'm suspecting cli emacs is breaking desktop file
    :if window-system
    :config

    ;; At this point the desktop.el hook in after-init-hook was
    ;; executed, so (desktop-read) is avoided.
    (when (not (eq (emacs-pid) (desktop-owner))) ; Check that emacs did not load a desktop yet
      ;; TODO: don't save Speedbar
      ;; (setq
      ;;  desktop-globals-to-save '()
      ;;  desktop-files-not-to-save ".*"
      ;;  desktop-buffers-not-to-save ".*"
      ;;  )

      ;; Avoid error with "tty" font
      (setq desktop-restore-frames t)

      ;; Here we activate the desktop mode
      (desktop-save-mode 1)

      ;; The default desktop is saved always
      (setq desktop-save t)

      ;; The default desktop is loaded anyway if it is locked
      (setq desktop-load-locked-desktop t)

      ;; Set the location to save/load default desktop
      (setq desktop-dirname (concat user-emacs-directory ".cache/"))

      ;; use different file to gui
      ;; (setq desktop-base-file-name ".emacs.app.desktop" )

      ;; Make sure that even if emacs or OS crashed, emacs
      ;; still have last opened files.
      ;; (add-hook 'find-file-hook
      ;;           (lambda ()
      ;;             (run-with-timer 5 nil
      ;;                             (lambda ()
      ;;                               ;; Reset desktop modification time so the user is not bothered
      ;;                               (setq desktop-file-modtime (nth 5 (file-attributes (desktop-full-file-name))))
      ;;                               (desktop-save user-emacs-directory)))))

      (desktop-read)
      ;; ;; Read default desktop
      ;; (add-hook 'after-init-hook
      ;;           (lambda () )
      ;;           ;; BUG got to wait spacemacs's home screen to appear otherwise items
      ;;           ;; will steal my focus
      ;;           (run-with-timer 0.1 nil
      ;;                           (lambda ()
      ;;                             (if (file-exists-p
      ;;                                  (concat desktop-dirname desktop-base-file-name))
      ;;                                 (desktop-read desktop-dirname))
      ;;                             )))

      ;; Add a hook when emacs is closed to we reset the desktop
      ;; modification time (in this way the user does not get a warning
      ;; message about desktop modifications)
      (add-hook 'kill-emacs-hook
                (lambda ()
                  ;; Reset desktop modification time so the user is not bothered
                  (setq desktop-file-modtime (nth 5 (file-attributes (desktop-full-file-name)))))))

    ;; (setq desktop-base-lock-name
          ;; (convert-standard-filename (format ".emacs.app.desktop.lock-%d" (emacs-pid))))

    ;; If the *scratch* buffer is the current one, then create a new
    ;; empty untitled buffer to hide *scratch*
    ;; (if (string= (buffer-name) "*scratch*")
    ;;     (new-empty-buffer))
    t))
