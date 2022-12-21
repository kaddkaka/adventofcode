import std/sugar
import std/sequtils
import std/math

type Map = seq[string]
type Pos = tuple[x, y: int]

func h(m: Map): int = m.high
func w(m: Map): int = m[0].high

func `[]`(m: Map, p: Pos): char =
  return m[p.x][p.y]

func inside(p: Pos, m: Map): bool =
  return (p.x in 0..m.w and p.y in 0..m.h)

let map: Map = toSeq(lines("input"))

iterator walk(m: Map, start: Pos, move: Pos->Pos): Pos =
  var other = start
  while (other = other.move; other.inside(m)):
    yield other

func visible(map: Map, start: Pos, move: Pos->Pos): bool =
  walk(map, start, move).toSeq.allIt(map[start] > map[it])

func count(map: Map, start: Pos, move: Pos->Pos): int =
  for other in walk(map, start, move):
    inc result
    if map[start] <= map[other]:
      break

func left  (p: Pos): Pos = (p.x-1, p.y  )
func right (p: Pos): Pos = (p.x+1, p.y  )
func up    (p: Pos): Pos = (p.x  , p.y-1)
func down  (p: Pos): Pos = (p.x  , p.y+1)
let all_directions = @[left, right, up, down]

var num_visible = 0
var best_view = 0

for y in countUp(0, map.h):
  for x in countUp(0, map.w):
    let view = prod mapIt(all_directions, count(map, (x, y), it))
    best_view = max(best_view, view)
    if all_directions.anyIt(visible(map, (x, y), it)): inc num_visible

echo "visible": num_visible
echo "best view": best_view
