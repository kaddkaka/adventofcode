import std/[sequtils, parseutils, strutils]

var crabs: seq[int]

var f: File
if open(f, "day07.input"):
  crabs = f.readLine().split(',').map(parseInt)

var dist: seq[int]
for idx in 0..max(crabs):
  dist.add(crabs.foldl(a + abs(idx - b), 0))
echo "Part 1: ", dist.min

func tri(n: int): int = n * (n + 1) div 2

var cost: seq[int]
for idx in 0..max(crabs):
  cost.add(crabs.foldl(a + tri(abs(idx - b)), 0))
echo "Part 2: ", cost.min
