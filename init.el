(mapc
 (lambda (mode)
   (when (fboundp mode)
     (funcall mode -1)))
 '(menu-bar-mode tool-bar-mode scroll-bar-mode))

(if (eq system-type 'darwin)
    (require 'cask "/opt/boxen/homebrew/Cellar/cask/0.7.2/cask.el")
  (require 'cask "~/.cask/cask.el"))

(cask-initialize)
(require 'pallet)
(pallet-mode t)

(require 's)
(require 'f)
(require 'cl)
(require 'ht)
(require 'git)
(require 'ert)
(require 'use-package)

(setq default-directory (f-full (getenv "HOME")))

;; Exec-path-from-shell
(use-package exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Use packages
(load "~/.emacs.d/init/packages.el")

(load-theme 'molokai :no-confirm)

;; Some default emacs settings
;; Change splash
(setq make-backup-files nil)
(add-hook 'emacs-startup-hook
  (lambda ()
    (when (string= (buffer-name) "*scratch*")
      (animate-string ";; Greg's Emacs setup" (/ (frame-height) 2)))))
(setq inhibit-startup-message t)
(smex-initialize)
(setq ido-everywhere t)


;; Custom scripts
(load "~/.emacs.d/init/mouse.el")
(load "~/.emacs.d/init/author-mode.el")
(load "~/.emacs.d/init/alchemist.el")
(load "~/.emacs.d/init/elixir.el")
(load "~/.emacs.d/init/evil.el")
(load "~/.emacs.d/init/ido.el")
(load "~/.emacs.d/init/parens.el")
(load "~/.emacs.d/init/underscores.el")
(load "~/.emacs.d/init/projectile.el")
(load "~/.emacs.d/init/ui.el")
(load "~/.emacs.d/init/indentation.el")
(load "~/.emacs.d/init/markdown.el")
(load "~/.emacs.d/init/autocomplete.el")
(load "~/.emacs.d/init/misc.el")

;; Recompile everything that needs
;;(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)
