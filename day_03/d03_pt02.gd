extends Node

var input: String = "res://day_03/d03_pt01_input.txt"

func _ready() -> void:
	run()

func run() -> void:
	print("running: D03Pt02")
	var string := FileAccess.get_file_as_string(input)
	var calculator := Calculator.new()
	var operation_list := calculator.find_expressions(string)
	var result := calculator.evaluate_operations(operation_list)
	
	print("Result for all operations: " + str(result))
