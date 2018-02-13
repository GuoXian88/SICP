;Newton's method
;Now let's formalize the process in terms of procedures. We start with a value for the radicand (the number whose square root we are trying to compute) and a value for the guess. If the guess is good enough for our purposes, we are done; if not, we must repeat the process with an improved guess. We write this basic strategy as a procedure:

;main Newton's method
(define (sqr-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqr-iter (improve guess x) x))
)

;误差在指定范围内
(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001)
)

(define (improve guess x)
    (average x (/ x guess))
)

(define (average x y)
    (/ (+ x y) 2)
)

(define (square x)
    
)