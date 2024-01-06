(load-theme 'solarized-dark t)

;; settings

(setq custom-safe-themes
   '("fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" default))
(setq desktop-save-mode t)
(setq dired-kill-when-opening-new-dired-buffer t)
(setq mouse-wheel-flip-direction t)
(setq mouse-wheel-tilt-scroll t)
(setq tool-bar-mode nil)
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq create-lockfiles nil)
(delete-selection-mode 1)


;; avoid backup files all over the place
(setq backup-directory-alist            '((".*" . "~/.EmacsBackup")))

(defun stylesheet()
 (interactive)
  (insert "#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"file:///Users/olivergrasl/zettelkasten/css/style.css\" />")
)

;; org mode settings
(setq org-agenda-files (directory-files-recursively "~/zettelkasten" "^[^\\.].+\\.org$"))

(defun today-file()
  "path to today file"
  (concat "~/zettelkasten/journal/" (format-time-string "%Y%m%d") ".org")
)

(defun fill-journal-template(title)
  "fills journal template if buffer is empty"
  (if (= (buffer-size) 0) (insert (concat "#+TITLE:" title "\n#+AUTHOR: Dr. Oliver Grasl\n#+FILETAGS: journal")))
 )

(setq org-default-notes-file (today-file))

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

  
(defun today()
  "open today's journal file"
  (interactive)
  (switch-to-buffer (find-file (today-file)))
  (add-to-list 'org-agenda-files (today-file))
  (fill-journal-template (format-time-string "%Y-%m-%d"))
  )

(defun yesterday()
  "open yesterday's journal file"
  (interactive)
  (setq journal-day (time-subtract (current-time) (seconds-to-time 86000)))
  (switch-to-buffer (find-file (concat "~/zettelkasten/journal/" (format-time-string "%Y%m%d" journal-day) ".org")))
  (fill-journal-template (format-time-string "%Y-%m-%d" journal-day))
 )

(defun tomorrow()
  "open tomorrows's journal file"
  (interactive)
  (setq journal-day (time-add (current-time) (seconds-to-time 86000)))
  (switch-to-buffer (find-file (concat "~/zettelkasten/journal/" (format-time-string "%Y%m%d" journal-day) ".org")))
  ;; if buffer is empty, add the boiler plate heading
  (fill-journal-template (format-time-string "%Y-%m-%d" journal-day))
)



;; other key bindings

(global-set-key (kbd "M-o") (lambda ()
			      (interactive)
			      (end-of-line)
			      (newline-and-indent)
			      ) )

(setq ns-right-alternate-modifier 'none) ;; works fine on with mac keyboard, the following is necessary for ipad keyboards
(define-key key-translation-map (kbd "M-5") (kbd "["))
(define-key key-translation-map (kbd "M-6") (kbd "]"))
(define-key key-translation-map (kbd "M-8") (kbd "{"))
(define-key key-translation-map (kbd "M-9") (kbd "}"))
(define-key key-translation-map (kbd "M-7") (kbd "|"))
(define-key key-translation-map (kbd "M-n") (kbd "~"))

(with-eval-after-load 'org       
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (setq org-support-shift-select t)
  (add-hook 'org-mode-hook #'visual-line-mode)
  (setq org-todo-keywords
      '((sequence "TODO" "SOON" "NEXT" "NOW" "|" "DONE" "NOT DOING")))
 )




(require 'package)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

; list the packages you want
(setq package-list
    '(bind-key cape compat corfu dash external-completion git-commit jsonrpc magit magit-section markdown-mode solarized-theme transient vertico with-editor xref))


; activate all the packages
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; treesiter repos

(setq treesit-language-source-alist
   '((css "https://github.com/tree-sitter/tree-sitter-css")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     ))


;; now load wolfram mode, which is kept locally
(add-to-list 'load-path (concat user-emacs-directory "lisp/" ))
(load "wolfram-language-mode")


 (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
		 `(wolfram-language-mode . ("/Applications/Wolfram Engine.app/Contents/MacOS/WolframKernel" "-noinit" "-noprompt" "-nopaclet" "-noicon" "-nostartuppaclets" "-run" "Needs[\"LSPServer`\"];LSPServer`StartServer[]"))))

(load "whole-line-or-region")
(whole-line-or-region-global-mode)

(require 'comint)
(define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
(define-key comint-mode-map (kbd "<down>") 'comint-next-input)

;; hide the details in dired window by default and also sort it
(add-hook 'dired-mode-hook
      (lambda ()
	(dired-hide-details-mode)
      )
      )

;; larger font size
(set-face-attribute 'default nil :height 160)

(tool-bar-mode -1)
(setq-default cursor-type 'bar)


(require 'use-package)


;; Enable Corfu completion UI
;; See the Corfu README for more configuration tips.
(use-package corfu
  ;; Optional customizations
  ;; :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `corfu-exclude-modes'.
  :init
  (global-corfu-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)

  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))


;; Add extensions
(use-package cape
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :bind (("M-p p p" . completion-at-point) ;; capf
         ("M-p p t" . complete-tag)        ;; etags
         ("M-p p d" . cape-dabbrev)        ;; or dabbrev-completion
         ("M-p p h" . cape-history)
         ("M-p p f" . cape-file)
         ("M-p p k" . cape-keyword)
         ("M-p p s" . cape-symbol)
         ("M-p p a" . cape-abbrev)
         ("M-p p l" . cape-line)
         ("M-p p w" . cape-dict)
         ("M-p p \\" . cape-tex)
         ("M-p p _" . cape-tex)
         ("M-p p ^" . cape-tex)
         ("M-p p &" . cape-sgml)
         ("M-p p r" . cape-rfc1345))
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  ;; NOTE: The order matters!
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  ;;(add-to-list 'completion-at-point-functions #'cape-history)
  ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  ;;(add-to-list 'completion-at-point-functions #'cape-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
  )

