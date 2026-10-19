# Thanks KevinStirling for the sample microgame code. #
#   https://github.com/KevinStirling/GodotMicroKit    #

extends Node2D

@export var lerp_speed = 1
@export var hide_mouse = false

@onready var parent_sprite = get_parent()

func _get_configuration_warnings() -> PackedStringArray:
	if parent_sprite is Sprite2D :
		return []
	return ["Must be attached to a Sprite2D node!"]

func _ready():
	if hide_mouse:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(_delta):
	parent_sprite.position = lerp(position, get_global_mouse_position(), lerp_speed)
