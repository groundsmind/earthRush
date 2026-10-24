@icon("res://addons/at-icons/node2d/reticle.svg")
class_name FootPositionEnforcerer
extends Node2D

@export var hold_time: float = 4.0

@onready var target: Area2D = $Target
@onready var crosshair: Sprite2D = $Target/Crosshair
@onready var rotation_speed: float = 0.01
@onready var curr_rot: float = rotation_speed
@onready var timer: Timer = $Timer

var mid_transition: bool = false
signal on_area

func _ready() -> void:
	timer.wait_time = hold_time

func _physics_process(delta: float) -> void:
	if target.colliding:
		curr_rot = lerp(curr_rot, rotation_speed, delta*10)
	else:
		curr_rot = lerp(curr_rot, 0.0, delta*10)
	crosshair.rotation += curr_rot

func set_monitoring(working:bool):
	if working:
		target.monitoring = true
	else:
		target.monitoring = false

func _on_target_area_entered(_area: Area2D) -> void:
	timer.start()

func _on_target_area_exited(_area: Area2D) -> void:
	timer.stop()

func _on_timer_timeout() -> void:
	on_area.emit()
