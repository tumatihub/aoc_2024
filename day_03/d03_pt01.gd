extends Node

var input: String = "res://day_03/d03_pt01_input.txt"

func _ready() -> void:
	run()

func run() -> void:
	print("running: D03Pt01")
	var file := FileAccess.open(input, FileAccess.READ)
	if !file:
		return
	
	var result := 0
	while file.get_position() < file.get_length():
		var calculator := Calculator.new()
		var operation_list := calculator.find_expressions(file.get_line())
		result += calculator.evaluate_operations(operation_list)
	
	print("Result for all operations: " + str(result))
	file.close()
