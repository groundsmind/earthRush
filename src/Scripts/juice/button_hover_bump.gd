extends Button

@export var max_scale: float = 1.25
@onready var base_scale = scale.x
const SND_CLICK = preload("uid://c61nebcq6fqdf")

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_button_pressed)
	pivot_offset = Vector2(size.x/2, size.y/2)

func _on_mouse_entered() -> void:
	SoundManager.play_sound_with_pitch(SND_CLICK, randf_range(0.8,1.0))
	zoom_hover(max_scale)

func _on_mouse_exited() -> void:
	zoom_hover(base_scale)

func _on_button_pressed() -> void:
	var _zoom = create_tween().tween_property(self, "scale", Vector2(0.001, 0.001), 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	var _spin = create_tween().tween_property(self, "rotation", deg_to_rad(720), 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	mouse_entered.disconnect(_on_mouse_entered)
	mouse_exited.disconnect(_on_mouse_exited)

func zoom_hover(scale_amount: float) -> void:
	var hover_tween = create_tween()
	hover_tween.tween_property(self, "scale", Vector2(scale_amount, scale_amount), 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
