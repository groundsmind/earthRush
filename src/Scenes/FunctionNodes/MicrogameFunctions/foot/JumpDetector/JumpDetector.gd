class_name JumpDetector
extends BodyMovementComponent

@export var jump_distance_threshold: float = 1500

signal jumped

func _process(_delta: float) -> void:
	if feet_midpoint.y > jump_distance_threshold:
		jumped.emit()
