import std/strscans
import std/sequtils
import std/strutils

iterator backwards * [T] (s: openArray[T]): T =
  for i in countdown(s.high, s.low):
    yield s[i]

let f = open("input")

type stack = seq[char]

proc get_init_pos(): seq[stack] =
  var init_lines: seq[string]

  var line: string
  while (line = f.readline(); '[' in line):
    init_lines.add(line)

  result.setLen (line.len + 2) div 4

  for line in backwards(init_lines):
    for i in 0..<result.len:
      let char = line[i*4 + 1]
      if char != ' ':
        result[i].add(char)

var stacks = get_init_pos()
var stacks_CrateMover_9001 = stacks

assert f.readline() == ""  # Throw away empty line

var line: string
while f.readline(line):
  var (_, n, src, dst) = scanTuple(line, "move $i from $i to $i")
  dec src
  dec dst
  for i in 1..n:
    stacks[dst].add stacks[src].pop()

  stacks_CrateMover_9001[dst].add stacks_CrateMover_9001[src][^n..^1]
  for i in 1..n:
    discard pop stacks_CrateMover_9001[src]

echo stacks.mapIt(it[^1]).join
echo stacks_CrateMover_9001.mapIt(it[^1]).join
