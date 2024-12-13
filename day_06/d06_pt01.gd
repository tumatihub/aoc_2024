extends Node

var input: String = "res://day_06/d06_pt01_input.txt"

func _ready() -> void:
	run()

func run() -> void:
	print("running: D06Pt01")
	var file := FileAccess.open(input, FileAccess.READ)
	if !file:
		return
	
	var map := LabMap.new()
	
	while file.get_position() < file.get_length():
		map.add(file.get_line())
	
	map.setup_guard()
	map.do_walk_guard_path()
	print("Path positions: " + str(map.count_path_positions()))
	file.close()
