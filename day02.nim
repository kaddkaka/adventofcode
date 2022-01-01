import strscans

var x = 0
var y = 0
var aim: int = 0

for line in lines "day02.input":
  var dir: string
  var dist: int
  discard line.scanf("$w $i", dir, dist)

  case dir
  of "forward":
    x += dist
    y += aim * dist
  of "down":
    aim += dist
  of "up":
    aim -= dist

echo "Part  2: ", x * y
