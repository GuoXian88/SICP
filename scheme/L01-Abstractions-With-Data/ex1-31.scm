;self solution
(define (product term a next b)
    (if (> a b)
        1
        (* (term a) (product term (next a) next b))
    )
)

;factorial

(define (inc a) (+ a 1))

;fucking cool function, right?
(define (identity x) x)

(define (factorial n)
    (product identity 1 inc n)    
)

;算pi

(define (pi-term n)
    (if (even? n)
        (/ (+ n 2) (+ n 1))
        (/ (+ n 1) (+ n 2))
    )
)

(product pi-term 1 inc 100)

;answer和上面一样

  (define (product term a next b) 
   (define (iter a res) 
     (if (> a b) res 
          (iter (next a) (* (term a) res)))) 
    (iter a 1)) 