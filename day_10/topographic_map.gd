class_name TopographicMap
extends RefCounted

const TRAILHEAD = 9

var map: Array[PackedInt32Array] = []
var found_trailhead: Array[Vector2i] = []

func count_all_trails(count_all_paths := false) -> int:
	var sum := 0
	for x in get_width():
		for y in get_height():
			if get_pos(Vector2i(x, y)) == 0:
				sum += find_trails(Vector2i(x, y), count_all_paths)
			found_trailhead.clear()
	return sum

func find_trails(pos: Vector2i, count_all_paths := false) -> int:
	var sum := 0
	var cell_value := get_pos(pos)
	if cell_value == TRAILHEAD:
		if found_trailhead.count(pos) > 0 and not count_all_paths:
			return 0
		else:
			found_trailhead.append(pos)
			return 1
	for cell in _next_trail_cells(pos):
		sum += find_trails(cell, count_all_paths)
	return sum

func _next_trail_cells(pos: Vector2i) -> Array[Vector2i]:
	var cells: Array[Vector2i] = []
	var dirs: Array[Vector2i] = [Vector2i.UP, Vector2i.RIGHT, Vector2i.DOWN, Vector2i.LEFT]
	for dir in dirs:
		var cell := pos + dir
		if _is_inside_map(cell) and get_pos(cell) == get_pos(pos) + 1:
			cells.append(cell)
	return cells

func _is_inside_map(pos: Vector2i) -> bool:
	return pos.x >= 0 and pos.x < get_width() and pos.y >= 0 and pos.y < get_height()

func add_line(string: String) -> void:
	var int_line: PackedInt32Array
	for s in string.split():
		int_line.append(int(s))
	map.append(int_line)

func get_pos(pos: Vector2i) -> int:
	return map[pos.y][pos.x]

func get_width() -> int:
	if map.size() == 0:
		return 0
	return map[0].size()

func get_height() -> int:
	return map.size()
