import std/[strutils, sequtils, sugar]

#[   aaaa            aaaa    aaaa
    b    c       c       c       c  b    c
    b    c       c       c       c  b    c
                     dddd    dddd    dddd
    e    f       f  e            f       f
    e    f       f  e            f       f
     gggg            gggg    gggg

     aaaa    aaaa    aaaa    aaaa    aaaa
    b       b            c  b    c  b    c
    b       b            c  b    c  b    c
     dddd    dddd            dddd    dddd
         f  e    f       f  e    f       f
         f  e    f       f  e    f       f
     gggg    gggg            gggg    gggg   ]#

type Segment = 0..6

let digits = [
  {0.Segment, 1, 2, 4, 5, 6},
  {2.Segment, 5},
  {0.Segment, 2, 3, 4, 6},
  {0.Segment, 2, 3, 5, 6},
  {1.Segment, 2, 3, 5},

  {0.Segment, 1, 3, 5, 6},
  {0.Segment, 1, 3, 4, 5, 6},
  {0.Segment, 2, 5},
  {0.Segment, 1, 2, 3, 4, 5, 6},
  {0.Segment, 1, 2, 3, 5, 6},
]

var tot = 0
for line in lines "day08.input":
  let inout = line.split('|')
  let ins = inout[0].splitWhitespace()
  let outs = inout[1].splitWhitespace()
  tot += outs.countIt(it.len() in {2, 3, 4, 7 })

  var candidates: array['a'..'g', set[Segment]]
  for c in mitems candidates:
    c = {0.Segment..6.Segment}

  for i in ins:
    #if i.len notIn {2, 3, 4, 7}: continue
    var panels: set[Segment]
    for d in digits:
      if d.card == i.len:
        panels = panels + d

    for c in 'a'..'g':
      if c in i:
        candidates[c] = candidates[c] * panels
      else:
        candidates[c] = candidates[c] - panels
  dump candidates

  var outDigits: seq[int]
  for o in outs:
    var panels: set[Segment]
    for c in o:
      panels = panels + candidates[c]
    dump panels
    for i, d in digits:
      if d == panels:
        outDigits.add(i)
  dump outDigits
  break

dump tot
