import std/strutils

proc signal_strength(): int =
  var cycle = 1
  var rX = 1

  for line in lines("input"):
    var c: seq[int]
    if line.startswith("addx"):
      c = @[0, parseInt(line[5..^1])]
    if line.startswith("noop"):
      c = @[0]

    for n in c:
      rX += n
      inc cycle
      if cycle in [20, 60, 100, 140, 180, 220]:
        echo "cycle", cycle, "rX", rX
        result += cycle * rX

echo "signal_strength", signal_strength()

var pos = 1

var c: string
func draw(c: var string, pos: int) =
  if abs((c.len mod 40) - pos) <= 1:
    c.add('#')
  else:
    c.add('.')

c.draw(pos)
for line in lines("input"):
  pos += 0
  c.draw(pos)
  if line.startswith("addx"):
    pos += parseInt(line[5..^1])
    c.draw(pos)

echo c[0..39]
echo c[40..79]
echo c[80..119]
echo c[120..159]
echo c[160..199]
echo c[200..239]
