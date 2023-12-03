import std/strscans
import std/heapqueue

var cwd: seq[string]
var cts: seq[int]
var small_total = 0
var heap = initHeapQueue[int]()

for line in lines "input":
  var dir: string
  var size: int

  if scanf(line, "$$ cd .."):
    discard pop cwd
    if cts[^1] < 100000:
      small_total += cts[^1]
    heap.push(cts[^1])
    cts[^2] += pop cts
  elif scanf(line, "$$ cd $s", dir):
    cwd.add(dir)
    cts.add(0)
  elif scanf(line, "dir") or scanf(line, "$$ ls"):
    discard
  else:
    assert scanf(line, "$i", size)
    cts[^1] += size

var total = 0
for dirsize in cts:
  total += dirsize
  if dirsize < 100000:
    small_total += dirsize
  heap.push(dirsize)

echo "small total size:", small_total
echo "total size:", total
echo "heap", heap

let need_to_free = total - 40000000
var cur: int
while (cur = pop heap ; cur < need_to_free):
  discard

echo "smallest_to_delete: ", cur
