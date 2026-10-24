extends MicroGame

@onready var agua: Area2D = $Static/agua
@onready var arvores: Node2D = $Static/Arvores
@onready var gotas: Array[Node] = $Static/Control/VBoxContainer.get_children()
const WATER = preload("uid://bwqpctjudtltb")
const FIRE_WHOOSH = preload("uid://dc7pisy77522p")

var gotas_restantes: int
var arvores_apagadas: Array[Area2D] = []

func _ready() -> void:
	super()
	reabastecer()

func _on_area_hold_trigger_area_entered(area: Area2D) -> void:
	if area == agua:
		SoundManager.play_sound(WATER)
		reabastecer()

# Só apaga depois que o jogador fica parado em cima da árvore por hold_time
func _on_area_hold_trigger_duration_reached(area: Area2D) -> void:
	if area.get_parent() == arvores:
		SoundManager.play_sound(FIRE_WHOOSH)
		apagar(area)


func reabastecer() -> void:
	gotas_restantes = gotas.size()
	for gota in gotas:
		gota.visible = true


func apagar(arvore: Area2D) -> void:
	# Sem gotas ou árvore já apagada: nada acontece
	if gotas_restantes == 0 or arvore in arvores_apagadas:
		return

	arvore.get_node("fogo").visible = false
	arvores_apagadas.append(arvore)

	gotas_restantes -= 1
	gotas[gotas_restantes].visible = false

	if arvores_apagadas.size() == arvores.get_child_count():
		game_won()
