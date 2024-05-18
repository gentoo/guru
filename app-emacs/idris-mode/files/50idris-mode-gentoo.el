(add-to-list 'load-path "@SITELISP@")
(add-to-list 'auto-mode-alist '("\\.idr\\'" . idris-mode))
(autoload 'idris-mode "idris-mode" nil t)
