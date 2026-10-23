extends MicroGame


func _ready() -> void:
	super._ready()

func _on_cup_shuffler_correct_cup_picked() -> void:
	game_won()

func _on_cup_shuffler_wrong_cup_picked() -> void:
	game_lost()
