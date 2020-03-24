(defconst hmz-desktop-packages
  '(desktop))


(defun hmz-desktop/post-init-desktop ()
  (use-package desktop
    ;; I'm suspecting cli emacs is breaking desktop file
    :ensure nil
    :if window-system
    :hook
    (after-init . desktop-save-mode)
    :init
    (setq persp-auto-resume-time -1.0 persp-auto-save-opt 0)
    (desktop-read)
    ))
