import strutils
import std/heapqueue

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
  var elves = [0, 0, 0].toHeapQueue

  var tot = 0
  for line in lines "input":
    if line == "":
      discard elves.pushpop(tot)
      tot = 0
    else:
      tot += line.parseInt()

  echo "Part 2: ", elves.pop + elves.pop + elves.pop

part2()
