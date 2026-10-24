extends MicroGame

const CONFIRMATION_004 = preload("uid://dwhqmge04fk8y")

func _ready() -> void:
	super._ready()

func _on_cup_shuffler_correct_cup_picked() -> void:
	SoundManager.play_sound(CONFIRMATION_004)
	game_won()

func _on_cup_shuffler_wrong_cup_picked() -> void:
	game_lost()
