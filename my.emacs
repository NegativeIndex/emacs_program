;; .emacs

;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; ;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
   (global-font-lock-mode t))

;; enable visual feedback on selections
   (setq transient-mark-mode t)

;; default to better frame titles
   (setq frame-title-format
         (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
   (setq diff-switches "-u")

;; set text mode as the default mode
   (setq default-major-mode 'text-mode)

;; always end a file with a newline
;; (setq require-final-newline 'query)

;; close welcome windows
(setq inhibit-startup-message t)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
'(auto-compression-mode t nil (jka-compr))
'(case-fold-search nil)
'(cua-mode t nil (cua-base))
'(current-language-environment "UTF-8")
'(default-input-method "rfc1345")
'(global-font-lock-mode t nil (font-lock))
'(transient-mark-mode t))

(put 'set-goal-column 'disabled nil)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed t) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

; add C-x, C-c, C-v as cut copy paste
;; (require 'cua)
;; (CUA-mode t)

;;  add a new load-path
(setq load-path (append load-path (list "~/emacs_program" nil)))

;; change highlight color  
(set-face-attribute 'region nil :background "#666" :foreground "#ffffff")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Matlab-mode setup:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set up matlab-mode to load on .m files
(autoload 'matlab-mode "matlab" "Enter MATLAB mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "matlab" "Interactive MATLAB mode." t)

;; Customization:
(setq matlab-indent-function t) ; if you want function bodies indented
(setq matlab-verify-on-save-flag nil) ; turn off auto-verify on save
(defun my-matlab-mode-hook ()
  (setq fill-column 76))                ; where auto-fill should wrap
(add-hook 'matlab-mode-hook 'my-matlab-mode-hook)
(defun my-matlab-shell-mode-hook ()
  '())
(add-hook 'matlab-shell-mode-hook 'my-matlab-shell-mode-hook)

;; Turn off Matlab desktop
(setq matlab-shell-command-switches '("-nojvm"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Matlab-mode end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;
;; Update file when it was modified elsewhere by F5
;; (global-auto-revert-mode 1)
 (global-set-key
  (kbd "<f5>")
  (lambda (&optional force-reverting)
    "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
    (interactive "P")
    ;;(message "force-reverting value is %s" force-reverting)
    (if (or force-reverting (not (buffer-modified-p)))
        (revert-buffer :ignore-auto )
      (error "The buffer has been modified"))))

;; load new functions
(load-file "~/emacs_personal/my-date.el")
(load-file "~/emacs_personal/list-filenames.el")
(load-file "~/emacs_personal/delete-to-functions.el")

(global-set-key (kbd "C-<f12>") 'my-date) 
;; add hooks 
;; .job file using sh-mode
;; .ctl file using emacs-lisp-mode
;; .emacs file using emacs-lisp-mode
;; ;; add new surfix
(if (assoc "\\.ctl" auto-mode-alist)
     nil
	(nconc auto-mode-alist '(("\\.ctl" . scheme-mode))))


(if (assoc "\\.emacs" auto-mode-alist)
     nil
        (nconc auto-mode-alist '(("\\.emacs" . emacs-lisp-mode))))

(if (assoc "\\.tex" auto-mode-alist)
     nil
        (nconc auto-mode-alist '(("\\.tex" . latex-mode))))

(if (assoc "\\.job" auto-mode-alist)
     nil
        (nconc auto-mode-alist '(("\\.job" . sh-mode))))


;;       (setq auto-mode-alist (cons '("\\.emacs\\'" . emacs-lisp-mode) auto-mode-alist))
;;       ;; (setq auto-mode-alist (cons '("\\.tex\\'" . latex-mode) auto-mode-alist))

;; load new package
;;
(defface hi-red-my
  '((((min-colors 88)) (:weight bold :foreground "red1"))
    (t (:weight bold :foreground "red")))
  "Face for hi-lock mode."
  :group 'hi-lock-faces)
(require 'hl-sections)
(add-hook 'python-mode-hook 'hl-sections-mode)
(add-hook 'python-mode-hook '(lambda () (highlight-lines-matching-regexp "^[ \t]*#####" 'hi-red-my)))

(add-hook 'matlab-mode-hook 'hl-sections-mode)
(add-hook 'matlab-mode-hook '(lambda () (highlight-lines-matching-regexp "^[ \t]*%%%%%" 'hi-red-my)))




