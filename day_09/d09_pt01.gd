extends Node

var input: String = "res://day_09/d09_pt01_input.txt"

func _ready() -> void:
	run()

func run() -> void:
	print("running: D09Pt01")
	var file := FileAccess.open(input, FileAccess.READ)
	if !file:
		return
	
	var map := DiskMap.new()
	while file.get_position() < file.get_length():
		map.add_dense_line(file.get_line())
	
	file.close()
	
	map.expand()
	
	file = FileAccess.open("res://day_09/expanded_output.txt", FileAccess.WRITE)
	file.store_string("".join(map.expanded_map))
	file.close()
	
	map.defrag()
	
	file = FileAccess.open("res://day_09/defrag_output.txt", FileAccess.WRITE)
	file.store_string("".join(map.expanded_map))
	file.close()
	
	print("string count: " + str(map.string_count))
	print("map size: " + str(map.size()))
	print("expanded map size: " + str(map.expanded_size()))
	#print("Last block: " + str(map.dense_map[19998]))
	#print("Last block expanded: " + str(map.expanded_map[239196]))
	print("Checksum: " + str(map.checksum()))
	
