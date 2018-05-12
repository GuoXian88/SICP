;self solution 这个不太理解
;Church计数
(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
    (lambda (f) (lambda (x) (f ((n f) x))))
)

(define one 
    (lambda (f) (lambda (x) (f x)))
)

(define two
    (lambda (f) (lambda (x) (f (f x))))
)
;i'm a genius XD
(define (add a b)
    (lambda (f) 
        (lambda (x) (
            ((a f) ((b f) x))
        )) 
    ) 
)

;answer

So, the function f (or whatever) gets applied again and again to the innermost x.

To define add generally, the result will just be the function applied n times, where n is the (numerical) sum. add needs to take 2 args, a and b, both of which are 2-level nested lambdas (as above). So, the method signature is:

 (define (add a b) ...) 
and add needs to return a 2-level nested lambda, as a and b will be:

 (define (add a b) 
   (lambda (f) 
     (lambda (x) 
       ...))) 
Essentially, we need to apply a's multiple calls to its f (its outer lambda arg) to b's multiple calls to its f and its x. Crappy explanation. We need the function calls to be like this:

 (fa (fa (fa (fa ... (fa xa))))...) 
and xa will be the call to b:

 xa = (fb (fb (fb ... (fb x))) ...) 
We pass f and x to b like this:

 ((b f) x) 
so, we have

 (fa (fa (fa (fa ... (fa ((b f) x)))))) 
but we need the function used by a in its outer lambda function to be the same as that used by b, or nothing will make any sense - using different functions would be like mixing octal and decimal numbers in a math problem. So, we pass f as the first lambda arg to a:

 (a f) 
and then a's inner lambda - a's x - will be ((b f) x)

So, the whole thing is:

 (define (add a b) 
   (lambda (f) 
     (lambda (x) 
       ((a f) ((b f) x))))) 
Thanks to Ken Dyck for the hint.

Note: this explanation is friggin brutal. If you are more articulate than I, let 'er rip.