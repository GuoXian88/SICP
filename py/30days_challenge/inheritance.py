'''
class MySubclass extends MySuperclass{
    MySubclass(String myString){
        // behind-the-scenes implicit call to superclass' default constructor happens
        
        // subclass can now initialize superclass instance variable:
        this.myString = myString; 
    }
}
the reason why this works is because it's inherited from MySuperclass and therefore can be accessed with the this keyword. 
Note: If a superclass does not have a default constructor, any subclasses extending it must make an explicit call to one of the superclass' parameterized constructors. 

'''


class Person:
	def __init__(self, firstName, lastName, idNumber):
		self.firstName = firstName
		self.lastName = lastName
		self.idNumber = idNumber
	def printPerson(self):
		print("Name:", self.lastName + ",", self.firstName)
		print("ID:", self.idNumber)

class Student(Person):
    #   Class Constructor
    #   
    #   Parameters:
    #   firstName - A string denoting the Person's first name.
    #   lastName - A string denoting the Person's last name.
    #   id - An integer denoting the Person's ID number.
    #   scores - An array of integers denoting the Person's test scores.
    #
    # Write your constructor here
    def __init__(self, firstName, lastName, idNumber, scores):
    	super().__init__(firstName, lastName, idNumber)
        self.scores = scores

    #   Function Name: calculate
    #   Return: A character denoting the grade.
    #
    # Write your function here
    def calculate(self):
        average = sum(self.scores)/len(self.scores)
        grade = 'T'
        if average >= 90 and average <=100:
            grade = 'O'
        if average >= 80 and average <90:
            grade = 'E'
        if average >= 70 and average <80:
            grade = 'A'
        if average >= 55 and average <70:
            grade = 'P'
        if average >= 40 and average <55:
            grade = 'D'
        if average < 40:
            grade = 'T'
        return grade

line = input().split()
firstName = line[0]
lastName = line[1]
idNum = line[2]
numScores = int(input()) # not needed for Python
scores = list( map(int, input().split()) )
s = Student(firstName, lastName, idNum, scores)
s.printPerson()
print("Grade:", s.calculate())
