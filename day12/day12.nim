import std/heapqueue

type HeightMap = seq[string]
func w(h: HeightMap): int = h[0].len
func h(h: HeightMap): int = h.len
var hmap: HeightMap

type Point = tuple[x, y: int]
type Map[N: static[int], T] = array[N, array[N, T]]
type Position = tuple[height: char, dist: int, point: Point]
func `<`(a, b: Position): bool =
  if a.dist == b.dist:
    return a.height > b.height  # search uphill
  return a.dist < b.dist

proc `[]`(xs: HeightMap, p: Point): char = xs[p.y][p.x]
proc `[]`[T](xs: openarray[openarray[T]], p: (int, int)): T = xs[p[0]][p[1]]
proc `[]`[N, T](xs: Map[N, T], p: Position): T = xs[p.point.x][p.point.y]
proc `[]=`[N, T](xs: var Map[N, T], p: Position, v: T): void = xs[p.point.x][p.point.y] = v

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

iterator neighbors(m: HeightMap, p: Point): Point =
  # Yield all neighbors still inside the map
  if (p.x+1) < m.w: yield (p.x+1, p.y)
  if (p.x-1) >= 0:  yield (p.x-1, p.y)
  if (p.y+1) < m.h: yield (p.x  , p.y+1)
  if (p.y-1) >= 0:  yield (p.x  , p.y-1)

iterator neighbors(hmap: HeightMap, pos: Position): Position =
  # Yield all neighbors reachable given heigh restriction
  for n in hmap.neighbors(pos.point):
    let new_height: char = hmap[n]
    if new_height.ord <= pos.height.ord + 1:
      yield (new_height, pos.dist + 1, n)

for l in hmap:
  echo l

proc calc(hmap: HeightMap, start: Point, goal: Point): int =
  var visitted: Map[100, bool]
  let s: Position = ('a', 0, start)
  var openList = [s].toHeapQueue()

  while (openList.len > 0):
    let pos = openList.pop
    if pos.point == goal:
      return pos.dist
    visitted[pos] = true

    for n in hmap.neighbors(pos):
      if visitted[n] == false:
        openList.push(n)

echo calc(hmap, start, goal)
