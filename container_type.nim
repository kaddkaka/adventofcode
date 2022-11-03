type Ten[T] = array[10, array[10, T]]

var visited: Ten[bool]

visited[0][0] = true

echo visited[0][0]
