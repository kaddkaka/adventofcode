import std/strutils
import std/sequtils
import std/setutils
import std/math
import std/enumerate

func num_hits(line: string): int =
  let numbers =  line.split(':')[1].split('|')
  let draw = numbers[0].splitWhitespace.mapIt(it.parseInt.int8).toSet
  let lott = numbers[1].splitWhitespace.mapIt(it.parseInt.int8)

  var hits = 0
  for d in draw:
    hits += int(lott.contains(d))
  return hits

func points(hits: int): int =
  case hits:
    of 0: 0
    else: 2 ^ (hits-1)

echo "Part1:", lines("input").toSeq.foldl(a + num_hits(b).points, 0)

import tables

var copies = initCountTable[int]()
var last: int
for i, line in enumerate lines("input"):
  copies.inc(i)  # 1 original of each card

  let hits = num_hits(line)
  for n in i+1 ..< i+1+hits:
    copies.inc(n, copies[i])
  last = i

echo "Last i: ", last

var total = 0
for k, v in enumerate(copies.values):
  echo "k,v:", k, ", ", v
  total += v
  if k == last:
    break
echo "Part2:", total
