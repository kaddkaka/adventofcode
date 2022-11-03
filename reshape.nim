import sequtils

func setDim(matrix: var seq[seq[int]], dim: (int, int)) =
  matrix = newSeqWith(dim[0], newSeq[int](dim[1]))

var grid_2: seq[seq[int]]
grid_2.setDim (2, 2)

func `~>`(shape_src: seq[seq[int]], matrix: var seq[seq[int]]) =
  matrix.setLen(len shape_src)
  for i, row in mpairs matrix:
    row.setLen(len shape_src[i])

var grid = @[@[1, 2, 3]]
grid_2 ~> grid

echo grid_2
echo grid
