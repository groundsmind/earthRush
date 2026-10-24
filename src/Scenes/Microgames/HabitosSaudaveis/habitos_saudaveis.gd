extends MicroGame

@onready var saudaveis :=[
	"res://Scenes/Microgames/HabitosSaudaveis/Assets/almoco.png",
	"res://Scenes/Microgames/HabitosSaudaveis/Assets/lanche.png",
	"res://Scenes/Microgames/HabitosSaudaveis/Assets/maçã.png"
]

@onready var cringes := [
	"res://Scenes/Microgames/HabitosSaudaveis/Assets/calabresa.png",
	"res://Scenes/Microgames/HabitosSaudaveis/Assets/podrao.png",
	"res://Scenes/Microgames/HabitosSaudaveis/Assets/biscoito.png"
]
@onready var alimento_1: Area2D = $"Dynamic/Alimento 1"
@onready var alimento_2: Area2D = $"Dynamic/Alimento 2"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var alimentoSaudavel : Area2D
var resolvidos := 0
var escolha := [0,1,2]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	escolha.shuffle()
	sortear()

func sortear() -> void:
	animation_player.play("in")
	alimentoSaudavel = [alimento_1, alimento_2].pick_random()
	var sorteado = escolha[0]
	escolha.remove_at(0)
	if alimentoSaudavel == alimento_1:
		alimento_1.get_node("Sprite2D").texture = load(saudaveis[sorteado])
		alimento_2.get_node("Sprite2D").texture = load(cringes[sorteado])
	else:
		alimento_2.get_node("Sprite2D").texture = load(saudaveis[sorteado])
		alimento_1.get_node("Sprite2D").texture = load(cringes[sorteado])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_foot_duration_reached(target_area: Area2D) -> void:
	if target_area == alimentoSaudavel:
		resolvidos += 1
		animation_player.play("out")
	else:
		game_lost()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if resolvidos >= 3:
		game_won()
	elif anim_name == "out":
		sortear()
