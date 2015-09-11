;; This is the Aquamacs Preferences file.
;; Add Emacs-Lisp code here that should be executed whenever
;; you start Aquamacs Emacs. If errors occur, Aquamacs will stop
;; evaluating this file and print errors in the *Messags* buffer.
;; Use this file in place of ~/.emacs (which is loaded as well.)

;; Melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("marm" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;; Bookmarks
(require 'bookmark+)
(setq inhibit-splash-screen t)
(bookmark-bmenu-list)
(switch-to-buffer "*Bookmark List*")

;; Autopair brakets
(require 'autopair)
(autopair-global-mode 1)

;; MaGit
(require 'magit)
(setq magit-last-seen-setup-instructions "1.4.0") ;;do not show warning messages

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

;; SLURM
(add-to-list 'exec-path "/Users/fabig/Library/Preferences/Aquamacs Emacs/slurm.el-issue1")
(require 'slurm-mode)
(require 'slurm-script-mode)

;; Fill column indicator
(require 'fill-column-indicator)
(setq fci-rule-width 2)
(setq fci-rule-color "grey80")
(setq fci-rule-column 80)
(add-hook 'after-change-major-mode-hook 'fci-mode)

;; Markdown 
(autoload 'markdown-mode "markdown-mode"
       "Major mode for editing Markdown files" t)
    (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
    (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
    (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;==============================================================
;; CUSTOMIZATION

;;-----------------------------------
;; Custom Global Key bindings

;;cycle buffers
(global-set-key (kbd "M-<right>") 'next-buffer)
(global-set-key (kbd "M-<left>") 'previous-buffer)

;; easy keys to split window. Key based on ErgoEmacs keybinding
; using the meta key to jump between windows
(global-set-key (kbd "M-1") 'split-window-horizontally)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'delete-window)
(global-set-key (kbd "M-4") 'delete-other-windows)
(global-set-key (kbd "M-<tab>") 'other-window)

(global-set-key (kbd "M-l") 'bookmark-bmenu-list)

; using the C-b to jump between windows
(global-set-key (kbd "C-b") 'switch-to-buffer)

;; Highlight the current line
(global-hl-line-mode 1)

;; rainbow delimiters
(when (require 'rainbow-delimiters nil 'noerror) 
  (add-hook 'scheme-mode-hook 'rainbow-delimiters-mode))
  (add-hook 'slime-mode-hook 'rainbow-delimiters-mode)  
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'python-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'R-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'org-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'sh-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'sql-mode-hook 'rainbow-delimiters-mode)

;; When splitting vertically: copy file from dired1 to dired2
(setq dired-dwim-target t)

;; Mac tweek to specify ls behaviour in dired
(require 'ls-lisp)
(setq ls-lisp-use-insert-directory-program t)
(setq insert-directory-program "/usr/local/Cellar/coreutils/8.21/libexec/gnubin/ls")
;(require 'dired-sort-map)
(setq dired-listing-switches "--group-directories-first -alh")
;--sort=extension

;;==============================================================
;; PYTHON

(require 'python-mode)
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; Highlight indentations in python code
(require 'highlight-indentation)
(add-hook 'python-mode-hook 'highlight-indentation-mode)
;(set-face-background 'highlight-indentation-face "gray80")
(set-face-background 'highlight-indentation-face "light sky blue")

;; Set PY horizontal window splitting 
(require 'python-mode)
(setq-default py-split-windows-on-execute-function 'split-window-horizontally)

;; Customize keybinding  
(define-key python-mode-map "\C-c\C-r" 'py-execute-region)

;; Enable Jedi auto-complete
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;;==============================================================

;;==============================================================
;; MYSQL settings
(setq sql-mysql-options '("-C" "-t" "-f" "-n"))

   
;;==============================================================
;; ORG MODE

;;disable the splash screen (to enable it agin, replace the t with 0)
;(setq inhibit-splash-screen t)

;;enable syntax highlighting
;(global-font-lock-mode t)
;(transient-mark-mode 1)

;; fontify code in code blocks
(setq org-src-fontify-natively t)

(defface org-block-begin-line
  '((t (:underline "#A7A6AA" :foreground "FFFFFF" :background "#6c7b8b")))
  "Face used for the line delimiting the begin of source blocks.")

(defface org-block-background
  '((t (:background "#eff8fb")))
  "Face used for the source block background.")

(defface org-block-end-line
  '((t (:overline "#A7A6AA" :foreground "#FFFFFF" :background "#6c7b8b")))
  "Face used for the line delimiting the end of source blocks.")

;;;;org-mode configuration
;;make org-mode work with files ending in .org
(setq load-path (cons "/Users/fabig/Library/Preferences/Aquamacs Emacs/org-8.2.10/lisp" load-path))
(require 'org)
(require 'org-install)
(require 'org-latex)
(require 'org-habit)
(require 'org-exp-blocks)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

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
   ))

;; Timestaps in TODO items
(setq org-log-done 'time)

;; make sure markdown export option is active
(eval-after-load "org" '(require 'ox-md nil t))
(eval-after-load "org" '(require 'ox-gfm nil t))
(eval-after-load "org" '(require 'ox-odt nil t))
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

;;==============================================================
;; Highlight certain phrases in org-mode

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



;;==============================================================
;; SPELL CHECKING

;(setq ispell-dictionary "en_UK")

;;==============================================================
;; polymode

(require 'poly-R)
(require 'poly-markdown)

;;; MARKDOWN
(add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))

;;; R modes
(add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))


