;模块化、对象和状态

;两种组织策略：Object和Stream(信息流)

;对象，对象变化同时保持其标识，重新赋值(set!)导致代换模型-->环境模型
;流，时间的模拟，事件的发生顺序，延时求值

;3.1赋值和局部状态

;有状态：一个对象的行为受历史影响

(define balance 100)

(define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount)) balance)
        "Insufficient funds"
    )
)

;内部状态, 信息隐藏

(define new-widthdraw
    (let (
        (balance 100)
    )
        (lambda (amount)
            (if (>= balance amount)
                (begin (set! balance (- balance amount)) balance)
                "Insufficient funds"
            )
        )
    )
)


;形参用来存储状态,形参是局部的
(define (make-withdraw balance)
    (lambda (amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount)) balance)
            "Insufficient funds"
        )
    )
)

(define (make-account balance)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount)) balance)
            "Insufficient funds"
        )
    )

    (define (deposit amount)
        (set! balance (+ balance amount))
        balance
    )

    (define (dispatch m)
        (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "Unknown request -- MAKE-ACCOUNT" m))
        )
    )
    dispatch
)


;引入赋值带来的利益

(define rand
    (let ((x random-init))
        (lambda ()
            (set! x (rand-update x))
        x)
    )
)


(define (estimate-pi trials)
    (sqrt (/ 6 (monte-carlo trials cesaro-test)))
)

(define (cesaro-test)
    (= (gcd (rand) (rand)) 1)
)

(define (monte-carlo trials experiment)
    (define (iter trials-remaining trials-passed)
        (cond ((= trials-remaining 0) (/ trials-passed trials))
            ((experiment) (iter (- trials-remaining 1) (- trials-passed 1)))
            (else (iter (- trials-remaining 1) trials-passed))
        )
    )
    (iter trials 0)
)

;状态隔离,用局部状态模拟系统状态，对变量赋值去模拟状态的变化
;这样就不用传额外的参数，而是将状态隐藏到局部变量中


;引入赋值的代价

;不用任何赋值的程序设计称为函数式程序设计

(define (make-simplified-widthdraw balance)
    (lambda (amount)
        (set! balance (- balance amount))
        balance
    )
)

;环境, 同一和变化 transparent-reference, 引用透明，即可以替换

;命令式程序设计的缺陷 顺序问题， 并发问题

;求值的环境模型， 变量存储，指针指向一个位置(在环境中求值)

;一个环境是frame的一个序列
;frame是包含约束的表格
;约束是将变量名关键对应的值(一个frame里任何变量至多能关联一个约束)
;frame还包含一个指针指向外部环境
;如+号在全局环境中被约束到相应的基本加法过程


;将一个过程对象应用于实际参数，将构造一个新frame，将形参约束到实参，再在构造的新环境context中求值过程体.新frame的外围环境就是作为被应用的那个过程对象的一部分环境
;相对于一个给定环境求值一个lambda，将创建一个过程对象，这个过程对象是一个序对，由该lambda正文和一个指向环境的指针组成，这一指针指向的就是创建这个过程对象时的环境


;用变动数据做模拟
;定义了改变函数的数据对象称为变动数据对象


(define (cons x y)
    (let (
        (new (get-new-pair))
    ) (set-car! new x) (set-cdr! new y))
)

;共享和相等

;改变就是赋值


;队列的表示

;front-ptr and rear-ptr
;cons了前后两个指针
(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))

(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))

(define (empty-queue? queue) (null? (front-ptr queue)))
(define (make-queue) (cons '() '()))

(define (front-queue queue)
    (if (empty-queue? queue)
        (error "FRONT called with an empty queue" queue)
        (car (front-ptr queue))
    )
)

(define (insert-queue! queue item)
    (let (
        (new-pair (cons item '()))
    )
        (cond ((empty-queue? queue) (set-front-ptr! queue new-pair) (set-rear-ptr! queue new-pair) queue)
            (else (set-cdr! (rear-ptr queue) new-pair)
                (set-rear-ptr! queue new-pair)
                queue
            )
        )
    )
)


(define (delete-queue! queue)
    (cond ((empty-queue? queue) (error "DELETE! called with an empty queue" queue))
        (else (set-front-ptr! queue (cdr (front-ptr queue))))
    )
)

(define (lookup key table)
    (let ((record (assoc key (cdr table))))
        (if record
            (cdr record)
            false
        )
    )
)


(define (assoc key records)
    (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))
    )
)


