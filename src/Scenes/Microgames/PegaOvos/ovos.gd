extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var startPos := -100
@export var rotationSpeed := 0.1
@export var speed := -5

var rng := RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(rng.randi_range(250, 1400), startPos)
	animated_sprite_2d.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	rotate(rotationSpeed)
	position -= Vector2(0, speed)
