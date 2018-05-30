;self


(define (make-monitored f)
    (let ((counter 0))
        (define (how-many-calls?)
            (counter)
        )

        (define (reset-count)
            (set! counter 0)
        )

        (define (dispatch m)
            (cond ((eq? 'how-many-calls) how-many-calls)
                ((eq? 'reset-count) reset-count)
                (else (lambda (x)
                        (set! counter (+ counter 1))
                        (f x)
                ))
            )
        )
        dispatch
    )
)

;answer
(define make-monitored 
   (let ((count 0)) 
         (lambda (f) 
           (lambda (arg) 
                 (cond ((eq? arg 'how-many-calls?) count) 
                           ((eq? arg 'reset-count) 
                            (set! count 0) 
                            count) 
                           (else (set! count (+ count 1)) 
                                         (f arg))))))) 

(define (make-monitored function) 
   (define times-called 0) 
   (define (mf message) 
     (cond ((eq? message 'how-many-calls?) times-called) 
           ((eq? message 'reset-count) (set! times-called 0)) 
           (else (set! times-called (+ times-called 1)) 
                 (function message)))) 
   mf)


 (define (make-monitored proc) 
   (let ((count 0)) 
     (lambda (first . rest) 
       (cond ((eq? first 'how-many-calls?) count) 
             ((eq? first 'reset-count) (set! count 0)) 
             (else (begin (set! count (+ count 1))  
                          (apply proc (cons first rest)))))))) 