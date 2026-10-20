extends BodyMovementComponent

@export var vertical_offset: float = 50
@export var can_interact: bool = true
@onready var parent = get_parent()
var lerp_speed: int = 10

func _ready() -> void:
	parent.monitorable = can_interact

func _process(_delta):
	parent.global_position = feet_midpoint
	parent.position.y -= vertical_offset
