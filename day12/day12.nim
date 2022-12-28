import std/heapqueue

type HeightMap = seq[string]
func w(h: HeightMap): int = h[0].len
func h(h: HeightMap): int = h.len
var hmap: HeightMap

type Point = tuple[x, y: int]
type Map[N: static[int], T] = array[N, array[N, T]]
type Position = tuple[height: char, dist: int, point: Point]
func `<`(a, b: Position): bool = a.dist < b.dist

proc `[]`(xs: HeightMap, p: Point): char = xs[p.y][p.x]
proc `[]`[T](xs: openarray[openarray[T]], p: (int, int)): T = xs[p[0]][p[1]]
proc `[]`[N, T](xs: Map[N, T], p: Position): T = xs[p.point.x][p.point.y]
template `[]=`[N, T](xs: var Map[N, T], p: Position, v: T): void = xs[p.point.x][p.point.y] = v

var start: Point
var goal: Point

var line_no = 0

for line in lines("input"):
  var mline = line

  let spos = line.find('S')
  if spos >= 0:
    start = (spos, line_no)
    mline[spos] = 'a'

  let gpos = line.find('E')
  if gpos >= 0:
    goal = (gpos, line_no)
    mline[gpos] = 'z'

  hmap.add(mline)
  inc line_no

var visitted: Map[133, bool]

echo "hmap:", hmap.len, " * ", hmap[0].len
echo "visitted:", visitted.len, " * ", visitted[0].len

proc calc(hmap: HeightMap, start: Point, goal: Point): int =
  let s: Position = ('a', 0, start)
  var openList = [s].toHeapQueue()
  visitted[s] = true

  while (openList.len > 0):
    let pos = openList.pop
    if pos.point == goal:
      return pos.dist
    echo pos

    let p = pos.point
    for n in [(p.x+1, p.y), (p.x-1, p.y), (p.x  , p.y+1), (p.x  , p.y-1)]:
      if n[0] >= 0 and n[1] >= 0 and n[0] < hmap.w and n[1] < hmap.h:
        let new_height: char = hmap[n]
        if new_height.ord <= pos.height.ord + 1:
          let new_pos: Position = (new_height, pos.dist + 1, n)

          if visitted[new_pos] == false:
            visitted[new_pos] = true
            openList.push(new_pos)

  echo "No path found!"
  return -1

echo "CALC:", calc(hmap, start, goal)
