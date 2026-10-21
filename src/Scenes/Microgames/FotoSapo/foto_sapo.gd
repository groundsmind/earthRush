extends MicroGame

@onready var frog_in_frame_timer: Timer = $Dynamic/playerCamera/FrogInFrameTimer
@onready var color_rect: ColorRect = $ColorRect

func _ready():
	super._ready()
	color_rect.hide()

func _on_player_camera_area_entered(_area: Area2D) -> void:
	frog_in_frame_timer.start()

func _on_player_camera_area_exited(_area: Area2D) -> void:
	frog_in_frame_timer.stop()

func _on_frog_in_frame_timer_timeout() -> void:
	color_rect.show()
	var tween = create_tween()
	tween.tween_property(color_rect, "color", Color.TRANSPARENT, 1.0)
	tween.tween_callback(game_won)
