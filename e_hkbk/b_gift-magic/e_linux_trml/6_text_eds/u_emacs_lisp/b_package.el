;; Add Melpa repository
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install and load mu4e
(unless (package-installed-p 'mu4e)
  (package-refresh-contents)
  (package-install 'mu4e))
(require 'mu4e)
