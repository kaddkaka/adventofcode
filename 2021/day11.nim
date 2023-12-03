import std/parseutils
import std/sugar
import std/enumerate

const size = 10
type Grid[T] = array[size, array[size, T]]

var grid: Grid[int]

for row, line in enumerate(lines "day11.input"):
  for col, c in pairs line:
    var n: int
    discard parseInt($c, n)
    grid[col][row] = n

iterator neighbors[T](grid: Grid[T], x, y: int): (int, int, T) =
  const max = size - 1
  func inside(x, y: int): bool =
    return x in 0..max and y in 0..max

  for j in y-1..y+1:
    for i in x-1..x+1:
      if (i, j) == (x, y): continue
      if inside(i, j):
        yield (i, j, grid[i][j])

func step(grid: var Grid[int]): int =
  var flashed: Grid[bool]
  var newFlash: bool

  for x, col in grid:
    for y, val in col:
      inc grid[x][y]
      if val == 9:
        newFlash = true

  while newFlash:
    newFlash = false
    for x, col in grid:
      for y, val in col:
        if val >= 10:
          newFlash = true
          flashed[x][y] = true
          grid[x][y] = 0
          inc result
          for nx, ny, nval in grid.neighbors(x, y):
            if not flashed[nx][ny]:
              inc grid[nx][ny]
              if val == 9:
                newFlash = true

proc `$`(grid: Grid[int]): string =
  for col in grid:
    result &= $col & '\n'

func totFlashes(grid: var Grid[int], n: int): int =
  for _ in 1..n:
    result += grid.step()

var steps = 1
while grid.step != 100:
  inc steps
echo steps
