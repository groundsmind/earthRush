extends Button

@export var max_scale: float = 1.25
@onready var base_scale = scale.x

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pivot_offset = Vector2(size.x/2, size.y/2)

func _on_mouse_entered() -> void:
	zoom_hover(max_scale)

func _on_mouse_exited() -> void:
	zoom_hover(base_scale)
	
func zoom_hover(scale_amount: float) -> void:
	var hover_tween = create_tween()
	hover_tween.tween_property(self, "scale", Vector2(scale_amount, scale_amount), 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
