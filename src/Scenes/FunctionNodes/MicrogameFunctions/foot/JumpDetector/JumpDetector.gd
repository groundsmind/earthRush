class_name JumpDetector
extends BodyMovementComponent

@export var jump_distance_threshold: float = 1450
var can_jump: bool = true

signal jumped

func _process(_delta: float) -> void:
	super(_delta)
	if feet_midpoint.y > jump_distance_threshold:
		jumped.emit()
		can_jump = false
	else:
		can_jump = true
