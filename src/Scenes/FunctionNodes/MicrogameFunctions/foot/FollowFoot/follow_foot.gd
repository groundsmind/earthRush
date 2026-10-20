extends Node2D

@export var vertical_offset: float = 50
@onready var parent = get_parent()
var lerp_speed: int = 10


func _process(delta):
	parent.global_position = FootPosition.midpoint
	parent.position.y -= vertical_offset
