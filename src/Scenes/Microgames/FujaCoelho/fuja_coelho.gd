extends MicroGame

@onready var label: Label = $Label
@onready var node_2d: Node2D = $Node2D

func _process(_delta: float) -> void:
	label.text = str(node_2d.global_position.y)
