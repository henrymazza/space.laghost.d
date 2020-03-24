(defconst hmz-misc-packages
  ;; default behavior is to install from melpa.org
  '(git-branch-perspective))

;; https://gist.github.com/rakanalh/00d4e208c61c49e08a713290ed4c9a28
(defun hmz-git-persp/post-init-persp-mode ()
  (use-package persp-mode
    :init
    (load  "/Users/HMz/.spacemacs.d/layers/hmz-git-persp/local/git-branch-perspective/git-branch-perspective.el")
    (persp-mode)
    (setq persp-save-dir (concat user-emacs-directory ".cache/persp-confs/")
          persp-auto-save-opt 0)

    :config
    (add-hook 'kill-emacs-hook 'persp/close-perspective)

    :bind
    ("C-x p p" . persp/switch-to-current-branch-persp)))
