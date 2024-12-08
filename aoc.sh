mkdir -p 2024/day$1
curl -s -b $cookie https://adventofcode.com/2024/day/$1/input >> 2024/day$1/input

curl -s https://adventofcode.com/2024/day/$1 | pup article | elinks -dump -dump-color-mode 1

