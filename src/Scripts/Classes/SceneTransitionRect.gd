@icon("res://addons/at-icons/control/arrow_right_arrow_left.svg")
class_name SceneTransitionRect
extends ColorRect

@export var next_scene: String
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal scene_change

func _ready() -> void:
	show()
	animation_player.play_backwards("fade")

func transition_to(_next_scene = next_scene) -> void:
	scene_change.emit()
	animation_player.play("fade")
	await animation_player.animation_finished
	get_tree().change_scene_to_file.bind(_next_scene).call_deferred()
