;有理数

;构造函数
(define (make-rat n d) (cons n d))
;选择函数
(define (numer x) (car x))
(define (denom x) (cdr x)

(define (print-rat x)
    (newline)
    (display (numer x))
    (display "/")
    (display (denom x))
)

;通过序对构造的数据称为表结构数据

(define (make-rat n d)
    (let ((g (gcd n d))
        (cons (/ n g) (/ d g))
    ))
)

;抽象的不同层次
;数据抽象是将复合数据在基本操作抽出，据此组合出进一步的抽象屏障

;gcd的计算可在在定义时计算也可以延时计算(在add-rat中)


;cons实现
;非常重要的概念: 数据的过程性表示 --> message passing

(define (cons x y)
    (define (dispatch m)
        (cond ((= m 0) x)
            ((= m 1) y)
            (else (error "Argument not 0 or 1 -- CONS" m))
        )
    )
    dispatch
)

(define (car z) (z 0))
(define (cdr z) (z 1))


(define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                    (+ (upper-bound x) (upper-bound y))
    )
)

(define (mul-interval x y)
    (let (
        (p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                    (max p1 p2 p3 p4))
    )
)

(define (div-interval x y)
    (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                                (/ 1.0 (lower-bound y))
                )
    )
)




