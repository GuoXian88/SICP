;self
(define (make-account balance pwd)
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

    (define (dispatch mantra m)
        (if (equal? pwd mantra)
            (cond ((eq? m 'withdraw) withdraw)
                ((eq? m 'deposit) deposit)
                (else (error "Unknown request -- MAKE-ACCOUNT" m))
            )
            (error "Incorrect password")
        )
    )
    dispatch
)




;answer

(define (make-account balance password) 
   (define (withdraw amount) 
         (if (>= balance amount) 
                 (begin (set! balance (- balance amount)) 
                            balance) 
                 "Not enough money")) 
   (define (deposit amount) 
         (set! balance (+ balance amount)) 
         balance) 
   (define (dispatch pass m) 
         (if (not (eq? pass password)) 
                 (lambda (amount) "Wrong password") 
                 (cond ((eq? m 'withdraw) withdraw) 
                           ((eq? m 'deposit) deposit) 
                           (else (error "Unknown call -- MAKE-ACCOUNT" 
                                                    m))))) 
   dispatch) 

