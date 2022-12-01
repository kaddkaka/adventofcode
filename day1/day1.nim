import strutils
import algorithm
import math

var heavy_lifter = 0
var tot = 0

for line in lines "input":
  if line == "":
    if tot > heavy_lifter:
      heavy_lifter = tot
    tot = 0
  else:
    tot += line.parseInt()

if tot > heavy_lifter:
  heavy_lifter = tot

echo "Part 1: ", heavy_lifter


proc part2 =
  var elves: seq[int]
  var tot = 0

  for line in lines "input":
    if line == "":
      elves.add(tot)
      tot = 0
    else:
      tot += line.parseInt()

  sort elves
  echo "Part 2: ", sum elves[^3..^1]

part2()
