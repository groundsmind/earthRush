extends Node2D

@export var player: Node2D

@onready var bullet_spawn: Marker2D = $BulletSpawn
const BULLET = preload("uid://onbnfwhlm5nt")
const LASER_1 = preload("uid://35y6uljtb6ae")

signal player_hit(player)

func _process(delta: float) -> void:
	var target_position: Vector2 = player.global_position
	var target_angle: float = global_position.direction_to(target_position).angle()
	global_rotation = lerp_angle(global_rotation, target_angle, 5 * delta)

func _on_timer_timeout() -> void:
	var bullet = BULLET.instantiate()
	bullet_spawn.add_child(bullet)
	bullet.top_level = true
	bullet.global_position = bullet_spawn.global_position
	bullet.rotation = rotation
	bullet.body_entered.connect(_on_bullet_body_entered)
	SoundManager.play_sound(LASER_1)

func _on_bullet_body_entered(_body: Node2D) -> void:
	player_hit.emit(_body)
