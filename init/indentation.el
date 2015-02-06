;; Space indentation - I want tab as two spaces everywhere
(setq-default indent-tabs-mode nil)
;; (add-hook 'enh-ruby-mode-hook (lambda () (setq evil-shift-width 2)))
(add-hook 'ruby-mode-hook (lambda () (setq evil-shift-width 2)))
(add-hook 'elixir-mode-hook (lambda () (setq evil-shift-width 2)))
(add-hook 'coffee-mode-hook (lambda () (setq evil-shift-width 2)))
(add-hook 'haml-mode-hook (lambda () (setq evil-shift-width 2)))
(add-hook 'html-mode-hook (lambda () (setq evil-shift-width 2)))
