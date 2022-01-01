import parseutils
import sugar
import bitops

proc getNumbers() : set[int16] =
  var n: int16
  for line in lines "day03.input":
    discard line.parseBin(n)
    result.incl n

func peek*[T](s : set[T]) : T =
  for n in s: return n

func bit(n, bit: int) : int = return n.bitsliced(bit..bit)
func mostCommonBit(numbers: set[int16], bit: int): int =
  var ones = 0
  for n in numbers:
    ones += n.bit(bit)

  let tot = card numbers
  if ones * 2 >= tot:
    return 1
  return 0

let allNumbers = getNumbers()
let f = open("day03.input")
let length = len f.readline()

proc part1() : int =
  var ones: seq[int]

  for i in 0..<length:
    ones.add(mostCommonBit(allNumbers, i))

  var gamma, epsilon: int
  for i, one in ones:
    if one == 1:
      gamma += 1 shl i
    elif one == 0:
      epsilon += 1 shl i
    else:
      assert false, "Ooops!"

  dump gamma
  dump epsilon
  result = gamma * epsilon
  echo "Part 1: ", result

# Oxygen: Keep numbers with most common bit set from msb, until only 1 number remains
func filter_numbers(numbers: var set[int16], bit: int, cmp: (int, int) -> bool) : int =
  if numbers.card == 1: return peek numbers
  let common = mostCommonBit(numbers, bit)
  for n in numbers:
    if not cmp(n.bit(bit), common):
      numbers.excl(n)
  filter_numbers(numbers, bit-1, cmp)

proc filt(cmp: (int, int) -> bool): int =
  var numbers = allNumbers
  return filter_numbers(numbers, length-1, cmp)

proc part2() : int =
  let oxygen: int = filt((a, b) => a == b)
  let co2scrubber: int = filt((a, b) => a != b)
  dump oxygen
  dump co2scrubber
  result = oxygen * co2scrubber
  echo "Part 2: ", result

block run:
  assert part1() == 4147524
  assert part2() == 3570354
