
;ch1 sicp text book notes
(define (square x)
    (* x x))
;1.2.1 递归转迭代

;递归写法

(define (factorial-r n)
    (if (= n 1)
        1
        (* n (factorial-r (- n 1))))
)
;迭代写法 其实就是加了个结果product和最大迭代次数max-count

(define (factorial-i n)
    (fact-iter 1 1 n)
)

(define (fact-iter product counter max-count)
    (if (> counter max-count)
        product
        (fact-iter (* counter product)
            (+ counter 1)
            max-count))
)

;Fib

(define (fib n)
    (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1)) (fib (- n 2))))
    )
)

;写成迭代

(define (fib n)
    (fib-iter 1 0 n)
)

(define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))
    )
)