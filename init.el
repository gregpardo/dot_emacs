(mapc
 (lambda (mode)
   (when (fboundp mode)
     (funcall mode -1)))
 '(menu-bar-mode tool-bar-mode scroll-bar-mode))

(require 'cask "/opt/boxen/homebrew/Cellar/cask/0.7.2/cask.el")
(cask-initialize)
(require 'pallet)

(require 's)
(require 'f)
(require 'ht)
(require 'git)
(require 'ert)
(require 'use-package)

(setq default-directory (f-full (getenv "HOME")))

(load-theme 'molokai :no-confirm)

;; Some default emacs settings
;; Change splash
(add-hook 'emacs-startup-hook
  (lambda ()
    (when (string= (buffer-name) "*scratch*")
      (animate-string ";; Greg's Emacs setup" (/ (frame-height) 2)))))

;; Use packages
(use-package ruby-mode)
(use-package coffee-mode)

;; Custom scripts
(load "~/.emacs.d/init/mouse.el")
(load "~/.emacs.d/init/author-mode.el")
(load "~/.emacs.d/init/alchemist.el")
(load "~/.emacs.d/init/elixir.el")
(load "~/.emacs.d/init/evil.el")
(load "~/.emacs.d/init/underscores.el")
(load "~/.emacs.d/init/ui.el")
(load "~/.emacs.d/init/indentation.el")
(load "~/.emacs.d/init/markdown.el")
(load "~/.emacs.d/init/misc.el")
