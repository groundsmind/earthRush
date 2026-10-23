extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
const SND_VICTORY = preload("uid://d3ufqexb6stk3")

func _ready() -> void:
	animation_player.play("enter")
	if GameInfo.current_game["timeout win"]:
		SoundManager.play_sound(SND_VICTORY)
