extends Area2D

@onready var sprite: Sprite2D = $Sprite2D
const APPLE_CORE = preload("uid://tdj6vmthx66v")
const BOTTLE = preload("uid://bh6clw7cn2vsu")
const CAN = preload("uid://cqa6ogognwbo2")

var sprites := [APPLE_CORE, BOTTLE, CAN]

@export var startPos := -100
@export var rotationSpeed := 0.1
@export var speed := -5

var rng := RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(startPos, rng.randi_range(250, 1100))
	sprite.texture = sprites.pick_random()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	rotate(rotationSpeed)
	position -= Vector2(speed, 0)
