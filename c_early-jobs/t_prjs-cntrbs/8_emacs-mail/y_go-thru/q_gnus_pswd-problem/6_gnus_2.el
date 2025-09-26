(setq user-mail-address "andrewg.engr@gmail.com")
(setq user-full-name "Andrew Green")

;; IMAP configuration
(setq gnus-select-method '(nnimap "gmail.com"
                                  (nnimap-address "imap.gmail.com")
                                  (nnimap-server-port 993)
                                  (nnimap-stream ssl)))

;; Display personal info for outgoing emails
(setq gnus-posting-styles
      '((".*"
         (address "andrewg.engr@gmail.com"))))

;; Save sent messages in Sent folder
(setq gnus-message-archive-method '(nnimap "gmail.com")           ;; MIGHT HAVE TO FIX THIS ONE !!
      gnus-message-archive-group "[Gmail]/Sent Mail")

(setq send-mail-function 'smtpmail-send-it)
(setq message-send-mail-function 'smtpmail-send-it)
