;self solution
(define (accumulate combiner null-value term a next b)
    (if (> a b)
        null-value
        (combiner (term a) (accumulate combiner null-value term (next a) next b))
    )
)

;iterate

(define (accumulate combiner null-value term a next b)
    (define (iter-acc a result)
        (if (> a b)
            result
            (iter-acc (next a) (combiner result (term a)))
        )
    )

    (iter-acc a null-value)
)


;answer和上面一样, 写出越来越通用的版本了

