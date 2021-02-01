;;; gerbil site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(autoload 'gerbil-mode "gerbil-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.ss\\'" . gerbil-mode))
