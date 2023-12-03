import std/sugar
import std/strutils
import std/sequtils
import std/parseutils
import std/tables

type Monkey = tuple
  items: seq[int]
  divisor: int
  pass: int
  fail: int
  operation: int -> int
  inspections: int
  long_items: seq[Table[int, int]]

var monkeys: seq[Monkey]
var f: File
var line: string
var divisors: seq[int]

if f.open "input":
  while f.readline(line):
    let items = f.readline()[len("  Starting items: ")..^1].split(", ").map(parseInt)

    let ops = f.readline()[len("  Operation: new = ")..^1].split(' ')
    var operation: int -> int
    try:
      let rhs = ops[2].parseInt()
      if ops[1] == "+":
        capture rhs:
          operation = proc (a: int): int {.closure.} = a + rhs
      else:
        assert ops[1] == "*"
        capture rhs:
          operation = proc (a: int): int {.closure.} = a * rhs
    except ValueError:
      assert ops[2] == "old"
      if ops[1] == "+":
        operation = proc (a: int): int {.closure.} = a + a
      else:
        assert ops[1] == "*"
        operation = proc (a: int): int {.closure.} = a * a

    let divisor = f.readline()[len("  Test: divisible by ")..^1].parseInt()
    divisors.add(divisor)
    let pass = f.readline()[^1..^1].parseInt()
    let fail = f.readline()[^1..^1].parseInt()
    monkeys.add((items, divisor, pass, fail, operation, 0, @[]))

    try:
      assert f.readline() == ""
    except EOFError:
      break

echo "MONK:", len(monkeys)

for m in monkeys.mitems:
  for item in m.items:
    let expanded = collect initTable:
      for d in divisors:
        {d: item}
    m.long_items.add(expanded)

echo "MONK:", len(monkeys)

for round in countUp(1, 10000):
  for m in monkeys.mitems:
    for long_item in m.long_items.mitems:
      for d, i in long_item:
        long_item[d] = m.operation(i) mod d
      let target = if long_item[m.divisor] == 0: m.pass else: m.fail
      monkeys[target].long_items.add(long_item)
    m.inspections += m.long_items.len()
    m.long_items = @[]

  if round mod 1000 == 0 or round in [1, 20]:
    echo "Round ", round
    for i, m in monkeys:
      stdout.write ",", m.inspections
    echo ""