(define (insert! key value table)
    (let ((record (assoc key (cdr table))))
        (if record
            (set-cdr! record value)
            (set-cdr! table (cons (cons (key value)) (cdr table)))
        )
    )
    'ok
)



(define (make-table)
    (list '*table*)
)


;二维表格

(define (lookup key-1 key-2 table)
    (let ((subtable (assoc key-1 (cdr table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
                (if record
                    (set-cdr! record value)
                    (set-cdr! subtable (cons (cons key-2 value) (cdr subtable)))
                )
            )
            (set-cdr! table
                (cons (list key-1 (cons key-2 value)) (cdr table))
            )
        )
    )
    'ok
)

;约束的传播
;基本约束，不同量之间的某种特定关系
;约束网络

;3.4并发：时间是一个本质问题
;串行化组，等待执行结束

(define x 10)
(define s (make-serializer))

(parallel-excute (s (lambda () (set! x (* x x))))
                (s (lambda () (set! x (+ x 1))))
)


;3.5 stream

;流处理使我们可以模拟一些包含状态的系统，但却不需要复用赋值或者变动数据
;流作为延时的表
;流的构造和使用交错进行，这种交错又是完全透明的


(stream-car (cons-stream x y))=x
(stream-cdr (cons-stream x y))=y

(define (stream-ref s n)
    (if (= n 0)
        (stream-car s)
        (stream-ref (stream-cdr s) (- n 1)
    )
)

(define (stream-map proc s)
    (if (stream-null? s)
        the-empty-stream
        (cons-stream (proc (stream-car s))
            (stream-map proc (stream-cdr s))
        )
    )
)


(define (stream-for-each proc s)
    (if (stream-null? s)
        'done
        (begin (proc (stream-car s))
            (stream-for-each proc (stream-cdr s))
        )
    )
)


(define (display-stream s)
    (stream-for-each display-line s)
)

(define (display-line x)
    (newline)
    (display x)
)


;求值时间不一样
;delay返回一个延时对象，对未来某个时间求值的一种允诺.这不就是promise嘛
;force用来使延时对象求值 
(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))


(define (stream-enumerate-interval low high)
    (if (> low high)
        the-empty-stream
        (cons-stream low (stream-enumerate-interval (+ low 1) high))
    )
)

(define (stream-filter pred stream)
    (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream)) (cons-stream (stream-car stream) (stream-filter pred (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))
    )
)


(stream-car
    (stream-cdr
        (stream-filter prime? (stream-enumerate-interval 10000 1000000))
    )
)

;由需要驱动的程序设计
;delay 和 force的实现

(delay <exp>)

(lambda () <exp>)

(define (force delayed-object)
    (delayed-object)
)
;记忆缓存 
(define (memo-proc proc)
    (let ((already-run? false) (result false))
        (lambda ()
            (if (not already-run?)
                (begin (set! result (proc))
                    (set! already-run? true)
                    result
                )
                result
            )
        )
    )
)


(define (integers-starting-from n)
    (cons-stream n (integers-starting-from (+ n 1)))
)

(define integers (integers-starting-from 1))

(define (divisible? x y) (= (remainder x y) 0))

(define no-sevens
    (stream-filter (lambda (x) (not (divisible? x 7)) integers))
)

(define (sieve stream)
    (cons-stream
        (stream-car stream)
        (sieve (stream-filter
            (lambda (x) (not (divisible? x (stream-car stream))))
            (stream-cdr stream)
        ))
    )
)


(define primes (sieve (integers-starting-from 2)))

(stream-ref primes 50) ;233


(define ones (cons-stream 1 ones))

(define (add-streams s1 s2)
    (stream-map + s1 s2)
)

(define integers (cons-stream 1 (add-streams ones integers)))

;这里跳过了..