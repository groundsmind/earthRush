extends MicroGame

var lixo : PackedScene = load("res://Scenes/Microgames/LimpandoRio/lixo.tscn")
@onready var lixos: Node2D = $Dynamic/Lixos
@onready var animation_player: AnimationPlayer = $Dynamic/AnimationPlayer
@onready var lixo_timer: Timer = $Dynamic/lixoTimer

var score := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)


func _on_lixo_timer_timeout() -> void:
	var new = lixo.instantiate()
	lixos.add_child(new)


func _on_cesta_area_entered(area: Area2D) -> void:
	area.queue_free()
	score += 1
	if score >= 10:
		animation_player.play("limpandorio_win")
		lixo_timer.stop()
		lixos.queue_free()
		#animation_player.animation_finished.connect(game_won)


func _on_chao_area_entered(area: Area2D) -> void:
	area.queue_free()
	game_lost()


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	game_won()
