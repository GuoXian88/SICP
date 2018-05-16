;self
(define (par r1 r2)
    (div-interval (mul-interval r1 r2)
        (add-interval r1 r2)
    )
)

(define (par2 r1 r2)
    (let ((one (make-interval 1 1)))
        (div-interval one (add-interval (div-interval one r1)
            (div-interval one r2)
        ))
    )
)


;answer

All 3 problems point to the difficulty of "identity" when dealing with intervals. Suppose we have two numbers A and B which are contained in intervals:

  A = [2, 8]
  B = [2, 8]
A could be any number, such as 3.782, and B could be 5.42, but we just don't know.

Now, A divided by itself must be 1.0 (assuming A isn't 0), but of A/B (the same applies to subtraction) we can only say that it's somewhere in the interval

  [0.25, 4]
Unfortunately, our interval package doesn't say anything about identity, so if we calculated A/A, we would also get

  [0.25, 4]
So, any time we do algebraic manipulation of an equation involving intervals, we need to be careful any time we introduce the same interval (e.g. through fraction reduction), since our interval package re-introduces the uncertainty, even if it shouldn't.

So:

2.14. Lem just demonstrates the above.

2.15. Eva is right, since the error isn't reintroduced into the result in par2 as it is in par1.

2.16. A fiendish question. They say it's "very difficult" as if it's doable. I'm not falling for that. Essentially, I believe we'd have to introduce some concept of "identity", and then have the program be clever enough to reduce equations. Also, when supplying arguments to any equation, we'd need to indicate identity somehow, since [2, 8] isn't necessarily the same as [2, 8] ... unless it is. Capiche?



shyam

A better explanation and some pointers to the interesting world of interval arithmetic http://wiki.drewhess.com/wiki/SICP_exercise_2.16


voom4000

We have to leave the realm of interval arithmetic as soon as we start to talk about functions that have extrema somewhere inside intervals, or about functions like (A+B)/(A+C), which in principle cannot be reduced to the form with one occurrence of each variable. This is the meaning of dependency problem. By using interval arithmetic we will always get wrong results for such functions. We cannot find correct answers using interval arithmetic, but we can find them by using analytical or numerical methods, e.g. Monte Carlo method. It's the problem of finding global minimum of a function of several variables. I saw the proposal to use MC in Weiqun Zhang's blog (in fact it is a standard method of finding extrema for very complex functions). MC works even when all analytical methods fail. Dependency problem does not exist for these methods. For example, when you calculate A/A with Monte Carlo method, you just submit the same random value inside the interval to ALL occurrences of A in the formula, e.g. for A/A the value of the function will be 1, no matter how many random values you generate. Do not work with intervals that span zero if you want to get correct result for that formula. Then you take the min/max of all function values (all of them were 1), and voila, final result is 1 with ZERO TOLERANCE or zero width. Well, you could cancel numerator and denominator from the very beginning, MC and analytical methods allow it.


HannibalZ

This is just my intuition: I think it is impossible, just like (A*B)*C != A*(B*C) if * represents cross product.