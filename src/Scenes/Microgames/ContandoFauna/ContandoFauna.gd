extends MicroGame

@export var minSapos := 5
@export var maxSapos := 10

@onready var sapos: Node2D = $Dynamic/Sapos
@onready var opcoes: CanvasGroup = $Dynamic/opcoes
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var label1: Label = $Dynamic/opcoes/Botoes/botao1/Label
@onready var botao1: CollisionShape2D = $Dynamic/opcoes/Botoes/botao1/CollisionShape2D
@onready var label2: Label = $Dynamic/opcoes/Botoes/botao2/Label
@onready var botao2: CollisionShape2D = $Dynamic/opcoes/Botoes/botao2/CollisionShape2D
@onready var label3: Label = $Dynamic/opcoes/Botoes/botao3/Label
@onready var botao3: CollisionShape2D = $Dynamic/opcoes/Botoes/botao3/CollisionShape2D

@onready var lista_botao := [botao1, botao2, botao3]
@onready var lista_label := [label1, label2, label3]
@onready var foot: Area2D = $Dynamic/Foot

var sapoScene : PackedScene = load("res://Scenes/Microgames/ContandoFauna/sapo.tscn")

var num : int
var respondido := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	
	foot.hide()
	
	num = randi_range(minSapos, maxSapos)
	for i in range(num):
		var new = sapoScene.instantiate()
		new.position = Vector2(-50, -50)
		sapos.add_child(new)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	super(_delta)


func _on_timer_timeout() -> void:
	foot.show()
	foot.modulate = Color.TRANSPARENT
	var _ft = create_tween().tween_property(foot, "modulate", Color.WHITE, 1)
	
	opcoes.show()
	animation_player.play("answer")
	
	
	# Primeiro vamos preencher tudo com valores errados
	# Deslocamentos diferentes de 0, embaralhados, garantem valores errados distintos
	var deslocamentos := [-2, -1, 1, 2]
	deslocamentos.shuffle()
	for i in range(3):
		lista_label[i].text = str(num + deslocamentos[i])

	var correto = randi_range(0, 2)
	lista_label[correto].text = str(num)

	# Liga a colisão dos botões só agora que as opções aparecem
	for botao in lista_botao:
		botao.set_deferred("disabled", false)

func _on_foot_area_entered(area: Area2D) -> void:
	if respondido or area.get_parent() != $Dynamic/opcoes/Botoes:
		return
	respondido = true
	
	var chosen_label: Label = area.get_node("Label")
	for label in lista_label:
		if int(label.text) == num:
			var _anim = create_tween().tween_property(label, "modulate", Color.GREEN, 1.5)
			_anim.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
			if label == chosen_label:
				_anim.finished.connect(game_won)
			else:
				_anim.finished.connect(game_lost)
		else:
			var _anim = create_tween().tween_property(label, "modulate", Color.RED, 1.5)
			_anim.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
