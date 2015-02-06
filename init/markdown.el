;; Enable syntax highlighting in markdown
(mmm-add-classes
 '((markdown-rubyp
    :submode ruby-mode
    :face mmm-declaration-submode-face
    :front "^\{:language=\"ruby\"\}[\n\r]+~~~"
    :back "^~~~$")))

(mmm-add-classes
 '((markdown-elixirp
    :submode elixir-mode
    :face mmm-declaration-submode-face
    :front "^\{:language=\"elixir\"\}[\n\r]+~~~"
    :back "^~~~$")))

(mmm-add-classes
 '((markdown-jsp
    :submode js-mode
    :face mmm-declaration-submode-face
    :front "^\{:language=\"javascript\"\}[\n\r]+~~~"
    :back "^~~~$")))

(mmm-add-classes
 '((markdown-ruby
    :submode ruby-mode
    :face mmm-declaration-submode-face
    :front "^~~~\s?ruby[\n\r]"
    :back "^~~~$")))

(mmm-add-classes
 '((markdown-elixir
    :submode elixir-mode
    :face mmm-declaration-submode-face
    :front "^~~~\s?elixir[\n\r]"
    :back "^~~~$")))

(mmm-add-classes
 '((markdown-js
    :submode js-mode
    :face mmm-declaration-submode-face
    :front "^~~~\s?javascript[\n\r]"
    :back "^~~~$")))


(setq mmm-global-mode 't)
(setq mmm-submode-decoration-level 0)

(add-to-list 'mmm-mode-ext-classes-alist '(markdown-mode nil markdown-rubyp))
(add-to-list 'mmm-mode-ext-classes-alist '(markdown-mode nil markdown-elixirp))
(add-to-list 'mmm-mode-ext-classes-alist '(markdown-mode nil markdown-jsp))
(add-to-list 'mmm-mode-ext-classes-alist '(markdown-mode nil markdown-ruby))
(add-to-list 'mmm-mode-ext-classes-alist '(markdown-mode nil markdown-elixir))
(add-to-list 'mmm-mode-ext-classes-alist '(markdown-mode nil markdown-js))
