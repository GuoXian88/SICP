;self

(define (generate-huffman-tree pairs)
    (successive-merge (make-leaf-set pairs))
)

 (define (make-code-tree left right) 
   (list left 
         right 
         (append (symbols left) (symbols right)) 
         (+ (weight left) (weight right)))) 

(define (adjoin-set x set)
    (cond 
        ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))
    )
)

(define (make-leaf-set pairs)
    (if (null? pairs)
        '()'
        (let (
            (pair (car pairs))
        )
            (adjoin-set (make-leaf (car pair) (cadr pair)) (make-leaf-set (cdr pairs)))
        )
    )
)

(define (successive-merge set)
    (if (null? set)
        '()
        (let (
            (min-leaf1 (car set))
            (min-leaf2 (cadr set))
        )
            (cons (make-code-tree min-leaf1 min-leaf2) (successive-merge (cddr set)))
        )
    )
)


;answer

 (define (successive-merge tree-ordered-set) 
   (if (= (size-of-set tree-ordered-set) 1) 
       (first-in-ordered-set leaf-set) 
       (let ((first (first-in-ordered-set tree-ordered-set)) 
             (second (second-in-ordered-set tree-ordered-set)) 
             (rest (subset tree-ordered-set 2))) 
         (successive-merge (adjoin-set (make-code-tree first second) 
                                       rest))))) 
  
 (define size-of-set length) 
 (define first-in-ordered-set car) 
 (define second-in-ordered-set cadr) 
 (define (subset set n) 
     (if (= n 0) 
         set  
         (subset (cdr set) (- n 1)))) 