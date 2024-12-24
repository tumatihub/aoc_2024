extends Node

var input: String = "res://day_11/d11_pt01_input.txt"

func _ready() -> void:
	run()

func run() -> void:
	print("running: D11Pt01")
	var start_time := Time.get_ticks_msec()
	var file := FileAccess.open(input, FileAccess.READ)
	if !file:
		return
	
	var stone_line: StoneLine
	
	while file.get_position() < file.get_length():
		stone_line = StoneLine.new(file.get_line())
	
	file.close()
	
	stone_line.blink_n_times(25)
	
	print("Stone line size: " + str(stone_line.size()))
	var end_time := Time.get_ticks_msec()
	print("Finished in: %s seconds (%s msecs)" % [(end_time - start_time)/1000, end_time - start_time])
