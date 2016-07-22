;; This is the Aquamacs Preferences file.
;; Add Emacs-Lisp code here that should be executed whenever
;; you start Aquamacs Emacs. If errors occur, Aquamacs will stop
;; evaluating this file and print errors in the *Messags* buffer.
;; Use this file in place of ~/.emacs (which is loaded as well.)

;;==============================================================================
;; Melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("marm" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;;==============================================================================
;;=================== PROGRAMS =================================================
;;==============================================================================
;; TRAMP
(require 'tramp)
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)
(setq tramp-default-method "scp")

;;Coloring dired files
(require 'diredful)
(diredful-mode 1)
;; Use the following comands to set custom coloring
; M-x diredful-add
; M-x diredful-edit
; M-x diredful-delete

;; Bookmarks
(require 'bookmark+)
(setq inhibit-splash-screen t)
(bookmark-bmenu-list)
(switch-to-buffer "*Bookmark List*")

;; MaGit
(require 'magit)
;(setq magit-last-seen-setup-instructions "1.4.0") ;;do not show warning messages

;; ESSH
(require 'essh)                                                    ;;
(defun essh-sh-hook ()                                             
  (define-key sh-mode-map "\C-c\C-o" 'pipe-region-to-shell)
  (define-key sh-mode-map "\C-c\C-b" 'pipe-buffer-to-shell)        
  (define-key sh-mode-map "\C-c\C-j" 'pipe-line-to-shell) 
  (define-key sh-mode-map "\C-c\C-n" 'pipe-line-to-shell-and-step) 
  (define-key sh-mode-map "\C-c\C-f" 'pipe-function-to-shell))      
  ;;  (define-key sh-mode-map "\C-c\C-d" 'shell-cd-current-directory)) 
  (add-hook 'sh-mode-hook 'essh-sh-hook)

;; SLURM
(add-to-list 'exec-path "/Users/fabig/Library/Preferences/Aquamacs Emacs/slurm.el-issue1/")
(require 'slurm-mode)
(require 'slurm-script-mode)

;; When splitting vertically: copy file from dired1 to dired2
(setq dired-dwim-target t)

;; Mac tweek to specify ls behaviour in dired
(require 'ls-lisp)
(setq ls-lisp-use-insert-directory-program t)
(setq insert-directory-program "/usr/local/Cellar/coreutils/8.21/libexec/gnubin/ls")
;(require 'dired-sort-map)
(setq dired-listing-switches "--group-directories-first -alh")
;--sort=extension

;; MYSQL settings
(setq sql-mysql-options '("-C" "-t" "-f" "-n"))

;; polymode
(require 'poly-R)
(require 'poly-markdown)

;; SPARQL mode
(autoload 'sparql-mode "sparql-mode.el"
    "Major mode for editing SPARQL files" t)
(add-to-list 'auto-mode-alist '("\\.sparql$" . sparql-mode))


;;==============================================================================
;;================== KEY BINDINGS ==============================================
;;==============================================================================
;;cycle buffers
(global-set-key (kbd "M-<right>") 'next-buffer)
(global-set-key (kbd "M-<left>") 'previous-buffer)

;; easy keys to split window. Key based on ErgoEmacs keybinding
; using the meta key to jump between windows
(global-set-key (kbd "M-1") 'split-window-horizontally)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'delete-window)
;(global-set-key (kbd "M-4") 'delete-other-windows)
(global-set-key (kbd "M-<tab>") 'other-window)

(defun split-3-windows-horizontally-evenly ()
  (interactive)
  (command-execute 'split-window-horizontally)
  (command-execute 'split-window-horizontally)
  (command-execute 'balance-windows)
)
(global-set-key (kbd "M-4") 'split-3-windows-horizontally-evenly)
(global-set-key (kbd "M-l") 'bookmark-bmenu-list)
; using the C-b to jump between windows
(global-set-key (kbd "C-b") 'switch-to-buffer)

;; Remote R function to run R on the cluster
;; specified ssh -X settings in the .ssh/config file
;; function to call shell and then type R
(defun remote-R ()
  (interactive)
  (shell)
  (insert "R")
  (comint-send-input))
; add keybinding for this (should be called when on remote)
(global-set-key (kbd "C-c R") 'remote-R)

;;==============================================================================
;;================== BUFFERS ===================================================
;;==============================================================================
;; Highlight the current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "grey65")

;; Fill column indicator
(require 'fill-column-indicator)
(setq fci-rule-width 2)
(setq fci-rule-color "grey90")
(setq fci-rule-column 80)
(add-hook 'after-change-major-mode-hook 'fci-mode)

;; Autopair brakets
(require 'autopair)
(autopair-global-mode 1)

;; HTMLIZE
(require 'htmlize)

;; ibuffer
(defalias 'list-buffers 'ibuffer) ; make ibuffer default

;; Auto complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
;(add-hook 'python-mode-hook 'auto-complete-mode)
(global-auto-complete-mode t)

;; Markdown 
(autoload 'markdown-mode "markdown-mode"
       "Major mode for editing Markdown files" t)
    (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
    (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
    (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; rainbow delimiters
(when (require 'rainbow-delimiters nil 'noerror) 
  (add-hook 'scheme-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'slime-mode-hook 'rainbow-delimiters-mode)  
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'python-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'R-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'org-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'sh-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'sql-mode-hook 'rainbow-delimiters-mode))

;;; MARKDOWN
(add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))
;;; R modes
(add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))

;;==============================================================================
;;================== PROGRAM SETTINGS ==========================================
;;==============================================================================

;;++++++++++++++++ R +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;; ESS indentation
(add-hook 'ess-mode-hook
      (lambda ()
        (ess-set-style 'C++ 'quiet)
        ;; Because
        ;;                                 DEF GNU BSD K&R C++
        ;; ess-indent-level                  2   2   8   5   4
        ;; ess-continued-statement-offset    2   2   8   5   4
        ;; ess-brace-offset                  0   0  -8  -5  -4
        ;; ess-arg-function-offset           2   4   0   0   0
        ;; ess-expression-offset             4   2   8   5   4
        ;; ess-else-offset                   0   0   0   0   0
        ;; ess-close-brace-offset            0   0   0   0   0
        (add-hook 'local-write-file-hooks
              (lambda ()
            (ess-nuke-trailing-whitespace)))))
;;(setq ess-nuke-trailing-whitespace-p 'ask)

;;++++++++++++++++ PYTHON ++++++++++++++++++++++++++++++++++++++++++++++++++++++
(require 'python-mode)
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; Highlight indentations in python code
(require 'highlight-indentation)
(add-hook 'python-mode-hook 'highlight-indentation-mode)
(set-face-background 'highlight-indentation-face "gray60")
;(set-face-background 'highlight-indentation-face "light sky blue")

;; Set PY horizontal window splitting 
(require 'python-mode)
(setq-default py-split-windows-on-execute-function 'split-window-horizontally)

;; Customize keybinding  
(define-key python-mode-map "\C-c\C-r" 'py-execute-region)

;; Enable Jedi auto-complete
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;;++++++++++++++ ORG MODE ++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; ORG APPEARANCE (does not work..)
(defface org-block-begin-line
  '((t (:underline "#A7A6AA" :foreground "FFFFFF" :background "#6c7b8b")))
  "Face used for the line delimiting the begin of source blocks.")

(defface org-block-background
  '((t (:background "green")))
  "Face used for the source block background.")

(defface org-block-end-line
  '((t (:overline "#A7A6AA" :foreground "#FFFFFF" :background "#6c7b8b")))
  "Face used for the line delimiting the end of source blocks.")


;; ----- ORG configuration ------
;;make org-mode work with files ending in .org
(setq load-path (cons "/Users/fabig/Library/Preferences/Aquamacs Emacs/org-20160104" load-path))
(require 'org)
(require 'org-install)
;(require 'org-latex)
(require 'org-habit)
;(require 'org-exp-blocks)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; fontify code in code blocks
(setq org-src-fontify-natively t)

;;------ ORG agenda ------
;(define-key global-map "\C-c l" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/Desktop/org/work.org"))

;;disable the splash screen (to enable it agin, replace the t with 0)
;(setq inhibit-splash-screen t)

;;enable syntax highlighting
;(global-font-lock-mode t)
;(transient-mark-mode 1)

;; from: http://aaronbedra.com/emacs.d/
(setq org-log-done t
      org-todo-keywords '((sequence "TODO" "INPROGRESS" "SOMEDAY" "DONE"))
      org-todo-keyword-faces '(("INPROGRESS" . (:foreground "DarkOrchid1" :weight bold))
			       ("SOMEDAY" . (:foreground "salmon" :weight bold)))
      )


;; LATEX export code blocks
;(setq org-latex-listings 'listings)
;(require 'ox-latex)
;(add-to-list 'org-latex-packages-alist '("" "listings"))
;(add-to-list 'org-latex-packages-alist '("" "xcolor"))

;(setq org-latex-listings 'minted)
;(require 'ox-latex)
;(add-to-list 'org-latex-packages-alist '("" "minted"))

;; stop C-c C-c within code blocks from querying
;; and stop automatic evaluation of blocks upon export 
(setq org-confirm-babel-evaluate nil) 
(setq org-export-babel-evaluate nil) 

;; Language support for ORG MODE
(org-babel-do-load-languages
 'org-babel-load-languages
  '( (R . t)         
     (python . t)
     (sql . t)
     (emacs-lisp . t)  
     (sh . t) 
     (latex . t)
     (org . t)
     (sqlite . t)
     (sparql . t)
   ))

;; Timestaps in TODO items
(setq org-log-done 'time)

;; make sure markdown export option is active
(eval-after-load "org" '(require 'ox-md nil t))
(eval-after-load "org" '(require 'ox-gfm nil t))
(eval-after-load "org" '(require 'ox-beamer nil t))


;; enable indention in R code bloks
(defun dan/org-indent-region ()
     (interactive)
     (or (org-babel-do-key-sequence-in-edit-buffer "\C-\M-\\")
         (indent-region)))
(define-key org-mode-map "\C-\M-\\" 'dan/org-indent-region)

;; Keybinding for R code bloks: 
(defun dan/org-underscore-command ()
     (interactive)
     (or (org-babel-do-key-sequence-in-edit-buffer "_")
         (org-self-insert-command 1)))
(define-key org-mode-map "\M-\t" 'dan/org-underscore-command)

;; LATEX export with citations, cleanup afterwards
(setq org-latex-pdf-process
  '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf -bibtex -f %f"
    "latexmk -c"))

;; not 100% sure what this chunk does
(org-add-link-type
 "color" nil
 (lambda (path desc format)
  (cond
   ((eq format 'html)
    (format "<span style=\"color:%s;\">%s</span>" path desc))
   ((eq format 'latex)
    (format "{\\color{%s}%s}" path desc)))))

;; ------ Highlight certain phrases in org-mode ------

(global-hi-lock-mode 1)
(defface af-bold-blue-box '((t  (:background  "PaleTurquoise" 
                                   :foreground  "red"
                                   :height 130
                                   :bold t
                                  )))  "blue-box-face")
(defface af-bold-plum-box '((t  (:background  "plum" 
                                   :foreground  "black"
                                   :height 110
                                   :bold t
                                  )))  "plum-box-face")

(defun z-hi-lock-quizzes ()
  ;; this next line is necessary to correct sloppy hi-locking
  (if (not hi-lock-mode) 
      (progn (hi-lock-mode -1) 
             (hi-lock-mode  1)) 
    (hi-lock-mode) 
    (hi-lock-mode))
;  (highlight-regexp "\\fab\{" (quote af-bold-blue-box));
  (highlight-regexp "\\(\\\\fab\\)\\>" (quote af-bold-blue-box));
  (highlight-regexp "\\(\\\\com\\)\\>" (quote af-bold-blue-box));
  (highlight-regexp "\\(\\\\ref\\)\\>" (quote af-bold-plum-box));
)

(defun ae-hi-lock-features ()
   (interactive)
   (z-hi-lock-quizzes)
;;   ... call other functions ...
)

(add-hook 'org-mode-hook 'ae-hi-lock-features)

;;==============================================================================
;;================== THEME SETTINGS ============================================
;;==============================================================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-customization-version-id 307 t)
 '(aquamacs-tool-bar-user-customization nil t)
 '(background-color "#fcf4dc")
 '(background-mode light)
 '(bmkp-last-as-first-bookmark-file
   "/Users/fabig/Library/Preferences/Aquamacs Emacs/Packages/bookmarks")
 '(cursor-color "#52676f")
 '(custom-enabled-themes (quote (sanityinc-solarized-dark)))
 '(custom-safe-themes
   (quote
    ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(foreground-color "#52676f")
 '(global-hl-line-mode t)
 '(ns-tool-bar-display-mode (quote both) t)
 '(ns-tool-bar-size-mode (quote regular) t)
 '(one-buffer-one-frame-mode nil nil (aquamacs-frame-setup))
 '(tabbar-mode t nil (tabbar))
 '(visual-line-mode nil t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

