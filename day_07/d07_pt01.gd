extends Node

var input: String = "res://day_07/d07_pt01_input.txt"

func _ready() -> void:
	run()

func run() -> void:
	print("running: D07Pt01")
	var file := FileAccess.open(input, FileAccess.READ)
	if !file:
		return
	
	var eq_list: Array[RepairEquation] = []
	
	while file.get_position() < file.get_length():
		eq_list.append(RepairEquation.new(file.get_line()))
	
	var sum := 0
	for eq in eq_list:
		if eq.is_valid():
			sum += eq.test_value
	
	print("Total calibration: " + str(sum))
	file.close()
