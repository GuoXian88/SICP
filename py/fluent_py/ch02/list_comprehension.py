symbols = '$abcABC'
# ord get ascii code of character
codes = [ord(symbol) for symbol in symbols]
print(codes)

beyond_ascii = [ord(s) for s in symbols if ord(s) > 90]
print(beyond_ascii)

beyond_ascii_use_map_filter = list(filter(lambda c: c>90, map(ord, symbols)))
print(beyond_ascii_use_map_filter)