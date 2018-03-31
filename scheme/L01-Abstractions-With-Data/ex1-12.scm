;Pascal's triangle
; n-1行左移和右移相加就能得到n行的所有元素
; 0 1
; 1 0

; 0 1 1
; 1 1 0

(define (pascal n)
    (if (= n 0)
    1
    (+ (shiftRight (pascal (- n 1)))
        (shiftLeft (pascal (- n 1)))    
    )
    )
)

(define (shiftLeft p-arr)
    ; p-arr.append(0)
)

(define (shiftRight p-arr)
    ; p-arr.unshift(0)
)


; answer
 (define (pascal r c) 
   (if (or (= c 1) (= c r)) 
       1 
       (+ (pascal (- r 1) (- c 1)) (pascal (- r 1) c))))

(define (pascal-triangle row col) 
   (cond ((> col row) 0) 
         ((< col 0) 0) 
         ((= col 1) 1) 
         ((+ (pascal-triangle (- row 1) (- col 1)) 
             (pascal-triangle (- row 1) col))))) 


(define (pascal row col) 
   (cond ((or (< row col)  
              (< col 1)) 0 ) 
         ((or (= col 1) 
              (= col row)) 1) 
         (else (+ (pascal (- row 1) (- col 1)) 
                  (pascal (- row 1) col ))))) 
