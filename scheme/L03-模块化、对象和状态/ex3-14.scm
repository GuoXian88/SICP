;self


(define (mystery x)
    (define (loop x y)
        (if (null? x)
            y
            (let (
                (temp (cdr x))
            ) (set-cdr! x y)
                (loop temp x)
            )
        )
    )
    (loop x '())
)
;answer
The procedure mystery will produce the inverse order of x.  
 v 
 => (a b c d) 
 w 
 => (d c b a) 