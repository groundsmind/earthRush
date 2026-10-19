extends Node2D

@export var lerp_speed = 10

@onready var parent_sprite = get_parent()

func _get_configuration_warnings() -> PackedStringArray:
	if parent_sprite is Sprite2D :
		return []
	return ["Must be attached to a Sprite2D node!"]

func _process(delta):
	parent_sprite.position = lerp(position, FeetTracking.feet_pos, lerp_speed*delta)
