extends MicroGame

@onready var animais := [
	$Static/Animais/arara,
	$Static/Animais/sapo,
	$Static/Animais/tamandua,
	$Static/Animais/tucano
]
@onready var sombra: Sprite2D = $Static/sombra

var correto: Area2D
var respondido := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	# Sorteia o animal do centro e copia o formato dele, em preto
	correto = animais.pick_random()
	var sprite: Sprite2D = correto.get_node("Sprite2D")
	sombra.texture = sprite.texture
	sombra.scale = sprite.scale
	sombra.modulate = Color.BLACK

	for animal in animais:
		animal.duration_reached.connect(_on_animal_pisado.bind(animal))


func _on_animal_pisado(_pe: Area2D, animal: Area2D) -> void:
	if respondido or not is_active:
		return
	respondido = true

	# Revela o animal do centro e espera um pouco antes de terminar
	sombra.modulate = Color.WHITE
	game_end_timer.stop()
	await get_tree().create_timer(1.0).timeout

	if animal == correto:
		game_won()
	else:
		game_lost()
