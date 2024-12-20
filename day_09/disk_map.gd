class_name DiskMap
extends RefCounted

const EMPTY_CHAR = "."

var dense_map: PackedStringArray = []
var expanded_map: PackedStringArray = []
var string_count := 0

func defrag() -> void:
	var idx := 0
	var rev_idx := expanded_size()-1
	while idx < expanded_size() and idx < rev_idx:
		if expanded_map[idx] == EMPTY_CHAR:
			rev_idx = _get_last_block_after_index(idx, rev_idx)
			if rev_idx != -1:
				expanded_map[idx] = expanded_map[rev_idx]
				expanded_map[rev_idx] = EMPTY_CHAR
				rev_idx -= 1
		idx += 1

func checksum() -> int:
	var idx := 0
	var sum := 0
	while not expanded_map[idx] == EMPTY_CHAR:
		sum += int(expanded_map[idx])*idx
		idx += 1
	return sum

func _get_last_block_after_index(idx: int, rev_idx: int) -> int:
	while rev_idx > idx:
		var char := expanded_map[rev_idx]
		if char != EMPTY_CHAR:
			return rev_idx
		rev_idx -= 1
	return -1

func expand() -> void:
	var file_id := 0
	var char := ""
	for idx in size():
		if idx % 2 == 0:
			char = str(file_id)
			file_id += 1
		else:
			char = EMPTY_CHAR
		if int(dense_map[idx]) == 0:
			continue
		for i in int(dense_map[idx]):
			expanded_map.append(char)

func add_dense_line(string: String) -> void:
	string_count += string.length()
	dense_map.append_array(string.split())

func size() -> int:
	return dense_map.size()

func expanded_size() -> int:
	return expanded_map.size()
