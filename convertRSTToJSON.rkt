#lang racket

(define file-text-list (file->lines "sampleRST2.txt"))

(define (get-date-in-rst-file file-data)
  (car file-data))

(get-date-in-rst-file file-text-list)


(define (collect-until-next-hash file-data)
  (for/list ([i file-data] 
             #:break (regexp-match? "#.+" i)) i))
             
(define (create-list file-data type-of-list)
  (cond
    [(empty? file-data) empty]
    [else
     (if (regexp-match? type-of-list (car file-data)) (cons (collect-until-next-hash (rest file-data)) (create-list (rest file-data) type-of-list))
         (create-list (rest file-data) type-of-list))]))

  (create-list file-text-list "#ISSUE")