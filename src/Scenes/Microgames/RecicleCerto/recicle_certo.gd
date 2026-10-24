extends MicroGame

@onready var trash: Area2D = $trash
@onready var lixos: Sprite2D = $Lixos
const FOOTSTEP_SNOW_004 = preload("uid://bxlfutbkt5lk")
const AW = preload("uid://cxtmf6q4a2aji")

func _ready():
	super._ready()


func _on_trash_area_entered(area: Area2D) -> void:
	if trash.right_trash.name == area.name:
		SoundManager.play_sound(FOOTSTEP_SNOW_004)
		game_won()
	else:
		SoundManager.play_sound(AW)
		game_lost()
