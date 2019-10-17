;;; parse-it-csharp.el --- Core parser for CSharp.  -*- lexical-binding: t; -*-

;; Copyright (C) 2019  Shen, Jen-Chieh <jcs090218@gmail.com>

;; This file is NOT part of GNU Emacs.

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
;;
;; Core parser for CSharp.
;;

;;; Code:

(require 'parse-it-c)


(defconst parse-it-csharp--token-type
  '(("COLON" . "[:]")
    ("SEMICOLON" . "[;]")
    ("COMMA" . "[,]")
    ("DOT" . "[.]")
    ("QT_S" . "[']")
    ("QT_D" . "[\"]")
    ("OPERATOR" . "[!][=]")
    ("OPERATOR" . "[=][=]")
    ("OPERATOR" . "[>][=]")
    ("OPERATOR" . "[<][=]")
    ("OPERATOR" . "[<][<]")
    ("OPERATOR" . "[>][>]")
    ("OPERATOR" . "[+-*%&|^<>~]")
    ("OPERATOR" . "[^/*][/][^/*]")
    ("BRKT_CR_OPN" . "[{]")
    ("BRKT_CR_CLS" . "[}]")
    ("BRKT_SQ_OPN" . "[\\[]")
    ("BRKT_SQ_CLS" . "[]]")
    ("PAREN_OPN" . "[(]")
    ("PAREN_CLS" . "[)]")
    ("ARROW" . "[=][>]")
    ("EQUAL" . "[=] ")
    ("DECL" . "\\<\\(class\\|enum\\|interface\\namespace|\\|new\\|struct\\)")
    ("KEYWORD" . "\\<\\(public\\|partial\\|private\\|const\\|abstract\\|sealed\\|protected\\|ref\\|out\\|static\\|virtual\\|implicit\\|explicit\\|fixed\\|override\\|params\\|internal\\|async\\|extern\\|unsafe\\|is\\|as\\|operator\\|delegate\\|event\\|set\\|get\\|add\\|remove\\|var\\|do\\|else\\|try\\|finally\\|for\\|if\\|switch\\|while\\|catch\\|foreach\\|using\\|checked\\|unchecked\\|lock\\|return\\|continue\\|break\\|throw\\|goto\\|true\\|false\\|null\\|value\\|this\\|base\\|sizeof\\|typeof\\|yield\\|where\\|select\\|from\\|let\\|orderby\\|ascending\\|descending\\|await\\)"))
  "CSharp token type.")

(defconst parse-it-csharp--into-level-symbols
  '("BRKT_CR_OPN" "BRKT_SQ_OPN" "PAREN_OPN")
  "All symbols that goes into one nested level.")

(defconst parse-it-csharp--back-level-symbols
  '("BRKT_CR_CLS" "BRKT_SQ_CLS" "PAREN_CLS")
  "All symbols that goes back up one nested level.")


(defun parse-it-csharp--make-token-type ()
  "Make up the token type."
  (append parse-it-c--c-type-commenting-token-type
          parse-it-csharp--token-type
          parse-it-lex--token-type))

(defun parse-it-csharp (path)
  "Parse the PATH CSharp."
  (let* ((parse-it-lex--token-type (parse-it-csharp--make-token-type))
         (token-list (parse-it-lex-tokenize-it path)))
    (parse-it-ast-build token-list
                        parse-it-csharp--into-level-symbols
                        parse-it-csharp--back-level-symbols)))


(provide 'parse-it-csharp)
;;; parse-it-csharp.el ends here
