;self
(define (queens board-size)
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter (lambda (positions)
                (safe? k positions)
            )
            (flatmap (lambda (rest-of-queens)
                (map (lambda (new-row)
                    (adjoin-position new-row k rest-of-queens)
                ) (enumerate-interval 1 board-size))
            ) (queen-cols (- k 1)))
            )
        )
    )
    (queen-cols board-size)
)


(define (adjoin-position new-row k rest-of-queens)
    (map (lambda (i)
        (list rest-of-queens i)
    ) (enumerate-interval 1 k))    
)
;this is a little bit hard!! man
(define (safe? k position)
    
)
;solution

 (define empty-board '()) 
   (define (adjoin-position row col rest) 
     (cons (list row col) rest)) 


(define (safe? k positions) 
     (let ((trial (car positions)) 
           (trial-row (caar positions)) 
           (trial-col (cadar positions)) 
           (rest (cdr positions))) 
       (accumulate (lambda (pos result) 
                     (let ((row (car pos)) 
                           (col (cadr pos))) 
                       (and (not (= (- trial-row trial-col) 
                                    (- row col))) 
                            (not (= (+ trial-row trial-col) 
                                    (+ row col))) 
                            (not (= trial-row row)) 
                            result))) 
                   true 
                   rest))) 
