'''
If an exception is not caught by the method that threw it, the program's control is transferred back (propagated) to the calling method (i.e.: whatever called the method that threw the exception). This can be good if you have designed your program to handle exceptions at a high level, but bad if you never write code to catch the exception in the calling methods that the exception is being propagated to. 
'''

class Calculator:
    def __init__(self):
        pass
    def power(self, n, p):
        if n < 0 or p < 0:
            raise ValueError('n and p should be non-negative')
        return n**p

myCalculator=Calculator()
T=int(input())
for i in range(T):
    n,p = map(int, input().split())
    try:
        ans=myCalculator.power(n,p)
        print(ans)
    except Exception as e:
        print(e)   
