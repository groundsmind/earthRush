extends MicroGame

@onready var node_2: Area2D = $Node2

func _on_node_area_entered(area: Area2D) -> void:
	if area == node_2:
		game_won()
	else:
		game_lost()
