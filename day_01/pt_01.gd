class_name Day01Pt01
extends Node

var input: String = "res://day_01/pt_01_input.txt"
var first_col: Array[int] = []
var second_col: Array[int] = []

func _ready() -> void:
	run()

func run() -> void:
	var file := FileAccess.open(input, FileAccess.READ)
	if !file:
		return
	while file.get_position() < file.get_length():
		var line_numbers: PackedStringArray = file.get_line().split("   ")
		add_to_col_sorted(first_col, int(line_numbers[0]))
		add_to_col_sorted(second_col, int(line_numbers[1]))
	
	print(calc_distances())
	file.close()

func add_to_col_sorted(col: Array[int], num: int) -> void:
	var index := 0
	var max_value := 0
	while index < col.size() and num > max_value:
		max_value = col[index]
		index += 1
	
	if index == col.size() and num > max_value:
		col.append(num)
	else:
		col.insert(index-1, num)

func calc_distances() -> int:
	var index := 0
	var sum := 0
	while index < first_col.size():
		sum += absi(first_col[index] - second_col[index])
		index += 1
	return sum

func print_cols() -> void:
	var index := 0
	while index < first_col.size():
		print(str(first_col[index]) + "   " + str(second_col[index]))
		index += 1
