extends MicroGame

@onready var agua: Area2D = $Static/agua
@onready var arvores: Node2D = $Static/Arvores
@onready var gotas: Array[Node] = $Static/Control/VBoxContainer.get_children()

var gotas_restantes: int
var arvores_apagadas: Array[Area2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	reabastecer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)


func _on_area_hold_trigger_area_entered(area: Area2D) -> void:
	if area == agua:
		reabastecer()

# Só apaga depois que o jogador fica parado em cima da árvore por hold_time
func _on_area_hold_trigger_duration_reached(area: Area2D) -> void:
	if area.get_parent() == arvores:
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
