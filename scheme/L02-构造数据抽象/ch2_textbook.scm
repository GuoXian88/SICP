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

;闭包性质：如cons,通过cons组合出来的数据对象本身也可以通过同样的操作再进行组合
;这样就能构建层次性的结构了


;list 表结构数据

(cons 1
    (cons 2
        (cons 3
            (cons 4 nil)))
)

(define (list-ref items n)
    (if (= n 0)
        (car items)
        (list-ref (cdr items) (- n 1))
    )
)

(define (length items)
    (if(null? items)
        0
        (+ 1 (length (cdr items)))
    )
)

(define (append list1 list2)
    (if (null? list1)
        list2
        (cons (car list1) (append (cdr list1) list2))
    )
)

;map 将如何提取表的中元素和组合结果的细节隔离开


(define (map proc items)
    (if(null? items)
        nil
        (cons (proc (car items))
            (map proc (cdr items))
        )
    )
)

;表--> tree形表示 


(define (count-leaves x)
    (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                (count-leaves (cdr x))
        )
    )
)



;对树的映射

(define (scale-tree tree factor)
    (cond ((null? tree) nil)
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)
        ))
    )
)



(define (scale-tree tree factor)
    (map (lambda (sub-tree)
        (if (pair? sub-tree)
            (scale-tree sub-tree factor)
            (* sub-tree factor)
        )
    ) tree)
)


;使用约定的界面

;类似stream处理,　rxjs,信号流

(define (filter predicate sequence)
    (cond ((null? sequence) nil)
        ((predicate (car sequence))
            (cons (car sequence) (filter predicate (cdr sequence)))
        )
        (else (filter predicate (cdr sequence)))
    )
)


(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence) (accumulate op initial (cdr sequence)))
    )
)


(define (enumerate-interval low high)
    (if (> low high)
        nil
        (cons low (enumerate-interval (+ low 1) high))
    )
)

(define (enumerate-tree tree)
    (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                        (enumerate-tree (cdr tree))
        ))
    )
)


(define (sum-odd-squares tree)
    (accumulate + 0 (map square (filter odd? (enumerate-tree tree))))
)


(define (even-fibs n)
    (accumulate cons nil (
        filter even? (map fib (enumerate-interval 0 n))
    ))
)

;模块化设计
;相互连接的约定界面


(accumulate append nil
    (map (lambda (i) (
        (map (lambda (j) (list i j)) (enumerate-interval 1 (- i 1)))
    )) (enumerate-interval 1 n))
)


(define (flatmap proc seq)
    (accumulate append nil (map proc seq))
)


(define (prime-sum? pair)
    (prime? (+ (car pair) (cdr pair)))
)

(define (make-pair-sum pair)
    (list (car pair) (cdr pair) (+ (car pair) (cdr pair)))
)

(define (prime-sum-pairs n)
    (map make-pair-sum 
        (filter prime-sum?
            (flatmap
                (lambda (i)
                    (map (lambda ((j) (list i j))))
                )
                (enumerate-interval 1 (- i 1))
            )
        )
        (enumerate-interval 1 n)
    )
)


(define (permutations s)
    (if (null? s)
        (list nil)
        (flatmap (lambda (x) (
            map (lambda (p) (cons x p))
            (permutations (remove x s))
        )) s)
    )
)

(define (remove item sequence)
    (filter (lambda (x) (not (= x item)))
    sequence)
)






