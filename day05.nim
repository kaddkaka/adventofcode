import std/strscans
import std/sugar
import std/math
import std/sequtils

type point = object
  x: int
  y: int

type dist = object
  dx: int
  dy: int

func `-`(p0: point, p1: point): dist =
  return dist(dx: p0.x-p1.x, dy: p0.y-p1.y)

func `+`(p: point, d: dist): point =
  return point(x: p.x+d.dx, y: p.y+d.dy)

type line = (point, point)

var lines: seq[line]
var max_coord: int = 0

for line in lines "day05.input":
  var x0, y0, x1, y1: int
  discard line.scanf("$i,$i -> $i,$i", x0, y0, x1, y1)
  lines.add((point(x: x0, y: y0), point(x: x1, y: y1)))
  max_coord = max([max_coord, x0, y0, x1, y1])

var grid: seq[seq[int]]
grid.newSeq(max_coord + 1)
for row in mitems grid:
  row.newSeq(max_coord + 1)

for line in lines:
  let (a, b) = line
  let diff = b - a

  var step: dist
  step = dist(dx: diff.dx.sgn, dy: diff.dy.sgn)

  # Skip lines that are not vertical/horizontal
  if step == dist(dx: 0, dy: 0): continue

  var walk = a
  while walk != (b + step):
    grid[walk.x][walk.y] += 1
    walk = walk + step

var total: int
for row in grid:
  total += row.foldl(a + int(b>1), 0)
dump total
