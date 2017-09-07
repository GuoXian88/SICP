#!/bin/python3

import sys


S = input().strip()

try:
    str = int(S)
    print(str)
except:
    print('Bad String')