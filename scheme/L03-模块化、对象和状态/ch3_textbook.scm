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











