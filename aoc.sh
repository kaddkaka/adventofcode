cookie=$(cat cookie.txt)

if [ $# -eq 0 ] ; then
  echo "No argument for day supplied"
  exit
fi

mkdir -p 2024/day$1
cd 2024/day$1
curl -s -b $cookie https://adventofcode.com/2024/day/$1/input > input
curl -s https://adventofcode.com/2024/day/$1 | pup article | elinks -dump -dump-color-mode 1
wezterm cli split-pane --left --cwd ~/projects/advent_of_code/2024/day$1 -- nvim day$1.zig

