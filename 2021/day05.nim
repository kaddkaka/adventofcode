import std/[strscans, sugar, math, sequtils]

type point = object
  x, y: int

type dist = object
  dx, dy: int

func `-`(p0: point, p1: point): auto = dist(dx: p0.x-p1.x, dy: p0.y-p1.y)
func `+`(p:  point, d:  dist):  auto = point(x: p.x+d.dx, y: p.y+d.dy)

type line = (point, point)

var lines: seq[line]
var max_coord: int = 0

for line in lines "day05.input":
  var (_, x0, y0, x1, y1) = line.scanTuple("$i,$i -> $i,$i")
  lines.add (point(x: x0, y: y0), point(x: x1, y: y1))
  max_coord = max([max_coord, x0, y0, x1, y1])

var grid: seq[seq[int]]
grid = newSeqWith(max_coord + 1, newSeq[int](max_coord + 1))

for line in lines:
  let (start, goal) = line
  let diff = goal - start
  let step = dist(dx: diff.dx.sgn, dy: diff.dy.sgn)

  var walk = start
  while walk != (goal + step):
    grid[walk.x][walk.y] += 1
    walk = walk + step

iterator flatten[T](s: seq[seq[T]]): T =
  for row in s:
    for col in row:
      yield col

let total = grid.flatten.countIt(it>1)
dump total
