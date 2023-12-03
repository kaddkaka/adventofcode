import std/strutils
import std/sets

type Pos = tuple[x, y: int]
var rope = newSeq[Pos](10)
template head: untyped = rope[0]
template tail: untyped = rope[^1]
var tail_visits = toHashSet([tail])

func dist(a, b: Pos): int = max(abs(a.x - b.x), abs(a.y - b.y))

for line in lines("input"):
  let n = parseInt(line[2..^1])
  for _ in countUp(1, n):
    if line[0] == 'D': dec head.y
    if line[0] == 'U': inc head.y
    if line[0] == 'L': dec head.x
    if line[0] == 'R': inc head.x

    for s in countUp(1, rope.high):
      if dist(rope[s], rope[s-1]) >= 2:
        if rope[s].x < rope[s-1].x: inc rope[s].x
        if rope[s].x > rope[s-1].x: dec rope[s].x
        if rope[s].y < rope[s-1].y: inc rope[s].y
        if rope[s].y > rope[s-1].y: dec rope[s].y
        if (s == rope.high):
          tail_visits.incl(tail)

echo "Tail visits: ", len(tail_visits)
