class_name PlayerJump
extends CharacterBody2D

@export var jump_velocity: float = 1000.0

@onready var jump_detector: JumpDetector = $JumpDetector

var feet_midpoint: Vector2
signal jump

func _process(_delta: float) -> void:
	feet_midpoint = jump_detector.feet_midpoint

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func _on_jump_detector_jumped() -> void:
	if is_on_floor():
		velocity.y = -jump_velocity
		jump.emit()
