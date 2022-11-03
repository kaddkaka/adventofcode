import std/sugar
import std/sequtils

var tmp = {1, 2, 3, 4, 5, 6, 7, 8}
var interest = {2, 3, 5, 8}
tmp = tmp * interest
dump tmp
