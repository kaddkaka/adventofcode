import std/strscans

type pair = (int, int)

func contains(fst: pair, snd: pair): bool =
    return fst[0] <= snd[0] and fst[1] >= snd[1]

func overlaps(fst: pair, snd: pair): bool =
    return not (fst[1] < snd[0] or fst[0] > snd[1])

proc part1: int =
  for line in lines "input":
    var fst, snd: (int, int)
    assert scanf(line, "$i-$i,$i-$i", fst[0], fst[1], snd[0], snd[1])
    if fst.contains(snd):
      result += 1
    elif snd.contains(fst):
      result += 1

proc part2: int =
  for line in lines "input":
    var fst, snd: (int, int)
    assert scanf(line, "$i-$i,$i-$i", fst[0], fst[1], snd[0], snd[1])
    if fst.overlaps(snd):
      result += 1

echo "Part1: ", part1()
echo "Part2: ", part2()
