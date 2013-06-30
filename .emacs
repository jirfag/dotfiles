(display-battery-mode t)
(show-paren-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(global-font-lock-mode t)

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(setq inhibit-splash-screen t)
(defun my-frame-toggle ()
  "Maximize/Restore Emacs frame using 'wmctrl'."
  (interactive)
  (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen"))

(global-set-key [(control f4)] 'my-frame-toggle)
(my-frame-toggle)
(setq make-backup-files nil) 
(global-linum-mode t)

(defvar denis-packages
  '(auto-complete epc deferred jedi pymacs elpy color-theme color-theme-solarized
    zenburn-theme)
  "A list of packages to ensure are installed at launch.")

(dolist (p denis-packages)
  (when (not (package-installed-p p))
    (message "Installing %s" p)
    (package-install p)
  ))

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)                      ; optional
(setq jedi:complete-on-dot t)                 ; optional
(color-theme-initialize)
(setq color-theme-is-global t)
(load-theme 'zenburn t)
(set-default-font "Inconsolata-18")
(menu-bar-mode 0)
(tool-bar-mode 0)
(toggle-scroll-bar -1)
