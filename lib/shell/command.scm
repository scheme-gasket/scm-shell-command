(define-module (shell command)
  #:use-module (ice-9 optargs)
  #:use-module (ice-9 rdelim)
  #:use-module (ice-9 regex))

(define (*cat filename)
  ""
  (define (**print line)
    (display line)
    (newline))
  (call-with-input-file filename
    (lambda (input)
      (let recur ((line (read-line input)))
        (if (eof-object? line)
            #f
            (begin
              (**print line)
              (recur (read-line input))))))))

(define*-public (cat #:rest filenames)
  "specified file is concatenated and displayed"
  (for-each *cat filenames))

(define (*rm-f filename)
  ""
  (when (file-exists? filename)
        (delete-file filename)))

(define-public (rm-f filenames)
  "delete file or directory"
  (if (list? filenames)
      (for-each *rm-f filenames)
      ;; else
      (*rm-f filenames)))

(define (*rm-rf path)
  ""
  (if (file-is-directory? path)
      (rmdir path)
      ;; else
      (*rm-f path)))

(define-public (rm-rf filenames)
  (map (lambda (filename)
         (if (file-is-directory? filename)
             (map *rm-rf (file-find filename))
             ;; else
             (*rm-f filename)))
       filenames))
