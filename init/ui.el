;; =============================================================================
;; UI
;; =============================================================================

(global-linum-mode t)
(setq-default truncate-lines t)

(defun linum-format-func (line)
  (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
    (propertize (format (format "%%%dd " w) line) 'face 'linum)))

(setq linum-format 'linum-format-func)
;; use customized linum-format: add a addition space after the line number

;; Remember the cursor position of files when reopening them
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)

;; show the column number in the status bar
(column-number-mode t)

;; Powerline
(powerline-default-theme)

;; Highlight cursor line
(global-hl-line-mode t)
(set-face-background hl-line-face "gray10")

;; Make lines longer than 80 highlighted
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))
(global-whitespace-mode t)

(add-hook 'prog-mode-hook 'whitespace-mode)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  )

;; Git Gutter
;; Enable global minor mode
(global-git-gutter-mode t)
;; ;; If you would like to use git-gutter.el and linum-mode
(git-gutter:linum-setup)

(setq smooth-scroll-margin 3)
;; Delay updates to give Emacs a chance for other changes
(setq linum-delay t)
(setq redisplay-dont-pause t)

; Auto-indent with the Return key
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Fix cursor
(defun my-send-string-to-terminal (string)
  (unless (display-graphic-p) (send-string-to-terminal string)))

(defun my-evil-terminal-cursor-change ()
  (when (string= (getenv "TERM_PROGRAM") "iTerm.app")
    (add-hook 'evil-insert-state-entry-hook (lambda () (my-send-string-to-terminal "\e]50;CursorShape=1\x7")))
    (add-hook 'evil-insert-state-exit-hook  (lambda () (my-send-string-to-terminal "\e]50;CursorShape=0\x7"))))
  (when (and (getenv "TMUX") (string= (getenv "TERM_PROGRAM") "iTerm.app"))
    (add-hook 'evil-insert-state-entry-hook (lambda () (my-send-string-to-terminal "\ePtmux;\e\e]50;CursorShape=1\x7\e\\")))
    (add-hook 'evil-insert-state-exit-hook  (lambda () (my-send-string-to-terminal "\ePtmux;\e\e]50;CursorShape=0\x7\e\\")))))

(add-hook 'after-make-frame-functions (lambda (frame) (my-evil-terminal-cursor-change)))
(my-evil-terminal-cursor-change)


;; (defun change-major-mode-hook () (modify-syntax-entry ?_ "w"))

; (defun evil-move-point-by-word (dir)
;   "Used internally by evil
;
; A pure-vim emulation of move-word runs slow, but emacs forward-word
; does not recognize underscores as word boundaries. This method calls
; Emacs native forward-word, and then repeats if it detects it stopped
; on an underscore."
;   (let ((success (forward-word dir))
;         (fn (if (= 1 dir) 'looking-at 'looking-back)))
;
;     (if (and success (funcall fn "_"))
;         (evil-move-point-by-word dir)
;       success)))
;
; (defun evil-forward-word (&optional count)
;   "Move by words.
; Moves point COUNT words forward or (- COUNT) words backward if
; COUNT is negative. This function is the same as `forward-word'
; but returns the number of words by which point could *not* be
; moved."
;   (setq count (or count 1))
;   (let* ((dir (if (>= count 0) +1 -1))
;          (count (abs count)))
;     (while (and (> count 0)
;                 (evil-move-point-by-word dir))
;       (setq count (1- count)))
;     count))
;
; (evil-define-union-move evil-move-word (count)
;   "Move by words."
;   (evil-move-chars "^ \t\r\n[:word:]_" count)
;   (let ((word-separating-categories evil-cjk-word-separating-categories)
;         (word-combining-categories evil-cjk-word-combining-categories))
;     (evil-forward-word count))
;   (evil-move-empty-lines count))

