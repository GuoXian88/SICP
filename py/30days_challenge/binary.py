#!/bin/python3

import sys


n = int(input().strip())

def d_to_r(num):
    res_string = ''
    while num > 0:
        res_string += str(num % 2)
        num = num // 2
    return res_string

res = d_to_r(n)

def calc_serious_ones(res):
    sequence_ones = 0
    count = 0
    prev = '1'

    for i in range(len(res)):
        if res[i] == '1' and prev == '1':
            count = count + 1
        else:
            if count > sequence_ones:
                sequence_ones = count
            count = 0
        prev = res[i]
    return sequence_ones

print(calc_serious_ones(res))
        
