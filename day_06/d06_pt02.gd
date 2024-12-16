extends Node

signal step
signal unpaused

var input: String = "res://day_06/d06_pt01_input.txt"
@export var lab_grid: LabMapGrid

var map: LabMap
var paused := false

@onready var timer: Timer = $Timer

func _ready() -> void:
	map = setup_input_map()
	#map = LabMap.new()
	#map.add(".#..#.....")
	#map.add("#>...#....")
	#map.add("..........")
	lab_grid.setup_grid(map)
	map.setup_guard()
	map.guard.position = Vector2i(102, 41)
	map.guard.dir = Vector2i.DOWN
	step.connect(move)
	await unpaused
	move()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		unpaused.emit()

func move() -> void:
	if map.guard.left_map:
		return
	map.move_guard_finding_loop()
	await get_tree().create_timer(0.1).timeout
	await mark_loop()
	step.emit()

func mark_loop() -> void:
	if map.last_loop_positions.size() == 0:
		return
	var colors: Array[Color] = []
	lab_grid.set_cell_color(map.obstructions[map.obstructions.size()-1], Color.BLACK)
	for pos in map.last_loop_positions:
		colors.append(lab_grid.get_cell_color(pos))
	for pos in map.last_loop_positions:
		lab_grid.set_cell_color(pos, Color.RED)
		await get_tree().create_timer(0.05).timeout
	await unpaused
	for idx in map.last_loop_positions.size():
		lab_grid.set_cell_color(map.last_loop_positions[idx], colors[idx])

func setup_input_map() -> LabMap:
	print("running: D06Pt02")
	var file := FileAccess.open(input, FileAccess.READ)
	if !file:
		return
	
	var map := LabMap.new()
	
	while file.get_position() < file.get_length():
		map.add(file.get_line())
	file.close()
	
	#map.setup_guard()
	return map
	#map.do_walk_guard_path_finding_loop()
	#print("Obstructions positions: " + str(map.obstructions.size()))
	#map.print_map(true)

func setup_example_map() -> LabMap:
	var map := LabMap.new()
	map.add("....#.....")
	map.add(".........#")
	map.add("..........")
	map.add("..#.......")
	map.add(".......#..")
	map.add("..........")
	map.add(".#..^.....")
	map.add("........#.")
	map.add("#.........")
	map.add("......#...")
	return map
