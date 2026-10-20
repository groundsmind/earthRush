extends Node2D

var time: float = 0.0
@export var speed: float = 2.0
@export var amplitude: float = 0.25

func _ready() -> void:
	time += randf_range(0.0, 2)

func _process(delta: float) -> void:
	time += delta
	rotation = sin(time * speed) * amplitude
