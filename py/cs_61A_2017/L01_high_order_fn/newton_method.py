'''
high order function notes
'''


def power(x, n):
    """Return x * x * x * ... * x for x repeated n times."""
    product, k = 1, 0
    while k < n:
        product, k = product * x, k + 1
    return product

def approx_eq(x, y, tolerance=1e-15):
    return abs(x - y) < tolerance


def newton_update(f, df):
    def update(x):
        return x - f(x) / df(x)
    return update

def improve(update, close, guess=1):
    while not close(guess):
        guess = update(guess)
    return guess

def find_zero(f, df):
    def near_zero(x):
        return approx_eq(f(x), 0)
    return improve(newton_update(f, df), near_zero)

def nth_root_of_a(n, a):
    def f(x):
        return power(x, n) - a
    def df(x):
        return n * power(x, n-1)
    return find_zero(f, df)

print('3rd root of 27', nth_root_of_a(3, 27))


'''
curring
'''


def curry2(f):
    """Return a curried version of the given two-argument function."""

    def g(x):
        def h(y):
            return f(x, y)

        return h

    return g

def uncurry2(g):
    """Return a two-argument version of the given curried function."""

    def f(x, y):
        return g(x)(y)

    return f


'''
lambda expression
'''

def compose1(f, g):
    return lambda x: f(g(x))


'''
decorator

 As usual, the function triple is created. However, the name triple is not bound to this function. Instead, the name triple is bound to the returned function value of calling trace on the newly defined triple function. In code, this decorator is equivalent to:

>>> def triple(x):
        return 3 * x
>>> triple = trace(triple)

'''

def trace(fn):
    def wrapped(x):
        print('-> ', fn, '(', x, ')')
        return fn(x)
    return wrapped

@trace
def triple(x):
    return 3 * x

triple(12)

'''
recursive function
'''

def sum_digits(n):
    '''Return the sum of the digits of positive integer n'''
    if n < 10:
        return n
    else:
        all_but_last, last = n // 10, n % 10
        return sum_digits(all_but_last) + last


def is_even(n):
    if n == 0:
        return True
    else:
        return is_odd(n - 1)

def is_odd(n):
    if n == 0:
        return False
    else:
        return is_even(n - 1)

def cascade(n):
    """Print a cascade of prefixes of n."""
    if n < 10:
        print(n)
    else:
        print(n)
        cascade(n // 10)
        print(n)

# until the return value appears, that call has not completed
cascade(2013)


def count_partitions(n, m):
    """Count the ways to partition n using parts up to m."""
    if n == 0:
        return 1
    elif n < 0:
        return 0
    elif m == 0:
        return 0
    else:
        return count_partitions(n - m, m) + count_partitions(n, m - 1)