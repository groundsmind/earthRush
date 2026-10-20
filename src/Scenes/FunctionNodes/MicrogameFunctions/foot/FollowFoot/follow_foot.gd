extends BodyMovementComponent

@export var vertical_offset: float = 50
@onready var parent = get_parent()
var lerp_speed: int = 10

func _process(_delta):
	parent.global_position = feet_midpoint
	parent.position.y -= vertical_offset
