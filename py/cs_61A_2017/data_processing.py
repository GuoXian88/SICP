# follow.py
#
# with a loop file


import os
import time

def follow(filename):
    f = open(filename, 'r')
    f.seek(0, os.SEEK_END)

    while True:
        line = f.readlines()
        if not line:
            time.sleep(0.1)
            continue    # Retry
        yield line      # Emit a line

for line in follow('Data/stocklog.csv'):
    print(line)