;; Load mu4e
(require 'mu4e)

;; Set your maildir and other configuration options
(setq mu4e-maildir "~/Maildir") ; Change to your Maildir path
(setq mu4e-sent-folder "/sent")
(setq mu4e-drafts-folder "/drafts")
(setq mu4e-trash-folder "/trash")

;; Set up sending mail using `sendmail`
(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "/usr/bin/sendmail") ; Change to your sendmail path

;; Add other configuration options as needed

;; Keybinding to open mu4e
(global-set-key (kbd "C-x m") 'mu4e)

;; Load `mu4e` context for multiple accounts if needed
;; (see the official documentation for details)
