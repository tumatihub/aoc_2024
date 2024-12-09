class_name D01Pt02
extends Node

var input: String = "res://day_01/pt_01_input.txt"
var first_col: Array[int] = []
var second_col: Array[int] = []

func _ready() -> void:
	run()

func run() -> void:
	print("running: D01Pt02")
	var file := FileAccess.open(input, FileAccess.READ)
	if !file:
		return
	while file.get_position() < file.get_length():
		var line_numbers: PackedStringArray = file.get_line().split("   ")
		first_col.append(int(line_numbers[0]))
		second_col.append(int(line_numbers[1]))
	
	print("Similarity Score: " + str(similarity_score()))
	file.close()

func similarity_score() -> int:
	var score := 0
	for i in first_col:
		score += i * get_ocur_num(i)
	return score

func get_ocur_num(num: int) -> int:
	var times := 0
	for i in second_col:
		if i == num:
			times += 1
	return times
