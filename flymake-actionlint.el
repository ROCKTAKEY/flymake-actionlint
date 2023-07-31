;;; flymake-actionlint.el --- A Flymake handler for actionlint  -*- lexical-binding: t; -*-

;; Copyright (C) 2023  ROCKTAKEY

;; Author: ROCKTAKEY <rocktakey@gmail.com>
;; Keywords: convenience

;; Version: 0.1.0
;; Package-Requires: ((emacs "24.1") (flymake-easy "0.0.0"))
;; URL: https://github.com/ROCKTAKEY/flymake-actionlint

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Table of Contents
;; _________________

;; 1. flymake-actionlint: A Flymake handler for actionlint
;; 2. How to Use?
;; 3. License


;; [https://img.shields.io/github/tag/ROCKTAKEY/flymake-actionlint.svg?style=flat-square]
;; [https://img.shields.io/github/license/ROCKTAKEY/flymake-actionlint.svg?style=flat-square]
;; [https://img.shields.io/codecov/c/github/ROCKTAKEY/flymake-actionlint.svg?style=flat-square]
;; [https://img.shields.io/github/actions/workflow/status/ROCKTAKEY/flymake-actionlint/test.yml.svg?branch=master&style=flat-square]


;; [https://img.shields.io/github/tag/ROCKTAKEY/flymake-actionlint.svg?style=flat-square]
;; <https://github.com/ROCKTAKEY/flymake-actionlint>

;; [https://img.shields.io/github/license/ROCKTAKEY/flymake-actionlint.svg?style=flat-square]
;; <file:LICENSE>

;; [https://img.shields.io/codecov/c/github/ROCKTAKEY/flymake-actionlint.svg?style=flat-square]
;; <https://codecov.io/gh/ROCKTAKEY/flymake-actionlint?branch=master>

;; [https://img.shields.io/github/actions/workflow/status/ROCKTAKEY/flymake-actionlint/test.yml.svg?branch=master&style=flat-square]
;; <https://github.com/ROCKTAKEY/flymake-actionlint/actions>


;; 1 flymake-actionlint: A Flymake handler for actionlint
;; ======================================================

;;   Provide `Flymake' handler for [actionlint].  Please install
;;   [actionlint] before using this package.


;; [actionlint] <https://github.com/rhysd/actionlint>


;; 2 How to Use?
;; =============

;;   ,----
;;   | (add-hook 'yaml-mode-hook #'flymake-actionlint-action-load-when-actions-file)
;;   `----
;;   `flymake-actionlint-action-load-when-actions-file' automatically turns
;;   `flymake-actionlint' on only when the current file is a yaml file in
;;   `.github/workflows/'.

;;   Run `M-x flymake-actionlint-load' if you want to turn
;;   `flymake-actionlint' on manually in current buffer.


;; 3 License
;; =========

;;   This package is licensed by The GNU General Public License verson 3 or
;;   later.  See [LICENSE].


;; [LICENSE] <file:LICENSE>

;;; Code:

(require 'flymake-easy)

(defgroup flymake-actionlint ()
  "A Flymake handler for actionlint."
  :group 'convenience
  :prefix "flymake-actionlint-"
  :link '(url-link "https://github.com/ROCKTAKEY/flymake-actionlint"))

(defconst flymake-actionlint-err-line-patterns
  '(("^\\(.*\\.ya?ml\\):\\([0-9]+\\):\\([0-9]+\\):n\\(.*\\)$" 1 2 3 4))
  "Regular expressions and number which express error line pattern.
See `flymake-err-line-patterns'.")

(defvar flymake-actionlint-executable "actionlint"
  "Executable of `actionlint'.")

(defun flymake-actionlint-command (filename)
  "Return list command which run `actionlint' to FILENAME."
  (list flymake-actionlint-executable "-oneline" "-no-color" filename))

;;;###autoload
(defun flymake-actionlint-load ()
  "Load Flymake handler for `actionlint'."
  (interactive)
  (flymake-easy-load 'flymake-actionlint-command
                     flymake-actionlint-err-line-patterns
                     'tempdir
                     "yaml"))

;;;###autoload
(defun flymake-actionlint-actions-file-p (filename)
  "Return non-nil iff FILENAME is a yaml file for GitHub Actions."
  (let ((absolute-filename (expand-file-name filename)))
    (string-match-p "/\\.github/workflows/.*\\.ya?ml" absolute-filename)))

;;;###autoload
(defun flymake-actionlint-action-load-when-actions-file ()
  "Load Flymake handler when current file is yaml file for GitHub Actions."
  (when (flymake-actionlint-actions-file-p (buffer-file-name))
    (flymake-actionlint-load)))

(provide 'flymake-actionlint)
;;; flymake-actionlint.el ends here
