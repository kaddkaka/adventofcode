import std/strscans

type pair = (int, int)
func range(input: string, match: var pair, start: int): int =
  let substr = input[start .. ^1]
  if scanf(substr, "$i-$i", match[0], match[1]):
    let div_pos = substr.find(',')
    if div_pos == -1:
      return len input
    else:
      return div_pos
  else: return 0

func contains(fst: pair, snd: pair): bool =
    return fst[0] <= snd[0] and fst[1] >= snd[1]

proc part1: int =
  for line in lines "input":
    var fst, snd: (int, int)
    assert scanf(line, "${range},${range}", fst, snd)
    if fst.contains(snd) or snd.contains(fst):
      result += 1

func overlaps(fst: pair, snd: pair): bool =
    return not (fst[1] < snd[0] or fst[0] > snd[1])

proc part2: int =
  for line in lines "input":
    var fst, snd: (int, int)
    assert scanf(line, "${range},${range}", fst, snd)
    if fst.overlaps(snd):
      result += 1

echo "Part1: ", part1()
echo "Part2: ", part2()
