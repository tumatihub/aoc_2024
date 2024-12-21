class_name DiskMap
extends RefCounted

const EMPTY_CHAR = "."

var dense_map: PackedStringArray = []
var expanded_map: PackedStringArray = []
var string_count := 0

#pos, size
var spaces: Array[Array] = []


func defrag_keeping_files_together() -> void:
	var file_id := _get_last_file_id()
	while file_id >= 0:
		var file := _get_file(file_id)
		var file_start: int = file[0]
		var file_size: int = file[1]
		var space_start = _get_space_before(file_start, file_size)
		if space_start != -1:
			_move_file(file_id, file_start, file_size, space_start)
		file_id -= 1

func _move_file(file_id: int, file_start: int, file_size: int, space_start: int) -> void:
	for i in file_size:
		expanded_map[space_start+i] = str(file_id)
		expanded_map[file_start+i] = EMPTY_CHAR
	for s in spaces:
		if s[0] == space_start:
			s[1] -= file_size
			s[0] += file_size

func _get_space_before(index: int, size: int) -> int:
	for s in spaces:
		if s[0] >= index:
			return -1
		if s[1] >= size:
			return s[0]
	return -1

func _get_file(file_id: int) -> Array:
	var result := []
	var rev_idx := expanded_size()-1
	while expanded_map[rev_idx] != str(file_id) and rev_idx >= 0:
		rev_idx -= 1
	if rev_idx >= 0:
		var size := 0
		while rev_idx > 0 and expanded_map[rev_idx] == str(file_id):
			size += 1
			rev_idx -= 1
		result = [rev_idx+1, size]
	return result

func _get_last_file_id() -> int:
	var rev_idx := expanded_size()-1
	while expanded_map[rev_idx] == EMPTY_CHAR:
		rev_idx -= 1
	return int(expanded_map[rev_idx])

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
	while idx < expanded_size():
		if expanded_map[idx] != EMPTY_CHAR:
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
	var expanded_idx := 0
	for idx in size():
		if idx % 2 == 0:
			char = str(file_id)
			file_id += 1
		else:
			char = EMPTY_CHAR
			if int(dense_map[idx]) == 0:
				continue
			else:
				spaces.append([expanded_idx, int(dense_map[idx])])
		for i in int(dense_map[idx]):
			expanded_map.append(char)
			expanded_idx += 1

func add_dense_line(string: String) -> void:
	string_count += string.length()
	dense_map.append_array(string.split())

func size() -> int:
	return dense_map.size()

func expanded_size() -> int:
	return expanded_map.size()
