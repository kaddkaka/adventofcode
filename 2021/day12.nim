import std/[sugar, tables, strscans]

type Cave = ref object
  name: string
  links: seq[Cave]

template joinIt[T: not string](a: openArray[T], sep: string = "", operation: untyped): string =
  ## Converts all elements in the container `a` to strings using `$`,
  ## and concatenates them with `sep`.
  runnableExamples:
    doAssert join([1, 2, 3], " -> ") == "1 -> 2 -> 3"

  var result = ""
  for i, x in a:
    if i > 0:
      add(result, sep)
    let it {.inject.} = x
    add(result, operation)
  result

var caveSystem: Table[string, Cave]

proc newCave(name: string): Cave =
  Cave(name: name)

proc getCave(name: string): Cave =
  if name in caveSystem:
    result = caveSystem[name]
  else:
    result = newCave(name)
    caveSystem[name] = result

proc linkCaves(a: var Cave, b: var Cave) =
  echo "Linking: ", a.name, " and ", b.name
  a.links.add(b)
  b.links.add(a)

func `$`(c: Cave): string =
  c.name & ": [" & c.links.joinIt(", ", it.name) & "]"

var s: Cave = newCave("start")
caveSystem["start"] = s

for line in lines "day12.input":
  var (_, start, stop) = line.scanTuple("$w-$w")
  echo ">", start, "-", stop
  var a: Cave = getCave(start)
  var b: Cave = getCave(stop)

  linkCaves(a, b)

type Path = object
  visits: CountTable[string]
  doubleVisit: bool
  pos: Cave

func step(p: Path, n: var int): seq[Path] =
  if p.pos.name == "end":
    inc n
    return

  for l in p.pos.links:
    if l.name == "start": continue
    if l.name[0] in 'A'..'Z':
      result.add(p)
      result[^1].pos = l
      result[^1].visits.inc(l.name)
    elif l.name notIn p.visits:
      result.add(p)
      result[^1].pos = l
      result[^1].visits.inc(l.name)
    elif not p.doubleVisit:
      result.add(p)
      result[^1].pos = l
      result[^1].visits.inc(l.name)
      result[^1].doubleVisit = true

func step(paths: seq[Path], n: var int): seq[Path] =
  for p in paths:
    result &= step(p, n)

var path: Path
path.pos = s
path.visits["start"] = 1
var paths = @[path]

var numPaths = 0
while paths.len > 0:
  paths = step(paths, numPaths)
  echo numPaths
