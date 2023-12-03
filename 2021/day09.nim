import std/parseutils
import std/sugar

type Grid = seq[seq[int]]
var grid: Grid

for line in lines "day09.input":
  var numbers: seq[int] = collect(newSeq):
    for c in line:
      var n: int
      discard parseInt($c, n)
      n
  grid.add(numbers)

iterator neighbors(grid: Grid, x: int, y: int): (int, int, int) =
  let max_y = grid.high
  let max_x = grid[0].high
  if x > 0:
    yield (x-1, y, grid[y][x-1])
  if x < max_x:
    yield (x+1, y, grid[y][x+1])
  if y > 0:
    yield (x, y-1, grid[y-1][x])
  if y < max_y:
    yield (x, y+1, grid[y+1][x])

func isLow(grid: Grid, x: int, y: int): bool =
  let value = grid[y][x]
  for _, _, n in neighbors(grid, x, y):
    if value >= n:
      return false
  return true

func basinSize(grid: Grid, x: int, y: int): int =
  type Visit[T] = array[100, array[100, T]]

  var openList = @[(x, y)]
  var visited: Visit[bool]
  visited[x][y] = true
  result += 1

  while openList.len > 0:
    let (a, b) = openList.pop
    for (x, y, val) in grid.neighbors(a, b):
      if val < 9 and not visited[x][y]:
        openList.add((x, y))
        visited[x][y] = true
        result += 1

import algorithm
import std/sequtils
proc riskSum(grid: Grid): int =
  var basins: seq[int]
  for y, row in pairs grid:
    for x, value in row:
      if grid.isLow(x, y):
        result += value + 1
        basins.add grid.basinSize(x, y)
  basins.sort
  echo basins
  echo basins[^3..^1].foldl(a * b)

echo riskSum(grid)
