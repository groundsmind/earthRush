# Thanks KevinStirling for the sample microgame code. #
#   https://github.com/KevinStirling/GodotMicroKit    #

extends Node2D

@export var game_list : Array[PackedScene]  
@export var randomize_game_order : bool = true
@export var microgame_parent: Node2D

@onready var transition_timer = $TransitionTimer
@onready var transition_animation_player = $TransitionVisuals/Transition/AnimationPlayer
@onready var game_end_timer_display = $GameEndTimerDisplay
@onready var result_label: Label = $TransitionVisuals/Transition/ResultLabel

# game variables #
var total_hp: int = 3
@onready var current_hp = total_hp

var games_played: int = 0 
var games_won: int = 0

var current_game : MicroGame
var transitioning : bool = false

signal hp_change

func _ready() -> void:
	transition_timer.timeout.connect(start_transition)
	transition_timer.start()

func start_transition() -> void:
	print_debug("starting transition...")
	if game_list.is_empty():
		print("No more microgames left.")
		return
	if current_hp == 0:
		start_game_over_sequence()
	
	transitioning = false 
	var next_game : PackedScene
	if randomize_game_order:
		next_game = game_list.pick_random()
	else:
		next_game = game_list.pop_front()
	print_debug("transitioning to ", next_game.resource_name)
	current_game = next_game.instantiate()
	microgame_parent.add_child(current_game)
	current_game.won.connect(game_won)
	current_game.lost.connect(game_lost)
	transition_animation_player.play("open")

func start_game_over_sequence() -> void:
	pass

func game_won(scene) -> void:
	print_debug("received game won!")
	end_microgame(scene, "win!!")
	games_won += 1

func game_lost(scene) -> void:
	print_debug("received game lost!")
	end_microgame(scene, "lose!! :(")
	decrease_health()

func end_microgame(scene, result_text: String) -> void:
	if transitioning: return
	transitioning = true
	transition_animation_player.play("close")
	result_label.text = result_text
	await transition_animation_player.animation_finished
	cleanup_microgame(scene)
	games_played += 1

	await get_tree().create_timer(2).timeout
	start_transition()

func cleanup_microgame(scene):
	if is_instance_valid(scene):
		scene.queue_free()
	current_game = null

func decrease_health() -> void:
	current_hp -= 1
	hp_change.emit()

func _process(_delta) -> void:
	if is_instance_valid(current_game) and current_game.game_end_timer:
		game_end_timer_display.text = str(int(current_game.game_end_timer.time_left))
	else:
		game_end_timer_display.text = ""
