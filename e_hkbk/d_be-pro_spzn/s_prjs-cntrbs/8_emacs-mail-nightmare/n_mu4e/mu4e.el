;; Load mu4e
(require 'mu4e)

;; Set the path to your Maildir (replace "/path/to/Maildir" with your actual path)
(setq mu4e-maildir "~/Maildir")

;; Configure mu4e for Gmail
(setq mu4e-sent-messages-behavior 'sent) ; Store sent messages in Gmail's "Sent" folder
(setq mu4e-drafts-folder "/[Gmail]/Drafts") ; Gmail's "Drafts" folder
(setq mu4e-trash-folder "/[Gmail]/Trash")   ; Gmail's "Trash" folder

;; Use 'smtpmail' for sending emails
(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it)
(setq smtpmail-smtp-server "smtp.gmail.com")
(setq smtpmail-smtp-service 587)
(setq smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil)))
(setq smtpmail-auth-credentials '(("smtp.gmail.com" 587 "andrewg.engr@gmail.com" nil)))
(setq smtpmail-default-smtp-server "smtp.gmail.com")

;; Set up mu4e for receiving emails
(setq mu4e-get-mail-command "offlineimap")

;; Use fancy icons in mu4e headers
(setq mu4e-use-fancy-chars t)

;; Shortcuts for switching between views
(setq mu4e-maildir-shortcuts
      '(("/inbox"   . ?i)
        ("/sent"    . ?s)
        ("/archive" . ?a)
        ("/trash"   . ?t)))

;; Start mu4e in the 'main' view
(setq mu4e-context-policy 'pick-first)

;; Use 'fancy' formatting for email threads
(setq mu4e-headers-show-threads nil)
(setq mu4e-headers-show-maildir nil)

;; Define a function to open mu4e
(defun my/open-mu4e ()
  (interactive)
  (mu4e))
(global-set-key (kbd "C-c m") 'my/open-mu4e)

;; Add any additional customizations you need

;; Provide visual feedback for long operations
(setq mu4e-use-fancy-chars t)
(setq mu4e-headers-leave-behavior 'apply)

;; Make sure to save sent messages
(setq message-kill-buffer-on-exit t)

;; Automatically update mail using isync (mbsync)
(setq mu4e-get-mail-command "mbsync -a")

;; Hide attachments
(setq mu4e-view-show-images t)
(setq mu4e-view-show-addresses 't)

;; Set the default context
(setq mu4e-contexts
      (list
       (make-mu4e-context
        :name "Personal"
        :match-func (lambda (msg)
                      (when msg
                        (mu4e-message-contact-field-matches
                         msg :to "andrewg.engr@gmail.com")))
        :vars '((user-mail-address . "andrewg.engr@gmail.com")
                (smtpmail-smtp-user . "andrewg.engr@gmail.com")
                (mu4e-sent-folder . "/Personal/Sent")
                (mu4e-drafts-folder . "/Personal/Drafts")
                (mu4e-trash-folder . "/Personal/Trash")
                (mu4e-refile-folder . "/Personal/Archive")
                (smtpmail-default-smtp-server . "smtp.gmail.com")
                (smtpmail-smtp-server . "smtp.gmail.com")
                (smtpmail-smtp-service . 587)
                (smtpmail-starttls-credentials . (("smtp.gmail.com" 587 nil nil)))
                (smtpmail-auth-credentials . (("smtp.gmail.com" 587 "andrewg.engr@gmail.com" nil)))
                (mu4e-sent-messages-behavior . sent))))

;; Set the default context to the one defined above
(setq mu4e-context-policy 'pick-first)
(setq mu4e-compose-context-policy 'always-ask)

;; Define a function to switch to the context
(defun my/switch-mu4e-context ()
  (interactive)
  (mu4e-context-switch))
(global-set-key (kbd "C-c c") 'my/switch-mu4e-context)

