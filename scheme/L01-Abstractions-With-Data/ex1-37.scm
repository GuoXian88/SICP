;self solution
;k项有限连分式

;iterative
(define (cont-frac n d k)
    (y k n 0)
)

(define (y k n res)
    (if (> k n)
        (/ n d)
        (+ res (/ n (+ d (y (+ k 1)))))
    )
)

;recursive
(define (y k)
    (if (= k 0)
        (/ n d)
        (/ n (+ d (y (- k 1))))
    )
)

(define (cont-frac n d k)
    (define (loop term)
        (if (= term k)
            (/ (n term) (d term))
            ((/ (n term) (+ (d term) (loop  (+ term 1)))))
        )
    )
    (loop 0)
)

;answer n和d是函数,k递减到0
(define (cont-frac n d k)
    (define (loop result term)
        (if (= term 0)
            result
            (loop (/ (n term) (+ (d term) result)) (- term 1))
        )
    )

    (loop 0 k)
)

;recursive 其实就是不断进行f fx

(define (cont-frac n d k) 
    (cond ((= k 0) 0) 
          (else (/ (n k) (+ (d k) (cont-frac n d (- k 1))))))) 
