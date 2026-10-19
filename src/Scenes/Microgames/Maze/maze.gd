extends MicroGame

@export var goal : Area2D
@export var obstacle: Area2D

var game_ended: bool = false

func _ready():
	goal.set_deferred("monitoring", true)
	obstacle.set_deferred("monitoring", true)
	goal.area_entered.connect(_on_goal_entered)
	obstacle.area_entered.connect(_on_obstacle_hit)
	start_game()

func _on_goal_entered(_area):
	if not game_ended:
		game_won()
		game_ended = true

func _on_obstacle_hit(_area):
	if not game_ended:
		game_lost()
		game_ended = true
