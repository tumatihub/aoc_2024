extends Node

var input: String = "res://day_08/d08_pt01_input.txt"

func _ready() -> void:
	run()

func run() -> void:
	print("running: D08Pt01")
	var file := FileAccess.open(input, FileAccess.READ)
	if !file:
		return
	
	var map := AntennaMap.new()
	
	while file.get_position() < file.get_length():
		map.add_line(file.get_line())
	
	map.find_antennas()
	map.find_antinodes()
	
	print("Total antinodes: " + str(map.antinodes.size()))
	file.close()
