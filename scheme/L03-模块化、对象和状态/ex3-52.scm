;self

;answer

(define seq (stream-map accum (stream-enumerate-interval 1 20)))

sum

;Value: 1

(define y (stream-filter even? seq))

sum

;Value: 6

(define z (stream-filter (lambda (x) (= (remainder x 5) 0)) seq))

(stream-ref y 7)

;Value: 136





(define sum 0) 
 ;; sum => 0 
  
 (define (accum x) 
   (set! sum (+ x sum)) 
   sum) 
 ;; sum => 0 
  
 (define seq (stream-map accum (stream-enumerate-interval 1 20))) 
 ;; sum => 1 
  
 (define y (stream-filter even? seq)) 
 ;; sum => 6 
  
 (define z (stream-filter (lambda (x) (= (remainder x 5) 0)) 
                          seq)) 
 ;; sum => 10 
  
 (stream-ref y 7) 
 ;; sum => 136 
 ;; => 136 
  
 (display-stream z) 
 ;; sum => 210 
 ;; => (10 15 45 55 105 120 190 210) 


 If we had not memoized the results of delayed evaluations, we would need to recalculate the elements that `stream-ref' created when we were evaluating `display-stream'. Thus, the results would be different, because the accumulator would add those to the sum twice.

 Note that if a stream has side-effects, the side-effect of the stream-car will only ever be expressed once, and this is true for memoized and un-memoized streams. This is because of our definition of a stream as a value-thunk pair. The definition of stream in effect automatically caches the stream-car as the value part of the value-thunk pair.