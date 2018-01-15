
from operator import mul

def reduce(reduce_fn, s, initial):
    reduced = initial
    for x in s:
        reduced = reduce_fn(reduced, x)
    return reduced

print(reduce(mul, [2,3,4], 1))


'''
sequence tree
'''

def tree(root, branches=[]):
    for branch in branches:
        assert is_tree(branch), 'branches must be trees'
    return [root] + list(branches)

def root(tree):
    return tree[0]


def branches(tree):
    return tree[1:]

def is_tree(tree):
    if type(tree) != list or len(tree) < 1:
        return False
    for branch in branches(tree):
        if not is_tree(branch):
            return False
    return True

def is_leaf(tree):
    return not branches(tree)


t = tree(3, [tree(1), tree(2, [tree(1), tree(1)])])


def fib_tree(n):
    if n == 0 or n == 1:
        return tree(n)
    else:
        left, right = fib_tree(n-2), fib_tree(n-1)
        fib_n = root(left) + root(right)
        return tree(fib_n, [left, right])

print(fib_tree(5))


def count_leaves(tree):
    if is_leaf(tree):
        return 1
    else:
        branch_counts = [count_leaves(branch) for branch in branches(tree)]
        return sum(branch_counts)

print(count_leaves(fib_tree(5)))

'''
Partition trees. Trees can also be used to represent the partitions of an integer. 
A partition tree for n using parts up to size m is a binary (two branch) tree that 
represents the choices taken during computation. In a non-leaf partition tree:

the left (index 0) branch contains all ways of partitioning n using at least one m,
the right (index 1) branch contains partitions using parts up to m-1, and
the root value is m.
The values at the leaves of a partition tree express whether the path from the root
 of the tree to the leaf represents a successful partition of n.
'''
def partition_tree(n, m):
    """
        Return a partition tree of n using parts of up to m
    """
    if n == 0:
        return tree(True)
    elif n <0 or m == 0:
        return tree(False)
    else:
        left = partition_tree(n-m, m)
        right = partition_tree(n, m-1)
        return tree(m, [left, right])


print(partition_tree(2, 2))



'''
mutable link
'''

def mutable_link():
    '''Return a functional implementation of a mutable linked list.'''
    contents = empty
    def dispatch(message, value=None):
        nonlocal contents
        if message == 'len':
            return len_link(contents)
        elif message == 'getitem':
            return getitem_link(contents, value)
        elif message == 'push_first':
            return link(value, contents)
        elif message == 'pop_first':
            f = first(contents)
            contents = rest(contents)
            return f
        elif message == 'str':
            return join_link(contents, ', ')
    return dispatch


def to_mutable_link(source):
    """Return a functional list with the same contents as source."""
    s = mutable_link()
    for elem in reversed(source):
        s('push_first', element)
    return s


def dictionary():
    """Return a functional implementation of a dictionary."""
    records = []
    def getitem(key):
        matches = [r for r in records if r[0] == key]:
        if len(matches) == 1:
            key, value = matches[0]
            return value
    def setitem(key, value):
        nonlocal records
        non_matches = [r for r in records if r[0] != key]
        records = non_matches + [[key, value]]
    def dispatch(message, key=None, value=None):
        if message == 'getitem':
            return getitem(key)
        elif message == 'setitem':
            return setitem(key, value)
    return dispatch
