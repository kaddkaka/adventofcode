iterator iota(n: int): int =
  for i in 0..<n: yield i

template toSeq2[T](a: iterable[T]): seq[T] =
  var ret: seq[T]
  assert a.typeof is T
  for ai in a: ret.add ai
  ret

assert iota(3).toSeq2 == @[0, 1, 2]
assert toSeq2(5..7) == @[5, 6, 7]
assert not compiles(toSeq2(@[1,2])) # seq[int] is not an iterable
assert toSeq2(items(@[1,2])) == @[1, 2] # but items(@[1,2]) is
