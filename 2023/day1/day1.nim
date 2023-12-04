
import options
import strutils
#import std/heapqueue

#type Triplet = tuple[sum, first, last: int]

var sum = 0

for line in lines "input":
  var first: Option[char] = none(char)
  var last: Option[char] = none(char)
  for char in line:
    if char.isDigit():
      if first.isNone:
        first = some(char)
      last = some(char)

  let number: string = first.get & last.get
  sum += (number).parseInt()


echo "Part 1: " & $sum
