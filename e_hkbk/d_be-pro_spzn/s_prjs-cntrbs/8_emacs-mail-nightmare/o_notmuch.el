;; Load notmuch
(require 'notmuch)

;; Configure notmuch
(setq notmuch-command "notmuch") ; Path to the notmuch executable
(setq notmuch-show-logo nil) ; Disable the notmuch logo in the header
(setq notmuch-search-oldest-first nil) ; Show newest emails at the top
(setq notmuch-search-line-faces nil) ; Disable line faces for better performance

;; Set the path to the directory where you store your Maildir
(setq notmuch-mua-maildir "~/Maildir")

;; Define a custom function to open notmuch
(defun my-open-notmuch ()
  "Open notmuch in a new buffer."
  (interactive)
  (notmuch))

;; Define keybinding to open notmuch
(global-set-key (kbd "C-c m") 'my-open-notmuch)

;; Keybindings for common notmuch functions
(define-key notmuch-search-mode-map "d"
  (lambda ()
    (interactive)
    (notmuch-search-tag '("+deleted" "-inbox"))
    (notmuch-search-archive-thread)))
(define-key notmuch-show-mode-map "d"
  (lambda ()
    (interactive)
    (notmuch-show-tag '("+deleted" "-inbox"))
    (notmuch-show-archive-thread)))

;; Customize faces for notmuch
(custom-set-faces
 '(notmuch-crypto-decryption ((t (:foreground "green"))))
 '(notmuch-crypto-part-header ((t (:foreground "blue"))))
 '(notmuch-crypto-signature-unknown ((t (:foreground "red")))))

;; Enable notmuch mode
(setq notmuch-show-mode-hook (lambda () (local-set-key "d" 'notmuch-show-tag)))
(setq notmuch-search-mode-hook (lambda () (local-set-key "d" 'notmuch-search-tag)))

(provide 'init-notmuch)
