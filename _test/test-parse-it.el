
(require 'f)

(defun parse-it-test--load-files (dir files)
  "Load FILES under a DIR."
  (dolist (path files)
    (let ((filepath (concat (file-name-as-directory dir) path)))
      (when (and
             ;; ignore `-pkg' file.
             (not (string-match-p "-pkg.el" filepath))
             ;; Ignore test files.
             (not (string-match-p "test" filepath)))
        (load-file filepath)))))

(defun parse-it-test--all-dirs (lst)
  "Load LST of directory."
  (dolist (dir lst)
    (let ((files-el (directory-files dir nil "\\.el$"))
          (files-elc (directory-files dir nil "\\.elc$")))
      (parse-it-test--load-files dir files-el)
      (parse-it-test--load-files dir files-elc))))

;; --------------------------------------------------------------------------
;; Start testing..

(let* ((lan 'csharp)  ; [NOTE]: Change the langauge here.
       (path "c:/cool.cs")
       (load-path load-path)
       (project-path (expand-file-name "../"))
       (dirs (f-directories project-path))
       (final-list (append (list project-path) dirs)))
  (dolist (path final-list) (add-to-list 'load-path path))
  (parse-it-test--all-dirs final-list)  ; Load all core files.
  (message "[INFO] Done loading ::\n")

  (require 'parse-it)
  (setq parse-it-lex--ignore-newline t)
  (message "Parsing %s.." lan)
  (parse-it-util--print-ast-tree (parse-it lan path)))
