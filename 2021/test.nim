import std/strutils
import std/bitops
import std/enumerate

block numeric_literals:
  func `'bround`(n: string; bits: int): int =
    var number = parseInt(n)
    let alignment = 1 shl bits
    let half_align = alignment shr 1

    number += half_align

    let lsb_mask = alignment - 1
    return number.masked(bitnot lsb_mask)

  assert 7'bround(4) == 0
  assert 8'bround(4) == 16

var numbers = @[(1, 2), (5, 7), (15, 18)]
for i, (n, m) in enumerate(numbers.mpairs):
  echo i, ": ", n, ", ", m
