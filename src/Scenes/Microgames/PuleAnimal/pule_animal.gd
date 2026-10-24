extends MicroGame

@onready var player_sprite: AnimatedSprite2D = $Dynamic/PlayerJump/PlayerSprite

func _on_player_area_entered(_area: Area2D) -> void:
	game_lost()

func _on_timer_timeout() -> void:
	game_won()
