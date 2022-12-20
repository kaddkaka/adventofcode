import std/setutils


proc how_many(n: int): int =
  let f = open("input")
  let line = f.readline()
  for i in 0..line.high:
    if toSet(line[i..<i+n]).len == n:
        return i + n - 1

echo how_many(4)
echo how_many(14)
