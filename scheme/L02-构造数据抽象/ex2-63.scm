;self


;answer

a. Both procedures produce the same result because they both are in-order traversals.
b. Let T(n) be the time taken by the procedure for a balanced tree with n nodes.
For tree->list-1: 
T(n) = 2*T(n/2) + O(n/2) (as the procedure append takes linear time)
Solving above equation, we get T(n) = O(n * log n)
For tree->list-2:
T(n) = 2*T(n/2) + O(1)
Solving the above equation, we get T(n) = O(n)