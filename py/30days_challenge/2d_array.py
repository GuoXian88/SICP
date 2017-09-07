'''
Sample Input

1 1 1 0 0 0
0 1 0 0 0 0
1 1 1 0 0 0
0 0 2 4 4 0
0 0 0 2 0 0
0 0 1 2 4 0
Sample Output

19
Explanation

 contains the following hourglasses:

1 1 1   1 1 0   1 0 0   0 0 0
  1       0       0       0
1 1 1   1 1 0   1 0 0   0 0 0

0 1 0   1 0 0   0 0 0   0 0 0
  1       1       0       0
0 0 2   0 2 4   2 4 4   4 4 0

1 1 1   1 1 0   1 0 0   0 0 0
  0       2       4       4
0 0 0   0 0 2   0 2 0   2 0 0

0 0 2   0 2 4   2 4 4   4 4 0
  0       0       2       0
0 0 1   0 1 2   1 2 4   2 4 0

'''

# -*- coding: utf-8 -*-
"""
input example:
1 2 3 4 5 6
6 5 4 3 2 1
1 1 1 1 1 1
1 1 1 1 1 1
2 2 2 2 2 2
3 3 3 3 3 3
"""
#!/bin/python3

import sys

arr = []
for arr_i in range(6):
   arr_t = [int(arr_temp) for arr_temp in input().strip().split(' ')]
   arr.append(arr_t)

'''
arr = [
        [1,1,1,1,1,1],
        [2,2,2,2,2,2],
        [3,3,3,3,3,3],
        [4,4,4,4,4,4],
        [5,5,5,5,5,5],
        [6,6,6,6,6,6]
]
'''
# sum array
sum_arr = []
# get hourGlasses method
# @start_index (0, 0)
# @size: size of hourglass
def get_hourglasses(matrix, start_index, size):
    matrix_size = len(matrix)
    hourGlasses = [row[start_index[0]:size+start_index[0]] for row in matrix]
    hourGlasses = hourGlasses[start_index[1]:size+start_index[1]]
    hourGlasses[1][0] = 0
    hourGlasses[1][2] = 0
    return hourGlasses

# iterate hourglasses to get corresponding matrix
def sum_of_hourGlasses(hourglass):
    sum = 0
    for row in hourglass:
        for element in row:
            sum += int(element)
    return sum
# iterate and push sum of hourglass to sum_arr
for i in range(4):
    for j in range(4):
        sum_arr.append(sum_of_hourGlasses(get_hourglasses(arr,(i,j), 3)))
    
print(max(sum_arr))
    