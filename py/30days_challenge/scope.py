'''
class MyClass{
    private int myInt;
    
    public MyClass(int myInt){
    	this.myInt = myInt;
    }
}

Even though there is a myInt field in the class, the constructor has a completely different myInt parameter. The field (this.myInt) is then assigned the value of the parameter, so any argument passed as that parameter will initialize the myInt field in the class. 
'''

class Difference:
    def __init__(self, a):
        self.__elements = a
        self.maximumDifference = 0
    # Add your code here
    def computeDifference(self):
        res = []
        for passnum in range(len(self.__elements)-1,0,-1):
            for i in range(passnum):
                res.append(abs(self.__elements[passnum] - self.__elements[i]))
        self.maximumDifference = max(res)



# End of Difference class

_ = input()
a = [int(e) for e in input().split(' ')]

d = Difference(a)
d.computeDifference()

print(d.maximumDifference)