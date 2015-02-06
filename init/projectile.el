;; Enable projectile mode
(projectile-mode t)
(projectile-global-mode)

;; Show projectile lists by most recently active
(setq projectile-sort-order (quote recently-active))

;; Make NeoTree change root
(setq projectile-switch-project-action 'neotree-projectile-action)
