extends MicroGame

@export var goal : Area2D
@export var player: Area2D

func _ready():
	super._ready()
	goal.set_deferred("monitoring", true)
	player.set_deferred("monitorable", true)
	goal.area_entered.connect(_on_area_entered)
	start_game()

func _on_area_entered(area):
	if area == player:
		game_won()
