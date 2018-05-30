;self
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

(define (make-joint acc ))
;answer

(define (make-joint account old-pass new-pass) 
   (and (number? ((account old-pass 'withdraw) 0)) 
        (lambda (pass msg) 
          (if (eq? pass new-pass) 
              (account old-pass msg) 
              (account 'bad-pass 'foo))))) ;increment bad-passwords 
