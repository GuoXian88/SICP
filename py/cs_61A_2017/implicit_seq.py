'''
A sequence can be represented without each element being stored explicitly in the memory of the computer. That is, we can construct an object that provides access to all of the elements of some sequential dataset without computing all of those elements in advance and storing them. Instead, we compute elements on demand.
lazy computation describes any program that delays the computation of a value until that value is needed.

'''


class LetterIter:
    """An iterator over letters of the alphabet in ASCII order."""
    def __init__(self, start='a', end='e'):
        self.next_letter = start
        self.end = end
    def __next__(self):
        if self.next_letter == self.end:
            raise StopIteration
        letter = self.next_letter
        self.next_letter = chr(ord(letter)+1)
        return letter


class Positives:
    def __init__(self):
        self.next_positive = 1
    def __next__(self):
        result = self.next_positive
        self.next_positive += 1
        return result


class Letters:
    def __init__(self, start='a', end='e'):
        self.start = start
        self.end = end
    def __iter__(self):
        return LetterIter(self.start, self.end)


'''
When called, a generator function doesn't return a particular yielded value, but instead a generator (which is a type of iterator) that itself can return the yielded values. A generator object has __iter__ and __next__ methods, and each call to __next__ continues execution of the generator function from wherever it left off previously until another yield statement is executed.

The __iter__ method is a generator function; it returns a generator object that yields the letters 'a' through 'd' and then stops. Each time we invoke this method, a new generator starts a fresh pass through the sequential data.

'''
def letters_generator():
    current = 'a'
    while current <= 'd':
        yield current
        current = chr(ord(current)+1)

def all_pairs(s):
    for item1 in s:
        for item2 in s:
            yield (item1, item2)


class LettersWithYield:
    def __init__(self, start='a', end='e'):
        self.start = start
        self.end = end
    def __iter__(self):
        next_letter = self.start
        while next_letter < self.end:
            yield next_letter
            next_letter = chr(ord(next_letter)+1)


'''
stream
Streams offer another way to represent sequential data implicitly. A stream is a lazily computed linked list. Like the Link class from Chapter 2, a Stream instance responds to requests for its first element and the rest of the stream.
Unlike an Link, the rest of a stream is only computed when it is looked up, rather than being stored in advance. That is, the rest of a stream is computed lazily.
'''

class Stream:
    """A lazily computed linked list."""
    class empty:
        def __repr__(self):
            return 'Stream.empty'
    empty = empty()
    def __init__(self, first, compute_rest=lambda: empty):
        assert callable(compute_rest), 'compute_rest must be callable.'
        self.first = first
        self._compute_rest = compute_rest
    @property
    def rest(self):
        """Return the rest of the stream, computing it if necessary."""
        if self._compute_rest is not None:
            self._rest = self._compute_rest()
            self._compute_rest = None
        return self._rest
    def __repr__(self):
        return 'Stream({0}, <...>)'.format(repr(self.first))
    

s = Stream(1, lambda: Stream(2+3, lambda: Stream(9)))

print(s, s.first, s.rest.first, s.rest)

'''
Lazy evaluation gives us the ability to represent infinite sequential datasets using streams. 
'''

def integer_stream(first):
    def compute_rest():
        return integer_stream(first+1)
    return Stream(first, compute_rest)

positives = integer_stream(1)

print(positives, positives.first, positives.rest, positives.rest.rest)