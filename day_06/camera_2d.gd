extends Camera2D

@export var grid: LabMapGrid
@export var speed: float = 500.0

var follow_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
	grid.changed_cell.connect(follow)

func follow(pos: Vector2i) -> void:
	follow_pos = grid.global_position + Vector2(pos.x * 25, pos.y * 25)

func _process(delta: float) -> void:
	global_position = global_position.lerp(follow_pos, .9)
