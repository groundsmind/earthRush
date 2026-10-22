extends MicroGame

var water_cycles: int = 0
var has_won: bool = false

func _ready() -> void:
	super._ready()

func _on_regador_flower_done() -> void:
	if has_won:
		return
		
	water_cycles += 1
	if water_cycles == 3:
		has_won = true
		game_won()
