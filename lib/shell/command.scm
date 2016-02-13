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
