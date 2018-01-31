import array

colors = ['black', 'white']
sizes = ['S', 'M', 'L']

tshirts = [(color, size) for size in sizes
                         for color in colors]
print(tshirts)


# generator expression
symbols = '$abcABC42'
print(tuple(ord(symbol) for symbol in symbols))

print(array.array('I', (ord(symbol) for symbol in symbols)))

for tshirt in ('%s %s' % (c, s) for c in colors for s in sizes):
    print(tshirt)