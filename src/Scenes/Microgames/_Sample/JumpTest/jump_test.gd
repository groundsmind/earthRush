extends MicroGame

@onready var label: Label = $Label
@onready var player_jump: CharacterBody2D = $PlayerJump

func _ready():
	super._ready()

func _process(_delta: float) -> void:
	label.text = str(player_jump.feet_midpoint.y)
