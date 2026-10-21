extends BodyMovementComponent

@export var parent_node: Node2D
@export var track_x: bool = true
@export var track_y: bool = true
@export var vertical_offset: float = 50
@export var can_interact: bool = true
@export var debug_mouse_pos: bool = false

func _ready() -> void:
	if not parent_node:
		parent_node = get_parent() as Node2D
	if parent_node is Area2D:
		parent_node.monitorable = can_interact

func _process(_delta):
	if parent_node:
		var foot_pos: Vector2
		if not debug_mouse_pos:
			foot_pos = feet_midpoint if feet_midpoint else Vector2.ZERO
		else:
			foot_pos = get_viewport().get_mouse_position()
		if track_x:
			parent_node.global_position.x = foot_pos.x
		if track_y:
			parent_node.global_position.y = foot_pos.y
			parent_node.position.y -= vertical_offset
