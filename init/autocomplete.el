;;==============================================================================
;; Autocomplete with company-mode
;;==============================================================================
(add-hook 'after-init-hook 'global-company-mode)
(global-company-mode t)
(setq company-tooltip-limit 12)                      ; bigger popup window
(setq company-idle-delay .1)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
(setq company-dabbrev-downcase nil)                  ; Do not convert to lowercase
(setq company-selection-wrap-around t)               ; continue from top when reaching bottom
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-inf-ruby))
;; Hack to trigger candidate list on first TAB, then cycle through candiates with TAB
(defvar tip-showing nil)
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "TAB")  (lambda ()
                                                   (interactive)
                                                   (company-complete-common)
                                                   (if tip-showing
                                                       (company-select-next))
                                                   ))
     (define-key company-active-map [tab] 'company-select-next)))

(defun company-pseudo-tooltip-on-explicit-action (command)
  "`company-pseudo-tooltip-frontend', but only on an explicit action."
  (when (company-explicit-action-p)
    (setq tip-showing t)
    (company-pseudo-tooltip-frontend command)))

(defun company-echo-metadata-on-explicit-action-frontend (command)
  "`company-mode' front-end showing the documentation in the echo area."
  (pcase command
    (`post-command (when (company-explicit-action-p)
                     (company-echo-show-when-idle 'company-fetch-metadata)))
    (`hide
     (company-echo-hide)
     (setq tip-showing nil)
     )))

(setq company-frontends '(company-pseudo-tooltip-on-explicit-action company-echo-metadata-on-explicit-action-frontend company-preview-if-just-one-frontend))
;; End TAB cycle hack

(defadvice save-buffer (before save-buffer-always activate)
  "always save buffer"
  (set-buffer-modified-p t))
