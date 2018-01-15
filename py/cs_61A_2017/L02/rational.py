'''
This dictionary-based approach to type dispatching
'''
from math import pi
def add_complex_and_rational(c, r):
    return ComplexRI(c.real + r.numer/r.denom, c.imag)

def add_rational_and_complex(r, c):
    return add_complex_and_rational(c, r)
def mul_rational_and_complex(r, c):
    return mul_complex_and_rational(c, r)
def mul_complex_and_rational(c, r):
    r_magnitude, r_angle = r.numer/r.denom, 0
    if r_magnitude < 0:
        r_magnitude, r_angle = -r_magnitude, pi
    return ComplexMA(c.magnitude * r_magnitude, c.angle + r_angle)

class Number:
    def __add__(self, other):
        if self.type_tag == other.type_tag:
            return self.add(other)
        elif (self.type_tag, other.type_tag) in self.adders:
            return self.cross_apply(other, self.adders)
    def __mul__(self, other):
        if self.type_tag == other.type_tag:
            return self.mul(other)
        elif (self.type_tag, other.type_tag) in self.multipliers:
            return self.cross_apply(other, self.multipliers)
    def cross_apply(self, other, cross_fns):
        cross_fn = cross_fns[(self.type_tag, other.type_tag)]
        return cross_fn(self, other)
    adders = {("com", "rat"): add_complex_and_rational,
                ("rat", "com"): add_rational_and_complex}
    multipliers = {("com", "rat"): mul_complex_and_rational,
                    ("rat", "com"): mul_rational_and_complex}


print(ComplexRI(1.5, 0) + Rational(3, 2))
print(Rational(-1, 2) * ComplexMA(4, pi/2))

'''
强制类型转换
Often the different data types are not completely independent, and there may be ways by which objects of one type may be viewed as being of another type. This process is called coercion.
转换dictionary
The coercions dictionary indexes all possible coercions by a pair of type tags, indicating that the corresponding value coerces a value of the first type to a value of the second type.
'''


def rational_to_complex(r):
    return ComplexRI(r.number/r.denom, 0)

class NumberCoerce:
    def __add__(self, other):
        x, y = self.coerce(other)
        return x.add(y)
    def __mul__(self, other):
        x, y = self.coerce(other)
        return x.mul(y)
    def coerce(self, other):
        if self.type_tag == other.type_tag:
            return self, other
        elif (self.type_tag, other.type_tag) in self.coercions:
            return (self.coerce_to(other.type_tag), other)
        elif (other.type_tag, self.type_tag) in self.coercions:
            return (self, other.coerce_to(self.type_tag))
    def coerce_to(self, other_tag):
        coercion_fn = self.coercions[(self.type_tag, other_tag)]
        return coercion_fn(self)
    coercions = {('rat', 'com'): rational_to_complex}

# good idea: Some more sophisticated coercion schemes do not just try to coerce one type into another, but instead may try to coerce two different types each into a third common type. 
# Python had a __coerce__ special method on objects.