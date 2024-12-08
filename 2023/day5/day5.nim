import std/strutils
import std/sequtils
#import std/setutils
#import std/math
import std/enumerate
import std/strscans
import std/sugar

type Range = tuple[s: int, e: int]

let f = open("input")
var line = f.readline().split(":")[1]
echo "LINE:", line
var seeds = line.splitWhitespace.mapIt(it.parseInt).toSeq
let halfsize = int(len(seeds)/2)
var seed_ranges: seq[Range]

for i in countup(0, halfsize-1):
  seed_ranges.add((seeds[i*2], seeds[i*2+1]))
echo seed_ranges

discard f.readline(line)

func contains(r: Range, i: int): bool = i in r.s..<r.e
func domap(r: Range, dst: int, src: int , length: int): (seq[Range], seq[Range]) =
  let d = dst - src
  let e = src + length
  if src in r and e-1 in r:
    if src>r.s:
      result[0].add (r.s, src)
    result[1].add (src+d, e+d)
    if r.e > e:
      result[0].add (e, r.e)
    return result

  if src in r:
    if src > r.s:
      result[0].add (r.s, src)
    if r.e+d > src+d:
      result[1].add (src+d, r.e+d)
    return result

  if e-1 in r:
    if r.e > e:
      result[0].add (e, r.e)
    result[1].add (r.s+d, e+d)
    return result

  if src >= r.e or e < r.s:
    return (@[r], @[])
  return (@[], @[(r.s+d, r.e+d)])


while f.readline(line):
  var dest_start: string
  var source_start: string
  discard line.scanf("$w-to-$w map:", dest_start, source_start)

  var next: seq[Range] = @[]

  var maplines: seq[string]
  while f.readline(line):
    if line == "": break
    maplines.add(line)

  var r_remapped: seq[Range]
  for r_prev in seed_ranges:
    var r_unmapped = @[r_prev]
    for line in maplines
      var dst: int
      var src: int
      var length: int
      discard line.scanf("$i $i $i", dst, src, length)
      #seeds.mapIt(if it in src..<src+src+length: it + dst - src else: it)
      for r in r_unmapped:
        echo "mapping with", (dst, src, length)
        (r_unmapped, r_remapped) = domap(r, dst, src, length)
        echo "mapping range:", r_unmapped, " into: ", domap(r_unmapped, dst, src, length)
      next &= domap(r_unmapped, dst, src, length)
  seed_ranges = next
  echo seed_ranges

echo "Part1:", min(seed_ranges)
