extends Area2D

@export var speed: float = 200

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta
