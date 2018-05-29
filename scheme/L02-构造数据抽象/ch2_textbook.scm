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
    (prime? (+ (car pair) (cadr pair)))
)

(define (make-pair-sum pair)
    (list (car pair) (cadr pair) (+ (car pair) (cadr pair)))
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


;学习语言时，需要注意 语言的基本原语，组合手段，抽象手段
;学以致用，最正直，最勇敢的人

(define (flipped-pairs painter)
    (let (
        (painter2 (beside painter (flip-vert painter)))
    ) below painter2 painter2)
)

(define wave4 (flipped-pairs wave))


(define (right-split painter n)
    (if (= n 0)
        painter
        (let (
            (smaller (right-split painter (- n 1)))
        ) (beside painter (below smaller smaller)))
    )
)


(define (corner-split painter n)
    (if (= n 0)
        painter
        (let (
            (up (up-split painter (- n 1)))
            (right (right-split painter (- n 1)))

        ) let (
            (top-left (beside up up))
            (bottom-right (below right right))
            (corner (corner-split painter (- n 1)))
        ) (beside (below painter top-left)
                (below bottom-right corner)
            ))
    )
)


(define (square-limit painter n)
    (let (
        (quarter (corner-split painter n))
    ) let (
        (half (beside (flip-horiz quarter) quarter))
    ) (below (flip-vert half) half))
)

;高阶操作

(define (square-of-four tl tr bl br)
    (lambda (painter)
        (let (
            (top (beside (tl painter) (tr painter)))
            (bottom (beside (bl painter (br painter))))
        ) (below bottom top))
    )
)


(define (flipped-pairs painter)
    (let (
        (combine4 (square-of-four identity flip-vert identity flip-vert))
    ) (combine4 painter))
)


(define (square-limit painter n)
    (let (
        (combine4 (square-of-four flip-horiz identity rotate180 flip-vert))
    ) (combine4 painter n))
)

;框架

(define (frame-coord-map frame)
    (lambda (v)
        (add-vect
            (origin-frame frame)
            (add-vect (scale-vect (xcor-vect v)
                                    (edge1-frame frame))
                       (scale-vect (ycor-vect v)
                                    (edge2-frame frame))
            )
        )
    )
)

;画折线
(define (segment->painter segment-list)
    (lambda (frame)
        (for-each (lambda (segment)
            (draw-line ((frame-coord-map frame)) (start-segment segment)
                        ((frame-coord-map frame))(end-segment segment)
            )
        ) segment-list)
    )
)


;分层设计

;引入任意符号作为数据的功能

(define (memq item x)
    (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))
    )
)



;求导

(define (deriv exp var)
    (cond ((number? exp) 0)
        ((variable? exp)
            (if (same-variable? exp var) 1 0)
        )
        ((sum? exp)
            (make-sum (deriv (addend exp) var)
                        (deiriv (augend exp) var)
            )
        )

        ((product? exp)
            (make-sum
                (make-product (multiplier exp)
                                (deriv (multiplicand exp) var)
                )

                (make-product (deriv (multiplier exp) var)
                                (multiplicand exp)
                )
            )
        )

        (else 
            (error "unknown expression type -- DERIV" EXP)
        )
    )
)

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2))
)

(define (make-sum a1 a2) (list '+ a1 a2))

(define (make-product m1 m2)
    (list '* m1 m2)
)

(define (sum? x)
    (and (pair? x) (eq? (car x) '+))
)

(define (addend s) (cadr s))

(define (augend s) (caddr s))

(define (product? x)
    (and (pair? x) (eq? (car x) '*))
)

(define (multiplier p) (cadr p))

(define (multiplicand p) (caddr p))

(define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))
    )
)

(define (=number? exp num)
    (and (number? exp) (= exp num))
)

(define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
            ((=number? m1 1)  m2)
            ((=number? m2 1)  m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))
    )
)


;集合

(define (element-of-set? x set)
    (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))
    )
)


(define (adjoin-set x set)
    (if (element-of-set? x set) set
        (cons x set)
    )
)

(define (intersection-set set1 set2)
    (cond (or (null? set1) (null? set2))
        ((element-of-set? (car set1) set2)
            (cons (car set1) (intersection-set (cdr set1) set2))
        )
        (else (intersection-set (cdr set1) set2))
    )
)
;有序集合交集
(define (intersection-set set1 set2)
    (if (or (null? set1) (null? set2))
        '()
        (let ((x1 (car set1))
                (x2 (car set2))
        )
            (cond ((= x1 x2) (cons x1 (intersection-set (cdr set1) (cdr set2))))
                ((< x1 x2) (intersection-set (cdr set1) set2))
                ((< x2 x1) (intersection-set set1 (cdr set2)))
            )
        )
    )
)

; 集合作为二叉树

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
    (list entry left right)
)

(define (element-of-set? x set)
    (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set)) (element-of-set? x (left-branch set)))
        ((> x (entry set)) (element-of-set? x (right-branch set)))
    )
)


(define (adjoin-set x set)
    (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set)) (make-tree (entry set) (adjoin-set x (left-branch set)) (right-branch set)))
        ((> x (entry set)) (make-tree (entry set) (left-branch set) (adjoin-set x (right-branch set))))
    )
)


;集合与信息检索

;Huffman编码，编码与解码，最少位数的编码? 

;生成Huffman树，从树叶开始归并，结果不唯一 

(define (make-leaf symbol weight)
    (list 'leaf symbol weight)
)

(define (leaf? object)
    (eq? (car object) 'leaf)
)

(define (symbol-leaf x) (cadr x))

(define (weight-leaf x) (caddr x))


(define (make-code-tree left right)
    (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))
    )
)

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
    (if (leaf? tree)
        (list (symbol-leaf tree))
        (caddr tree)
    )
)

(define (weight tree)
    (if (leaf? tree)
        (weight-leaf tree)
        (cadddr tree)
    )
)

;解码过程
;由0/1表和Huffman树获得编码
(define (decode bits tree)
    (define (decode-1 bits current-branch)
        (if (null? bits)
            '()
            (let (
                (next-branch (choose-branch (car bits) current-branch))
            )
                (if (leaf? next-branch);重新从头开始解码下一个
                    (cons (symbol-leaf next-branch) (decode-1 (cdr bits) tree))
                    (decode-1 (cdr bits) next-branch)
                )
            )
        )
    )

    (decode-1 bits tree)
)

(define (choose-branch bit branch)
    (cond 
        ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))
    
    )
)

;带权重元素的集合

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

;抽象数据的多重表示


;加类型标志来决定复数data是选用实部虚部表示 还是幅值极坐标表示 
;构造通用型过程, 类型标志，数据导向程序设计
;剥去和加上标志的规范方式，即类型，可以成为一种重要的组织策略

;基于类型的dispatch

;scale问题
;put 和 get， 是不是类似getter and setter

;消息传递：将数据对象设想成一个实体，它以消息的方式接收到所需操作的名字.可用来组织
;带有通用型操作的系统


(define (install-scheme-number-package)
    (define (tag x) (attach-tag 'scheme-number x))
    (put 'add '(scheme-number scheme-number)
        (lambda (x y) (tag (+ x y)))
    )
    (put 'sub '(scheme-number scheme-number)
        (lambda (x y) (tag (- x y)))
    )
    (put 'mul '(scheme-number scheme-number)
        (lambda (x y) (tag (* x y)))
    )
    (put 'div '(scheme-number scheme-number)
        (lambda (x y) (tag (/ x y)))
    )
    (put 'make '(scheme-number scheme-number)
        (lambda (x) (tag x))
    )
)

(define (make-scheme-number n)
    ((get 'make 'scheme-number) n)
)

;强制：将一种数据类型看作另一种类型的对象
;类型的层次结构，基类，子类

(define (attach-tag type-tag contents)
    (cons type-tag contents)
)

(define (type-tag datum)
    (if (pair? datum)
        (car datum)
        (error "Bad tagged datum -- TYPE-TAG" datum)
    )
)


