extends Node

var input: String = "res://day_04/d04_pt01_input.txt"

func _ready() -> void:
	run()

func run() -> void:
	print("running: D04Pt01")
	var file := FileAccess.open(input, FileAccess.READ)
	if !file:
		return
	
	var result := 0
	var matrix := XmasMatrix.new()
	while file.get_position() < file.get_length():
		matrix.add_line(file.get_line())
	result = matrix.count_xmas()
	print("XMAS found: " + str(result))
	file.close()
