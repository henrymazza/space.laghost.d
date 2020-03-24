(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(defun persp/get-root (branch-name)
  (let ((current-project (projectile-project-name)))
    (message current-project)
    (message branch-name)
    (if (and (not current-project) (not branch-name))
      (error "Could not find persp root"))

    (if (and current-project branch-name)
	(concat current-project "-" branch-name)
      (if current-project
	  current-project
	branch-name))))


(defun persp/close-perspective (&optional closed-branch)
  (interactive)
  (let* ((current-branch (if closed-branch
			    closed-branch
			  (magit-get-current-branch)))
	(persp-project-root (persp/get-root current-branch)))
    (if persp-project-root
	(progn
	  (message (concat "Saving " persp-project-root ".persp"))
	  (persp-save-state-to-file (concat persp-project-root ".persp"))
	  (close-all-buffers)))))

(defun persp/switch-to-current-branch-persp ()
  (interactive)
  (let ((closed-branch (magit-get-previous-branch)))
    (persp/close-perspective closed-branch))
  (message "Closed perspective")
  (let ((persp-project-root (persp/get-root (magit-get-current-branch))))
    (message (concat "Loading " persp-project-root ".persp"))
    (persp-load-state-from-file (concat persp-project-root ".persp"))))
