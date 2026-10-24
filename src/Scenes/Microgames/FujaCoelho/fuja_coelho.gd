extends MicroGame

@onready var label: Label = $Label
@onready var jump_detector: JumpDetector = $Player/JumpDetector

func _ready():
	super._ready()

func _process(_delta: float) -> void:
	label.text = str(jump_detector.feet_midpoint.y)
