;self


;answer
;; this solution is based on exercise 4.11, that's to say i used different frame. 
 (define (extend-environment vars vals base-env) 
         (if (= (length vars) (length vals)) 
                 (cons (make-frame vars vals) base-env) 
                 (if (< (length vars) (length vals)) 
                         (error "Too few arguments supplied" vars vals) 
                         (error "Too many arguments supplied" vars vals)))) 
  
 ;; look up a variable in a frame 
 (define (lookup-binding-in-frame var frame) 
         (cond ((null? frame) (cons false '())) 
                   ((eq? (car (car frame)) var) 
                    (cons true (cdr (car frame)))) 
                   (else (lookup-binding-in-frame var (cdr frame))))) 
  
 ;; in frame, set var to val 
 (define (set-binding-in-frame var val frame) 
         (cond ((null? frame) false) 
                   ((eq? (car (car frame)) var) 
                    (set-cdr! (car frame) val) 
                    true) 
                   (else (set-binding-in-frame var val (cdr frame))))) 
  
 (define (lookup-variable-value var env) 
         (if (eq? env the-empty-environment) 
                 (error "Unbound variable" var)) 
                 (let ((result (lookup-binding-in-frame var (first-frame env)))) 
                         (if (car result) 
                                 (cdr result) 
                                 (lookup-variable-value var (enclosing-environment env))))) 
  
 (define (set-variable-value! var val env) 
         (if (eq? env the-empty-environment) 
                 (error "Unbound variable -- SET" var) 
                 (if (set-binding-in-frame var val (first-frame env)) 
                         true 
                         (set-variable-value! var val (enclosing-environment  env))))) 
  
 (define (define-variable! var val env) 
         (let ((frame (first-frame env))) 
                 (if (set-binding-in-frame var val frame) 
                         true 
                         (set-car! env (cons (cons var val) frame))))) 


;another

(define (env-loop env base match) 
   (let ((frame (first-frame env))) 
     (define (scan vars vals) 
       (cond ((null? vars) 
              base) 
             ((eq? var (car vars)) 
              match)                  
             (else (scan (cdr vars) (cdr vals))))) 
     (scan (frame-variables frame) 
           (frame-values frame)))) 
  
 (define (lookup-variable-value var env) 
   (env-loop env 
             (env-loop (enclosing-environment env)) 
             (car vals))) 
  
 (define (set-variable-value! var val env) 
   (env-loop env 
             (env-loop (enclosing-environment env)) 
             (set-car! vals val))) 
  
 (define (define-variable! var val env) 
   (env-loop env 
             (add-binding-to-frame! var val frame) 
             (set-car! vals val))) 
  

  