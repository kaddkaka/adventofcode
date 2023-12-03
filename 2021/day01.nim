import strutils

var has_prev: bool = false
var prev: int = 0

var increments: int = 0

for line in lines "day01.input":
  if has_prev and prev < line.parseInt():
    inc increments
  else:
    has_prev = true
  prev = line.parseInt()

echo "Part 1: ", increments


import math
var slide: array[4, int]
var f: File
var line: string
var incs: int

if open(f, "day01.input"):
  slide[0] = f.readLine.parseInt()
  slide[1] = f.readLine.parseInt()
  slide[2] = f.readLine.parseInt()
  while f.readLine(line):
    slide[3] = line.parseInt()
    if slide[1..3].sum() > slide[0..2].sum():
      inc incs
    slide[0..2] = slide[1..3]

echo "Part 2: ", incs
