extends MicroGame

@onready var sol: AnimatedSprite2D = $Static/sol
@onready var cesta: AnimatedSprite2D = $Dynamic/Cesta/sprite
@onready var ovos: Node2D = $Dynamic/Ovos
@onready var montanhas: AnimatedSprite2D = $Static/montanhas
@onready var nuvens: Node2D = $Static/nuvens

var cena_ovo : PackedScene = load("res://Scenes/Microgames/PegaOvos/ovos.tscn")
var scoreOvo := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	sol.play("feliz")
	cesta.play("default")
	montanhas.play("default")
	for i in nuvens.get_children():
		i.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_ovo_timer_timeout() -> void:
	var ovo = cena_ovo.instantiate()
	ovos.add_child(ovo)
	


func _on_cesta_area_entered(area: Area2D) -> void:
	ovos.remove_child(area)
	scoreOvo += 1
	if scoreOvo >= 10:
		game_won()


func _on_chão_area_entered(_area: Area2D) -> void:
	sol.play("triste")
	game_lost()
