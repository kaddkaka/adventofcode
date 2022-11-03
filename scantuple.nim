import std/strscans

let line = "1,5 -> 11,15"
let (_, x1, y1, x2, y2) = line.scanTuple("$i,$i$s->$s$i,$i")
echo x1+y1+x2+y2
