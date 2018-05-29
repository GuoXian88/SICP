;模块化、对象和状态

;两种组织策略：Object和Stream(信息流)

;对象，对象变化同时保持其标识，导致代换模型-->环境模型
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


