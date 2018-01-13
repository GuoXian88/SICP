
'''
The purpose of Number is not to be instantiated directly,
but instead to serve as a superclass of various specific number
classes. Our next task is to define add and mul appropriately for complex numbers.
'''
from math import atan2, sin, cos, pi


class Number:
    def __add__(self, other):
        return self.add(other)
    def __mul__(self, other):
        return self.mul(other)

class Complex(Number):
    def add(self, other):
        return ComplexRI(self.real + other.real, self.imag + other.imag)
    def mul(self, other):
        return ComplexMA(self.magnitude * other.magnitude, self.angle + other.angle)

'''
Interfaces. Object attributes, which are a form of message passing,
allows different data types to respond to the same message in different ways.
A shared set of messages that elicit similar behavior from different classes
is a powerful method of abstraction. An interface is a set of shared attribute names,
 along with a specification of their behavior. In the case of complex numbers,
 the interface needed to implement arithmetic consists of four attributes:
 real, imag, magnitude, and angle.
 '''


class ComplexRI(Complex):
    def __init__(self, real, imag):
        self.real = real
        self.imag = imag
    @property
    def magnitude(self):
        return (self.real ** 2 + self.imag ** 2) ** 0.5
    @property
    def angle(self):
        return atan2(self.imag, self.real)
    def __repr__(self):
        return 'ComplexRI({0:g}, {1:g})'.format(self.real, self.imag)


class ComplexMA(Complex):
    def __init__(self, magnitude, angle):
        self.magnitude = magnitude
        self.angle = angle

    @property
    def real(self):
        return self.magnitude * cos(self.angle)

    @property
    def imag(self):
        return self.magnitude * sin(self.angle)

    def __repr__(self):
        return 'ComplexMA({0:g}, {1:g} * pi)'.format(self.magnitude, self.angle / pi)

ri = ComplexRI(5, 12)
ma = ComplexMA(2, pi/2)
print(ri.magnitude)

