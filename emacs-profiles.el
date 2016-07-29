;;; emacs-profiles.el --- Configuration profiles for Emacs -*- lexical-binding: t; coding: utf-8; -*-

;; This file is not part of Emacs

;; Author: Ismail Ansari team.terminal@aol.in
;; Keywords: convenience, shortcuts
;; Maintainer: Ismail Ansari team.terminal@aol.in
;; Created: 2016/06/04
;; Package-Requires: ((emacs "24") (cl-lib "0.5"))
;; Description: Configuration profiles for Emacs
;; URL: http://ismail.teamfluxion.com
;; Compatibility: Emacs24


;; COPYRIGHT NOTICE
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the Free
;; Software Foundation; either version 2 of the License, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
;; for more details.
;;

;;; Install:

;; Put this file on your Emacs-Lisp load path and add the following to your
;; ~/.emacs startup file
;;
;;     (require 'emacs-profiles)
;;
;; Set a key-binding to open the configuration menu that displays all
;; configured configurations.
;;
;;     (global-set-key (kbd "C-M-`") 'emacs-profiles-show-menu)
;;
;; You can also define your configuration as
;;
;;     (emacs-profiles-set-profiles-data
;;         (list '("1" 
;;                 "Office" 
;;                 (lambda ()
;;                     (invert-face 'default)))
;;               '("2" 
;;                 "Home" 
;;                 (lambda ()
;;                     (menu-bar-mode -1)
;;                     (tool-bar-mode -1)
;;                     (scroll-bar-mode -1)))))
;;
;; Each item in the list should contain three elements:
;;
;; * Key to be pressed to load the profile
;; * Name of the profile
;; * A function to be executed against the key, the function that contains all
;;   scripts to be executed to apply that particular configuration.
;;
;; Lastly, you can also call `emacs-profiles-show-menu` at startup so that
;; you can choose which profile to start Emacs in when you start it.
;;

;;; Commentary:

;;     You can use emacs-profiles to switch between multiple set of
;;     configurations at a couple of key-presses.
;;
;;  Overview of features:
;;
;;     o   Quickly configure your Emacs to behave in a specific way
;;     o   Groups a lot of toggles into a single window
;;

;;; Code:

(require 'cl-lib)

(defvar emacs-profiles--profiles-data
  nil)

(defvar emacs-profiles--buffer-name
  " *emacs-profiles*")

;;;###autoload
(defun emacs-profiles-set-profiles-data (data)
  (setq emacs-profiles--profiles-data
        data))

;;;###autoload
(defun emacs-profiles-show-menu ()
  (interactive)
  (let ((my-buffer (get-buffer-create emacs-profiles--buffer-name)))
    (set-window-buffer (get-buffer-window)
                       my-buffer)
    (other-window 1)
    (emacs-profiles--prepare-controls emacs-profiles--profiles-data)))

(defun emacs-profiles--hide-menu ()
  (let ((my-window (get-buffer-window (get-buffer-create emacs-profiles--buffer-name))))
    (cond ((windowp my-window) (progn
                                 (kill-buffer (get-buffer-create emacs-profiles--buffer-name)))))))

(defun emacs-profiles--prepare-controls (objects)
  (princ "Select a profile to load:\n\n"
         (get-buffer-create emacs-profiles--buffer-name))
  (mapc 'emacs-profiles--display-controls-bindings
        objects)
  (emacs-profiles-mode)
  (mapc 'emacs-profiles--apply-keyboard-bindings
        objects))

(defun emacs-profiles--apply-keyboard-bindings (object)
  (let ((profile-name (nth 1 object))
        (func (nth 2 object)))
    (local-set-key (kbd (car object))
                   (lambda ()
                     (interactive)
                     (funcall func)
                     (emacs-profiles--hide-menu)
                     (message (concat "Loaded profile: "
                                      profile-name))))))

(defun emacs-profiles--display-controls-bindings (object)
  (princ (cl-concatenate 'string
                         "["
                         (nth 0 
                              object)
                         "] - "
                         (nth 1
                              object)
                         "\n")
         (get-buffer-create emacs-profiles--buffer-name)))

(define-derived-mode emacs-profiles-mode 
  special-mode 
  "emacs-profiles"
  :abbrev-table nil
  :syntax-table nil
  nil)

(emacs-profiles-set-profiles-data 
 (list '("0" "Stock Emacs"
         (lambda ()))))

(provide 'emacs-profiles)

;;; emacs-profiles.el ends here
