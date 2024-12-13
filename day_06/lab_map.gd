class_name LabMap
extends RefCounted

const OBSTACLE_CHAR = "#"

var map: Array[PackedStringArray] = [] 
var guard: Guard

func do_walk_guard_path() -> void:
	while !guard.left_map:
		move_guard()

func setup_guard() -> void:
	for l in get_height():
		guard = find_guard(l)
		if guard:
			return

func find_guard(line: int) -> Guard:
	var guard: Guard
	for col in map[line].size():
		var char := map[line][col]
		if is_guard_char(char):
			guard = Guard.new()
			guard.position = Vector2i(col, line)
			guard.dir = get_guard_dir(char)
			return guard
	return guard

func move_guard() -> void:
	if has_obstacle_ahead():
		guard.rotate()
		return
	map[guard.position.y][guard.position.x] = "X"
	guard.position += guard.dir
	if !is_pos_inside_map(guard.position):
		guard.left_map = true

func has_obstacle_ahead() -> bool:
	var next_pos := guard.position + guard.dir
	return is_pos_inside_map(next_pos) and get_pos(next_pos) == OBSTACLE_CHAR

func is_pos_inside_map(pos: Vector2i) -> bool:
	return pos.x >= 0 and pos.x < get_width() and pos.y >= 0 and pos.y < get_height()

func count_path_positions() -> int:
	var result := 0
	for l in map:
		result += l.count("X")
	return result

func get_pos(pos: Vector2i) -> String:
	return map[pos.y][pos.x]

func get_guard_dir(char: String) -> Vector2i:
	match char:
		"<":
			return Vector2i.LEFT
		"^":
			return Vector2i.UP
		">":
			return Vector2i.RIGHT
		"v":
			return Vector2i.DOWN
		_:
			return Vector2i.UP

func is_guard_char(char: String) -> bool:
	return char == "<" or char == "^" or char == ">" or char == "v"

func add(string: String) -> void:
	map.append(string.split())

func get_width() -> int:
	if map.size() == 0:
		return 0
	return map[0].size()

func get_height() -> int:
	return map.size()

class Guard:
	var position: Vector2i
	var dir: Vector2i
	var left_map := false
	
	func rotate() -> void:
		match dir:
			Vector2i.UP:
				dir = Vector2i.RIGHT
				return
			Vector2i.RIGHT:
				dir = Vector2i.DOWN
				return
			Vector2i.DOWN:
				dir = Vector2i.LEFT
				return
			Vector2i.LEFT:
				dir = Vector2i.UP
				return
