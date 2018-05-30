;self

;answer
 (define f (let ((second-last-call 0) 
                 (last-call 0)) 
             (lambda (n) 
               (set! second-last-call last-call) 
               (set! last-call n) 
               second-last-call))) 
