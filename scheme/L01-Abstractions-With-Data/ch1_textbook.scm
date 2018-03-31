
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

;换零钱 关键是把问题拆分成2个更小的问题

(define (count-change amount)
    (cc amount 5)
)

(define (cc amount kinds-of-coins)
    (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount (- kinds-of-coins 1))
                (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)
            )
        )
    )
)

(define (first-denomination kinds-of-coins)
    (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)
    )
)

;指数
 (define (expt b n)
    (if (= n 0)
        1
        (* b (expt b (- n 1)))
    )
 )

 ;迭代写法
 (define (expt b n)
  (expt-iter b n 1))

(define (expt-iter b counter product)
  (if (= counter 0)
      product
      (expt-iter b
                (- counter 1)
                (* b product))))

(define (even? n)
  (= (remainder n 2) 0))

 (define (fast-expt b n)
    (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))
    )
 )

; gcd

(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))
    )
)

; 找最小因子

(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

; base^exp % n

(define (expmod base exp m)
    (cond ((= exp 0) 1)
        ((even? exp)
            (remainder (square (expmod base (/ exp 2) m)) m)
        )
        (else (remainder (* base (expmod base (- exp 1) m)) m))
    
    )
)


(define (fermat-test n)
    (define (try-it a)
        (= (expmod a n n) a)
    )
    (try-it (+ 1 (random (- n 1))))
)

(define (fast-prime? n times)
    (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)
    )
)


