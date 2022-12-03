import std/sequtils
import std/setutils

let prio_seq = toSeq('a'..'z') & toSeq('A'..'Z')

proc part1: int =
  for line in lines "input":
    let pivot = len(line) div 2
    let fst = line[0..<pivot]
    let snd = line[pivot..^1]
    for dupe in toSet(fst) * toSet(snd):
      result += prio_seq.find(dupe) + 1


proc part2: int =
  var f: File
  var fst, snd, trd: string


  if f.open "input":
    while f.readline(fst):
     discard f.readline(snd)
     discard f.readline(trd)
     for common in toSet(fst) * toSet(snd) * toSet(trd):
       result += prio_seq.find(common) + 1

echo part1()
echo part2()
