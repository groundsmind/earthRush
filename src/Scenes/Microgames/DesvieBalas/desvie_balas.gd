extends MicroGame

@onready var game_win_timer: Timer = $GameWinTimer
@onready var player: CharacterBody2D = $Dynamic/Player
@onready var bullet_spawn: Marker2D = $Dynamic/Arma/BulletSpawn

const BFDI_YAY = preload("uid://c7ddsvlis1lbh")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()

func _on_arma_player_hit(body) -> void:
	if body == player:
		clean_bullets()
		game_lost()

func _on_game_win_timer_timeout() -> void:
	clean_bullets()
	SoundManager.play_sound(BFDI_YAY)
	game_won()

func clean_bullets() -> void:
	for bullet in bullet_spawn.get_children():
		bullet.queue_free()
