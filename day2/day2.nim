import std/strscans

var points = 0

for line in lines "input":
  # A < B < C
  # X < Y < Z
  # 1   2   3
  # 0   3   6
  var other, self: char
  assert scanf(line, "$c $c", other, self)
  points += " XYZ".find(self)
  if other & self in @["AX", "BY", "CZ"]:
    points += 3
  if other & self in @["AY", "BZ", "CX"]:
    points += 6

echo points

proc part2: int =
  for line in lines "input":
    # A < B < C
    # 1   2   3
    #
    # X - lose 0
    # Y - draw 3
    # Z - win  6
    var other, strat: char
    assert scanf(line, "$c $c", other, strat)

    let diff = "XYZ".find(strat)
    result += 3 * diff

    let base = "ABC".find(other)
    var val = base + diff
    while val < 1: val += 3
    while val > 3: val -= 3

    result += val

echo part2()
