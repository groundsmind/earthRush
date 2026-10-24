extends MicroGame

@onready var trash: Area2D = $trash
@onready var lixos: Sprite2D = $Lixos

func _ready():
	super._ready()


func _on_trash_area_entered(area: Area2D) -> void:
	if trash.right_trash.name == area.name:
		game_won()
	else:
		game_lost()
