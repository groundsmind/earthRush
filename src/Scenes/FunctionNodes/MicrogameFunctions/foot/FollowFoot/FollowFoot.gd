class_name FollowFoot
extends BodyMovementComponent

@export var parent_node: Node2D
@export_enum("Midpoint", "Left foot", "Right foot") var tracking: String = "Midpoint"
@export var track_x: bool = true
@export var track_y: bool = true
@export var vertical_offset: float = 50
@export var can_interact: bool = true
@export var debug_mouse_pos: bool = false
@export var character_max_speed: float = 0.0
@export var character_slide: bool = true
var _character: CharacterBody2D
var _target_pos: Vector2

func _ready() -> void:
	if not parent_node:
		parent_node = get_parent() as Node2D
	if parent_node is Area2D:
		parent_node.monitorable = can_interact
	if parent_node is CharacterBody2D:
		_character = parent_node

	set_physics_process(_character != null)
	if parent_node:
		_target_pos = parent_node.global_position

func _process(_delta) -> void:
	super(_delta) 
	if not parent_node:
		return
	var foot_pos: Vector2
	if not debug_mouse_pos:
		match tracking:
			"Midpoint":
				foot_pos = feet_midpoint if feet_midpoint else Vector2.ZERO
			"Left foot":
				foot_pos = left_foot if left_foot else Vector2.ZERO
			"Right foot":
				foot_pos = right_foot if right_foot else Vector2.ZERO
	else:
		foot_pos = get_viewport().get_mouse_position()
		
	var target := parent_node.global_position
	target.x = foot_pos.x if track_x else parent_node.global_position.x
	target.y = foot_pos.y-vertical_offset if track_y else parent_node.global_position.y

	if _character:
		_target_pos = target
	else:
		parent_node.global_position = target


func _physics_process(delta: float) -> void:
	if not _character:
		return
	var motion := _target_pos - _character.global_position
	# Dead zone avoids micro-jitter when already at the target.
	if motion.length() < 0.5:
		return
	if character_max_speed > 0.0:
		motion = motion.limit_length(character_max_speed * delta)

	var collision := _character.move_and_collide(motion)
	if collision and character_slide:
		var remainder := collision.get_remainder().slide(collision.get_normal())
		_character.move_and_collide(remainder)
