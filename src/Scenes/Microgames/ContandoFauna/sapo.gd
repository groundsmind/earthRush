extends Sprite2D

@onready var sprite: Sprite2D = $"."
@onready var timer: Timer = $Timer
@export var margin: float = 20.0 # Safety buffer from the screen edge
@export var move_duration: float = 1.0

var rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = rng.randf_range(0.5, 3)
	timer.autostart = true
	timer.start()
	move_to_random_point()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func move_to_random_point() -> void:
	# 1. Get the viewport bounds in actual global world space
	var canvas_transform: Transform2D = get_canvas_transform()
	var top_left: Vector2 = -canvas_transform.get_origin() / canvas_transform.get_scale()
	var view_size: Vector2 = get_viewport_rect().size / canvas_transform.get_scale()
	var bottom_right: Vector2 = top_left + view_size
	
	var sprite_half_width: float = (sprite.texture.get_width() * scale.x) / 2.0 if sprite.texture else 0.0
	var sprite_half_height: float = (sprite.texture.get_height() * scale.y) / 2.0 if sprite.texture else 0.0
	
	var min_x: float = top_left.x + sprite_half_width + margin
	var max_x: float = bottom_right.x - sprite_half_width - margin
	var min_y: float = top_left.y + sprite_half_height + margin
	var max_y: float = bottom_right.y - sprite_half_height - margin * 2
	
	var target_global_pos: Vector2 = Vector2(
		randf_range(min_x, max_x),
		randf_range(min_y, max_y)
	)
	
	var target_angle: float = global_position.angle_to_point(target_global_pos)+deg_to_rad(45)
	
	var tween: Tween = create_tween().set_parallel(true)
	
	tween.tween_property(self, "global_position", target_global_pos, move_duration)
	tween.tween_property(self, "global_rotation", target_angle, move_duration * 0.3)
	
	timer.wait_time = rng.randf_range(2, 6)
	


func _on_timer_timeout() -> void:
	move_to_random_point()
