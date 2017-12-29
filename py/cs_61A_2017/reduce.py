
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

