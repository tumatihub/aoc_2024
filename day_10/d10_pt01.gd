extends Node

var input: String = "res://day_10/d10_pt01_input.txt"

func _ready() -> void:
	run()

func run() -> void:
	print("running: D10Pt01")
	var file := FileAccess.open(input, FileAccess.READ)
	if !file:
		return
	
	var map := TopographicMap.new()
	
	while file.get_position() < file.get_length():
		map.add_line(file.get_line())
	
	file.close()
	
	
	
	print("Trailhead score: " + str(map.count_all_trails()))
	
