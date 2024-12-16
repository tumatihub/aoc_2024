class_name LabMap
extends RefCounted

signal set_cell(pos: Vector2i, char: String)

const OBSTACLE_CHAR = "#"
const OBSTRUCTION_CHAR = "O"
const EMPTY_CHAR = "."

var map: Array[PackedStringArray] = [] 
var guard: Guard
var obstructions: Array[Vector2i] = []
var last_loop_positions: Array[Vector2i] = []

func do_walk_guard_path() -> void:
	while !guard.left_map:
		move_guard()

func do_walk_guard_path_finding_loop(delay := 0.0) -> void:
	while !guard.left_map:
		move_guard_finding_loop(delay)

func setup_guard() -> void:
	for l in get_height():
		guard = find_guard(l)
		if guard:
			set_pos(guard.position, EMPTY_CHAR)
			return

func find_guard(line: int) -> Guard:
	var guard: Guard
	for col in map[line].size():
		var char := map[line][col]
		if is_guard_char(char):
			guard = Guard.new()
			guard.position = Vector2i(col, line)
			guard.start_position = guard.position
			guard.dir = get_guard_dir(char)
			guard.start_dir = guard.dir
			return guard
	return guard

func move_guard(mark_x := true, delay := 0.0) -> void:
	if has_obstacle_ahead():
		guard.dir = guard.rotate()
		return
	if mark_x:
		map[guard.position.y][guard.position.x] = "X"
	guard.position += guard.dir
	if !is_pos_inside_map(guard.position):
		guard.left_map = true

func move_guard_finding_loop(delay := 0.0) -> void:
	last_loop_positions = []
	guard.mark_pos(self)
	var next_pos := guard.position + guard.dir
	if has_obstacle_ahead():
		guard.dir = guard.rotate()
		return
	elif is_pos_inside_map(next_pos) and obstructions.count(next_pos) == 0 and next_pos != guard.start_position:
		find_loop()
	guard.position += guard.dir
	if !is_pos_inside_map(guard.position):
		guard.left_map = true

func find_loop() -> bool:
	var steps: Array[Vector2i] = []
	steps.append(guard.position)
	var last_guard_pos := guard.position
	var last_guard_dir := guard.dir
	var last_char := get_pos(last_guard_pos + last_guard_dir)
	set_pos(last_guard_pos + last_guard_dir, OBSTACLE_CHAR)
	var obstacles: Array[Array]
	obstacles.append([last_guard_pos + last_guard_dir, last_guard_dir])
	var found_loop := false
	guard.dir = guard.rotate()
	while !guard.left_map and !found_loop:
		move_guard(false)
		if has_obstacle_ahead():
			if has_repeated_corner(guard, obstacles):
				found_loop = true
				obstructions.append(last_guard_pos + last_guard_dir)
			else:
				obstacles.append([guard.position + guard.dir, guard.dir])
		steps.append(guard.position)
	guard.position = last_guard_pos
	guard.dir = last_guard_dir
	guard.left_map = false
	set_pos(last_guard_pos + last_guard_dir, last_char)
	if found_loop:
		last_loop_positions = Array(steps.duplicate(), TYPE_VECTOR2I, "", null)
	else:
		last_loop_positions = []
	return found_loop

func has_repeated_corner(guard: Guard, obstacles: Array[Array]) -> bool:
	for o in obstacles:
		if o[0] == guard.position + guard.dir and o[1] == guard.dir:
			return true
	return false

func has_obstacle_ahead() -> bool:
	var next_pos := guard.position + guard.dir
	return is_pos_inside_map(next_pos) and get_pos(next_pos) == OBSTACLE_CHAR

func is_pos_empty(pos: Vector2i) -> bool:
	return get_pos(pos) == EMPTY_CHAR

func is_pos_inside_map(pos: Vector2i) -> bool:
	return pos.x >= 0 and pos.x < get_width() and pos.y >= 0 and pos.y < get_height()

func count_path_positions() -> int:
	var result := 0
	for l in map:
		result += l.count("X")
	return result

func count_marked_path() -> int:
	var result := 0
	for l in map:
		result += l.count("|") + l.count("-") + l.count("+")
	return result

func get_pos(pos: Vector2i) -> String:
	return map[pos.y][pos.x]

func set_pos(pos: Vector2i, char: String) -> void:
	map[pos.y][pos.x] = char
	set_cell.emit(pos, char)

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

func print_map(mark_orbstructions := false) -> void:
	if mark_orbstructions:
		for o in obstructions:
			set_pos(o, OBSTRUCTION_CHAR)
	for l in map:
		var string := ""
		for c in l:
			string += c
		print(string)

class Guard:
	const CROSS_CHAR = "+"
	var position: Vector2i
	var start_position: Vector2i
	var dir: Vector2i
	var start_dir: Vector2i
	var left_map := false
	var directions := {
		Vector2i.UP: GuardDirection.new("|", Vector2i.RIGHT),
		Vector2i.RIGHT: GuardDirection.new("-", Vector2i.DOWN),
		Vector2i.DOWN: GuardDirection.new("|", Vector2i.LEFT),
		Vector2i.LEFT: GuardDirection.new("-", Vector2i.UP)
	}
	
	func find_corner(from_pos: Vector2i, dir: Vector2i, map: LabMap, last_obstacles: Array[Vector2i] = []) -> bool:
		var last_pos_char := map.get_pos(position)
		var last_pos := from_pos
		var pos := from_pos + dir
		var found_obstacle := map.get_pos(pos) == map.OBSTACLE_CHAR
		while map.is_pos_inside_map(pos) and !found_obstacle:
			last_pos_char = map.get_pos(pos)
			last_pos = pos
			pos += dir
			if !map.is_pos_inside_map(pos):
				return false
			found_obstacle = map.get_pos(pos) == map.OBSTACLE_CHAR
		if found_obstacle:
			if last_pos_char == CROSS_CHAR:
				return true
			else:
				if last_obstacles.count(pos) > 0:
					return true
				last_obstacles.append(pos)
				return find_corner(last_pos, directions[dir].next_dir, map, last_obstacles)
		return false
	
	func mark_pos(map: LabMap) -> void:
		if map.is_pos_empty(position):
			map.set_pos(position, directions[dir].char)
		elif map.get_pos(position) == directions[directions[dir].next_dir].char:
			map.set_pos(position, CROSS_CHAR)
	
	func rotate() -> Vector2i:
		return directions[dir].next_dir

class GuardDirection:
	var char: String
	var next_dir: Vector2i
	
	func _init(char: String, next_dir: Vector2i) -> void:
		self.char = char
		self.next_dir = next_dir
