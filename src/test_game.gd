extends MicroGame

@onready var goal: Area2D = $Goal
@onready var obstacle: Area2D = $obstacle

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		game_won()



func _on_player_area_entered(area: Area2D) -> void:
	if area == obstacle:
		game_lost()
	if area == goal:
		game_won()
