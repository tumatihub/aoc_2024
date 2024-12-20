class_name AntennaMap
extends RefCounted

const EMPTY_CHAR = "."
const ANTINODE_CHAR = "#"

var map: Array[PackedStringArray] = []
var antennas: Array[Antenna] = []
var antinodes: Array[Vector2i] = []

func find_full_antinodes() -> void:
	for a in antennas:
		for pos_idx in a.positions.size():
			for other_idx in range(pos_idx+1, a.positions.size()):
				var pos := a.positions[pos_idx]
				var other := a.positions[other_idx]
				_find_all_inline_antinodes(pos, other)

func _find_all_inline_antinodes(pos: Vector2i, other: Vector2i) -> void:
	var diff := pos - other
	var idx := 0
	var diff_inc := diff * idx
	while _is_pos_inside_map(pos + diff_inc):
		if not antinodes.has(pos + diff_inc):
			antinodes.append(pos + diff_inc)
		idx += 1
		diff_inc = diff * idx
	idx = 0
	diff_inc = diff * idx
	while _is_pos_inside_map(other - diff_inc):
		if not antinodes.has(other - diff_inc):
			antinodes.append(other - diff_inc)
		idx += 1
		diff_inc = diff * idx
 
func find_antinodes() -> void:
	for a in antennas:
		for pos_idx in a.positions.size():
			for other_idx in range(pos_idx+1, a.positions.size()):
				var pos := a.positions[pos_idx]
				var other := a.positions[other_idx]
				var diff := pos - other
				if _is_pos_inside_map(pos + diff) and not antinodes.has(pos + diff):
					antinodes.append(pos + diff)
				if _is_pos_inside_map(other - diff) and not antinodes.has(other - diff):
					antinodes.append(other - diff)

func find_antennas() -> void:
	for l in get_height():
		for c in get_width():
			var char := get_pos(Vector2i(c, l))
			if char != EMPTY_CHAR:
				_store_position(Vector2i(c, l), char)

func _store_position(pos: Vector2i, char: String) -> void:
	for a in antennas:
		if a.char == char:
			a.add_pos(pos)
			return
	var new_antenna := Antenna.new()
	new_antenna.char = char
	new_antenna.add_pos(pos)
	antennas.append(new_antenna)

func add_line(string: String) -> void:
	map.append(string.split())

func _is_pos_inside_map(pos: Vector2i) -> bool:
	return pos.x >= 0 and pos.x < get_width() and pos.y >= 0 and pos.y < get_height()

func get_pos(pos: Vector2i) -> String:
	return map[pos.y][pos.x]

func set_pos(pos: Vector2i, char: String) -> void:
	map[pos.y][pos.x] = char

func get_width() -> int:
	if map.size() <= 0:
		return 0
	return map[0].size()

func get_height() -> int:
	return map.size()

func print_map(mark_antinodes := true, overlap_antinodes := true) -> void:
	if mark_antinodes:
		for n in antinodes:
			if get_pos(n) == EMPTY_CHAR or overlap_antinodes:
				set_pos(n, ANTINODE_CHAR)
	for l in map:
		var string := ""
		for c in l:
			string += c
		print(string)

class Antenna:
	var positions: Array[Vector2i] = []
	var char: String
	
	func add_pos(pos: Vector2i) -> void:
		positions.append(pos)
