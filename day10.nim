const openers = "([{<"

func isCorrupted(s: string): bool =
  var stack: seq[char]
  for c in s:
    if c in openers:
      stack.add(c)
    else:
      if c == ')' and stack[^1] != '(':
          return true
      if c == ']' and stack[^1] != '[':
          return true
      if c == '}' and stack[^1] != '{':
          return true
      if c == '>' and stack[^1] != '<':
          return true
      discard stack.pop()

func remains(s: string): seq[char] =
  var stack: seq[char]
  for i, c in pairs s:
    if c in openers:
      stack.add(c)
    else:
      discard stack.pop()
  return stack

func completion(s: seq[char]): string =
  for c in s:
    if c == '(':
      result = ')' & result
    if c == '[':
      result = ']' & result
    if c == '{':
      result = '}' & result
    if c == '<':
      result = '>' & result

import std/sequtils
import std/algorithm

func value(find: char): int =
  for idx, c in ")]}>":
    if find == c:
      return idx + 1

var completionScores: seq[int]
for line in lines "day10.input":
  if not isCorrupted(line):
    let rem = remains(line)
    let comp = rem.completion
    completionScores.add comp.foldl(a * 5 + value(b), 0)

completionScores.sort
echo completionScores[completionScores.len div 2]
