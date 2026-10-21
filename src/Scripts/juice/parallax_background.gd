extends Node2D

@export var intensity: float = 2.0

func _process(delta: float) -> void:
	position += (get_global_mouse_position()*intensity*delta)-position
