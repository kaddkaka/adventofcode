import std/strutils
import std/sequtils
import std/sugar
import std/strformat
import std/bitops  # Import this package, which is unused, causes error on line 14

type Number = object
  n: int
  marked: bool

type Tile = seq[seq[Number]]

func `$`(tile: Tile): string =
  for row in tile:  # Error: recursion is not supported in iterators: 'items'
    for number in row:
      result &= &"{number.n:2}" & (if number.marked: "*" else: " ")
    result &= '\n'

proc call(tile: var Tile, called: int) =
  for row in mitems tile:
    for number in mitems row:
      if number.n == called:
        assert not number.marked
        number.marked = true
        return

func hasBingo(tile: Tile): bool =
  block row_bingo:
    for row in tile:
      if row.allIt(it.marked): return true

  block col_bingo:
    var col_marked = @[true, true, true, true, true]
    for row in tile:
      for col, number in row:
        col_marked[col] = col_marked[col] and number.marked
    return col_marked.anyIt(it)

func sumUnmarked(tile: Tile): int =
  for row in tile:
    result += row.foldl(a + (if b.marked: 0 else: b.n), 0)

var f: File
if open(f, "day04.input"):
  let calls = f.readLine().split(',').map(parseInt)

  var tiles: seq[Tile]
  for line in lines f:
    if line == "":
      tiles.add(@[])
      continue

    tiles[^1].add(@[])
    for n in line.splitWhitespace.map(parseInt):
      tiles[^1][^1].add Number(n: n, marked: false)

  block callNumbers:
    for n in calls:
      for tile in mitems tiles:
        tile.call(n)
        if tile.hasBingo:
          let score = n * sumUnmarked(tile)
          dump score
          break callNumbers
