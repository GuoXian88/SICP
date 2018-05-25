;self
 (define (unique-triples n) 
   (flatmap (lambda (i)  
              (map (lambda (j)
                    (map lambda (k)
                        (list i j k)
                        (enumerate-interval 1 (- k 1))
                    )
                ) 
                (enumerate-interval 1 (- i 1)))) 
            (enumerate-interval 1 n))) 

 (define (prime-sum-pairs n s) 
   (map make-sum-pair 
        (filter sum-eq-s? (unique-triples n)))) 

(accumulate append nil
    (map (lambda (i) (
        (map (lambda (j) (list i j)) (enumerate-interval 1 (- i 1)))
    )) (enumerate-interval 1 n))
)


(define (flatmap proc seq)
    (accumulate append nil (map proc seq))
)


(define (sum-eq-s? pair s)
    (= s (+ (car pair) (cadr pair) (car (cadr pair))))
)

(define (make-pair-sum pair)
    (pair)
)

;answer

;Wow, that was a very nice solution, even if it went far 
;above and beyond the scope of the exercise in the book. Here 
;is code for anyone here searching for a more concise 
;solution:

(define (ordered-triples-sum n s) 
   (filter (lambda (list) (= (accumulate + 0 list) s)) 
          (flatmap 
           (lambda (i) 
             (flatmap (lambda (j) 
                  (map (lambda (k) (list i j k)) 
                       (enumerate-interval 1 (- j 1)))) 
                  (enumerate-interval 1 (- i 1)))) 
             (enumerate-interval 1 n)))) 


 (define (find-ordered-triples-sum n s) 
   (define (k-is-distinkt-in-triple? triple) 
     (let ((i (car triple)) 
           (j (cadr triple)) 
           (k (car (cdr (cdr triple))))) 
       (and (> k j) (> k i)))) 
   (filter k-is-distinkt-in-triple? 
     (flatmap 
       (lambda (i) 
         (map (lambda (j) (list i j (- n (+ i j) ) )) 
              ; j + k = n - i and k and j >= 1 
              (enumerate (+ i 1) (- n (+ i 1)) ))) 
       (enumerate 1 (- n 2))))) ; n - 2: j and k at least 1 (i_max + 1 + 1 = n) 