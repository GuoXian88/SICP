;self
(define (subsets s)
    (if (null? s)
        (list nil)
        (let ((rest (subsets (cdr s))))
            (append rest (map (lambda (x) (cons (car s) x)) rest))
        )
    )
)


;answer
This would be a tough problem in other languages, but it's really terse in Scheme. The hard part is the logic, but it's pretty clear when you get your head around it.

The set of all subsets of a given set is the union of:

the set of all subsets excluding the first number.
the set of all subsets excluding the first number, with the first number re-inserted into each subset.
Example 1: given the set (3), the first bullet gives the subset (), and the second bullet gives (), (3).

Example 2: given the set (2, 3), the first bullet gives the subsets () and (3). The second bullet gives (2), (2, 3), (), and (3). Note that the first two subsets are the same as the last two subsets with 2 unioned into each subset.

Note this logic is similar to the coin-counting problem in section 1.2.2.


(define nil '()) 
  
 (define (subsets s) 
   (if (null? s) 
       (list nil)   ;; initially had nil, always got () back! 
       (let ((rest (subsets (cdr s)))) 
         (append rest (map (lambda (x) (cons (car s) x)) rest))))) 
  
 (subsets (list 1 2 3)) 
 (subsets (list 1 2 3 4 5)) 
 