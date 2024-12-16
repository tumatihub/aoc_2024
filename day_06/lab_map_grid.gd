class_name LabMapGrid
extends GridContainer

signal changed_cell(pos: Vector2i)

@export var cell_scene: PackedScene

var last_cell_pos: Vector2i

func setup_grid(map: LabMap) -> void:
	map.set_cell.connect(set_cell)
	columns = map.map[0].size()
	for l in map.map:
		for c in l:
			var cell := cell_scene.instantiate() as Label
			add_child(cell)
			cell.text = c
	
func set_cell(pos: Vector2i, char: String) -> void:
	var cell := get_children()[pos.y*columns+pos.x] as Label
	cell.text = char
	changed_cell.emit(pos)
	if cell.self_modulate != Color.BLACK:
		cell.self_modulate = Color.BLUE

func get_cell_color(pos: Vector2i) -> Color:
	var cell := get_children()[pos.y*columns+pos.x] as Label
	return cell.self_modulate

func set_cell_color(pos: Vector2i, color: Color) -> void:
	var cell := get_children()[pos.y*columns+pos.x] as Label
	cell.self_modulate = color
	changed_cell.emit(pos)
