(use-modules (shell command)
             (ice-9 rdelim)
             (srfi srfi-64))

(test-begin "01-simple")

(with-output-to-file "cat.txt"
  (lambda ()
    (cat ;"/usr/share/guile/2.0/ice-9/boot-9.scm"
         "/usr/share/guile/2.0/srfi/srfi-64/testing.scm")))

(with-input-from-file "cat.txt"
  (lambda ()
    (test-assert
     (not (eof-object? (read-line))))))

(test-end "01-simple")

(let ((runner (test-runner-current)))
  (exit (test-runner-fail-count runner)))
