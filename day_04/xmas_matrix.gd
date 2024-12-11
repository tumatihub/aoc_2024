class_name XmasMatrix
extends RefCounted

const WORD := "XMAS"
var value: Array[PackedStringArray] = []
var found_m: Array = []

func count_x_mas() -> int:
	var count := 0
	for l in range(get_height()):
		for c in range(get_width()):
			if get_pos(l, c) == "M":
				count += count_x_mas_at_pos(l, c)
	return count / 2

func count_x_mas_at_pos(line: int, col: int) -> int:
	var count := 0
	if has_x_mas(line, col, -1, -1) or has_x_mas(line, col, -1, -1, true):
		count += 1
		
	if has_x_mas(line, col, -1, 1) or has_x_mas(line, col, -1, 1, true):
		count += 1
		
	if has_x_mas(line, col, 1, 1) or has_x_mas(line, col, 1, 1, true):
		count += 1
		
	if has_x_mas(line, col, 1, -1) or has_x_mas(line, col, 1, -1, true):
		count += 1
		
	return count

func has_x_mas(line: int, col: int, line_inc: int, col_inc: int, invert: bool = false) -> bool:
	if !is_valid_pos(line+line_inc*2, col) or \
		get_pos(line+line_inc*2, col) != ("M" if !invert else "S"): 
		return false
	if !is_valid_pos(line+line_inc, col+col_inc) or \
		get_pos(line+line_inc, col+col_inc) != "A": 
		return false
	if !is_valid_pos(line, col+col_inc*2) or \
		get_pos(line, col+col_inc*2) != ("S" if !invert else "M"): 
		return false
	if !is_valid_pos(line+line_inc*2, col+col_inc*2) or \
		get_pos(line+line_inc*2, col+col_inc*2) != "S": 
		return false
	return true

func was_found_m(line: int, col: int) -> bool:
	for i in found_m:
		if i[0] == line and i[1] == col:
			return true
	return false

func count_xmas() -> int:
	var count := 0
	for l in range(get_height()):
		for c in range(get_width()):
			if get_pos(l, c) == "X":
				count += count_xmas_at_pos(l, c)
	return count

func count_xmas_at_pos(line: int, col: int) -> int:
	var count := 0
	if has_xmas(line, col, 0, 1):
		count += 1
	if has_xmas(line, col, 0, -1):
		count += 1
	if has_xmas(line, col, -1, -1):
		count += 1
	if has_xmas(line, col, -1, 1):
		count += 1
	if has_xmas(line, col, 1, 1):
		count += 1
	if has_xmas(line, col, 1, -1):
		count += 1
	if has_xmas(line, col, -1, 0):
		count += 1
	if has_xmas(line, col, 1, 0):
		count += 1
	return count

func has_xmas(line: int, col: int, line_inc: int, col_inc: int) -> bool:
	for i in range(WORD.length()-1):
		if !is_valid_pos(line+line_inc*(i+1), col+col_inc*(i+1)) or \
			get_pos(line+line_inc*(i+1), col+col_inc*(i+1)) != WORD[i+1]: 
			return false
	return true

func add_line(string: String) -> void:
	value.append(string.split())

func get_width() -> int:
	return value[0].size()

func get_height() -> int:
	return value.size()

func get_pos(line: int, col: int) -> String:
	return value[line][col]

func is_valid_pos(line: int, col: int) -> bool:
	if line < 0 or col < 0:
		return false
	if line >= get_height() or col >= get_width():
		return false
	return true
