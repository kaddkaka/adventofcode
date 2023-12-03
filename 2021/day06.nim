import std/strutils
import std/sequtils
import std/sugar

type Fisharr = array[9, int]
var f: File
var fish: Fisharr
if open(f, "day06.input"):
  for n in f.readLine().split(',').map(parseInt):
    inc fish[n]

func next(fish: Fisharr): Fisharr =
  result[0..7] = fish[1..8]
  result[6] += fish[0]
  result[8] += fish[0]

for _ in 1..256:
  fish = next fish
dump fish.foldl(a + b)
