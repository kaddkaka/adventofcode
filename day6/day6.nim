import std/enumerate
import std/setutils


proc how_many(n: int): int =
  var prev: seq[char]
  prev.setLen(n)

  for line in lines "input":
    for i, char in enumerate line:
      prev[i mod n] = char
      if i > 3 and toSet(prev).len == n:
        return i + 1

echo how_many(4)
echo how_many(14)
