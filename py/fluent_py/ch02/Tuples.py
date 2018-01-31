city, year, pop, chg, area = ('Tokyo', 2003, 32450, 0.66, 8014)
traveler_ids = [('USA','31195855'), ('BRA', 'CE34323223'),('ESP', 'XDA211212')]
# unpacking tuples
for passport in sorted(traveler_ids):
    print('%s %s' % passport)

print(divmod(20,8))
t = (20,8)
print(divmod(*t))
quotient, remainder = divmod(*t)
print(quotient, remainder)