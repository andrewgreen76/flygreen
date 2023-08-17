;; Load Gnus
(require 'gnus)

(setq gnus-select-method '(nntp "https://debbugs.gnu.org"))

;; Set up your email address
(setq user-mail-address "andrewg.engr@gmail.com")
(setq user-full-name "Andrew Green")

;; Set up SMTP server for sending mail
(setq smtpmail-smtp-server "smtp.gmail.com")
(setq smtpmail-smtp-service 587) ; Change to the appropriate port. 

;; Set up incoming mail server (IMAP)
(setq gnus-select-method
      '(nnimap "andrewg.engr@gmail.com"
               (nnimap-address "imap.gmail.com")
               (nnimap-server-port 993)
               (nnimap-stream ssl)))

;; Use TLS for secure connections
(setq starttls-use-gnutls t)
(setq smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil)))
