;(load "e:\\test.scm")
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

(define (odd? n)
  (not (= (remainder n 2) 0)))

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


;1.2.6  Example: Testing for Primality


;1.3 高阶函数
;One of the things we should demand from a powerful programming language is the ability to build abstractions by assigning names to common patterns and then to work in terms of the abstractions directly. 

;求a到b间的和，step是next a过程，值是term a过程
(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a)
            (sum term (next a) next b)
        )
    )
)

(define (cube x) (* x x x))

(define (inc n) (+ n 1))


;求a,b间的定积分
(define (integral f a b dx)
    (define (add-dx x) (+ x dx))
    (* (sum f (+ a (/ dx 2.0)) add-dx b)
        dx
    )
)

;lambda 没有与环境中的名字关联
(lambda (x) (/ 1.0 (* x (+ x 2))))

; let 
(define (f x y)
    (let (
        (a (+ 1 (* x y)))
        (b (- 1 y))
    )
        (+ (* x (square a))
            (* y b)
            (* a b)
        )
    )
)


;lambda and let
;作用域是body
((lambda (p1 p2 p3)
    ;body
) exp1 exp2 exp3)

;变量值在let外计算
; x值为2
(let (
        (x 3)
        (y (+ x 2)) ;y的值为4而不是2,这个计算是在外面eval的
    )
    (* x y)
)


;不动点

(define (search f neg-point pos-point)
    (let (
            (mid-point (average neg-point pos-point))
        )

        (if (close-enough? neg-point pos-point)
            mid-point
            (let ((test-value (f mid-point)))
                (cond ((positive? test-value)
                        (search f neg-point mid-point)
                    )
                    ((negative? test-value)
                        (search f mid-point pos-point)
                    )
                    (else mid-point)
                
                )
            )
        )
    )
)


(define (close-enough? x y)
    (< (abs x y) 0.001)
)

;完善考虑同号的情况

(define (half-interval-method f a b)
    (let ((a-value) (f a)
            (b-value) (f b)
        )
        (cond ((and (negative? a-value) (positive? b-value))
            (search f a b)
            )
            ((and (negative? b-value) (positive? a-value))
            (search f b a)
            )
            (else (error "Values are not of oppositive sign" a b))
        )
    )
)

;不动点

(define tolerance 0.00001)

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs v1 v2) tolerance)
    )

    (define (try guess)
        (let ((next (f guess)))
            (if (close-enough? next guess)
                next
                (try next)
            )
        )
    )

    (try first-guess)
)

;Newton's method

(define dx 0.00001)
(define (deriv g)
    (lambda (x)
        (/ (- (g (+ x dx)) (g x)) dx)
    )
)

(define (newton-transform g)
    (lambda (x)
        (- x (/ (g x) ((deriv g) x)))
    )
)

(define (newtons-method g guess)
    (fixed-point (newton-transform g) guess)
)













