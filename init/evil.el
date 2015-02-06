(use-package evil
  :config
  (progn (setq evil-default-state 'normal)
         (setq evil-auto-indent t)
         (setq evil-shift-width 2)
         (setq evil-search-wrap t)
         (setq evil-find-skip-newlines t)
         (setq evil-move-cursor-back nil)
         (setq evil-mode-line-format 'before)
         (setq evil-esc-delay 0.001)
         (setq evil-cross-lines t)))

(evil-mode 1)
(setq evil-overriding-maps nil)
(setq evil-intercept-maps nil)

;; Don't wait for any other keys after escape is pressed.
(setq evil-esc-delay 0)

;; Don't show default text in command bar
                                        ;  ** Currently breaks visual range selection, looking for workaround
                                        ;(add-hook 'minibuffer-setup-hook (lambda () (evil-ex-remove-default)))

;; Make HJKL keys work in special buffers
(evil-add-hjkl-bindings magit-branch-manager-mode-map 'emacs
  "K" 'magit-discard-item
  "L" 'magit-key-mode-popup-logging)
(evil-add-hjkl-bindings magit-status-mode-map 'emacs
  "K" 'magit-discard-item
  "l" 'magit-key-mode-popup-logging
  "h" 'magit-toggle-diff-refine-hunk)
(evil-add-hjkl-bindings magit-log-mode-map 'emacs)
(evil-add-hjkl-bindings magit-commit-mode-map 'emacs)
(evil-add-hjkl-bindings occur-mode 'emacs)

(setq evil-want-C-i-jump t)
(setq evil-want-C-u-scroll t)

(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "." 'find-tag
  "t" 'projectile-find-file
  "b" 'ido-switch-buffer
  "ib" 'indent-buffer
  "cc" 'evilnc-comment-or-uncomment-lines
  "ag" 'projectile-ag
  "pp" 'projectile-switch-project
  "," 'switch-to-previous-buffer
  "gg" 'git-gutter:toggle
  ;; "gd" 'git-gutter:popup-diff
  ;; "gp" 'git-gutter:previous-hunk
  ;; "gn" 'git-gutter:next-hunk
  ;; "gr" 'git-gutter:revert-hunk
  "gb" 'mo-git-blame-current
  "gl" 'magit-log
  "gs" 'magit-status
  "w"  'kill-buffer
  "nn" 'neotree-toggle
  "nf" 'neotree-find
  "gk" 'windmove-up
  "gj" 'windmove-down
  "gl" 'windmove-right
  "gh" 'windmove-left
  "vs" 'split-window-right
  "hs" 'split-window-below
  "x" 'smex
  "s" 'shell-pop)

;; =============================================================================
;; Evil Packages
;; =============================================================================
(global-evil-surround-mode 1)

(defun fix-underscore-word ()
  (modify-syntax-entry ?_ "w"))

(defun buffer-exists (bufname)   (not (eq nil (get-buffer bufname))))
(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
  Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  ;; Don't switch back to the ibuffer!!!
  (if (buffer-exists "*Ibuffer*")  (kill-buffer "*Ibuffer*"))
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

;; =============================================================================
;; Evil Bindings
;; =============================================================================
;; (define-key evil-normal-state-map (kbd "RET") 'save-buffer)
(define-key evil-normal-state-map (kbd "C-j") 'evil-scroll-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-scroll-up)


;; Make ";" behave like ":" in normal mode
(define-key evil-normal-state-map (kbd ";") 'evil-ex)
(define-key evil-visual-state-map (kbd ";") 'evil-ex)
(define-key evil-motion-state-map (kbd ";") 'evil-ex)

;; Yank whole buffer
(define-key evil-normal-state-map (kbd "gy") (kbd "gg v G y"))

(setq key-chord-two-keys-delay 0.075)
;; (key-chord-define evil-insert-state-map "Jk" 'evil-normal-state)
;; (key-chord-define evil-insert-state-map "JK" 'evil-normal-state)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

(define-key evil-insert-state-map "j" #'cofi/maybe-exit)
(evil-define-command cofi/maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p)))
    (insert "j")
    (let ((evt (read-event (format "" ?k)
                           nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt ?k))
        (delete-char -1)
        (set-buffer-modified-p modified)
        (push 'escape unread-command-events))
       (t (setq unread-command-events (append unread-command-events
                                              (list evt))))))))

(define-key evil-normal-state-map "gh" 'windmove-left)
(define-key evil-normal-state-map "gj" 'windmove-down)
(define-key evil-normal-state-map "gk" 'windmove-up)
(define-key evil-normal-state-map "gl" 'windmove-right)

(add-hook 'neotree-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
            (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "ma") 'neotree-create-node)
            (define-key evil-normal-state-local-map (kbd "md") 'neotree-delete-node)
            (define-key evil-normal-state-local-map (kbd "R") 'neotree-refresh)
            (define-key evil-normal-state-local-map (kbd "mm") 'neotree-rename-node)
            (define-key evil-normal-state-local-map (kbd "C") 'neotree-change-root)
            (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)
            ))

;; Map ctrl-j/k to up down in ido selections
(add-hook 'ido-setup-hook
          (lambda ()
            (define-key ido-completion-map (kbd "C-j") 'ido-next-match)
            (define-key ido-completion-map (kbd "C-k") 'ido-prev-match)
            ))

