extends MicroGame

@onready var regador: Sprite2D = $Dynamic/regador
var water_cycles: int = 0

func _ready() -> void:
	super._ready()

func _on_regador_finished_watering() -> void:
	water_cycles += 1
	if water_cycles == 3:
		game_won()
