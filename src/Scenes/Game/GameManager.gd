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
@onready var scene_transition_rect: ColorRect = $SceneTransitionRect

# game variables #
var total_hp: int = 3
@onready var current_hp = total_hp

var game_stats: Dictionary = {
	"score": 0,
	"games won": 0,
	"games played": 0,
	"total time": 0,
	"average time": 0
}

var current_game : MicroGame
var transitioning : bool = false

signal hp_change

func _ready() -> void:
	var next_game = pick_game()
	set_action_word(next_game)
	transition_timer.timeout.connect(start_transition.bind(next_game))
	transition_timer.start()

func start_transition(next_game: PackedScene) -> void:
	print_debug("starting transition...")	
	transitioning = false
	print_debug("transitioning to ", next_game.resource_name)
	current_game = next_game.instantiate()
	microgame_parent.add_child(current_game)
	current_game.won.connect(game_won)
	current_game.lost.connect(game_lost)
	transition_animation_player.play("open")

func pick_game() -> PackedScene:
	var next_game : PackedScene
	if randomize_game_order:
		next_game = game_list.pick_random()
	else:
		next_game = game_list.pop_front()
	return next_game

func start_game_over_sequence() -> void:
	game_stats["average time"] = game_stats.get("total time")/game_stats.get("games played")
	GameInfo.current_game = game_stats
	scene_transition_rect.transition_to("res://Scenes/GameOver/game_over.tscn")

func game_won(scene) -> void:
	print_debug("received game won!")
	game_stats["total time"] += scene.total_time
	game_stats["score"] += 5
	game_stats["games won"] += 1
	game_stats["games played"] += 1
	end_microgame(scene)

func game_lost(scene) -> void:
	print_debug("received game lost!")
	game_stats["score"] -= 2
	game_stats["games played"] += 1
	decrease_health()
	end_microgame(scene)

func end_microgame(scene) -> void:
	check_game_over()
	if transitioning: return
	transitioning = true
	var next_game = pick_game()
	set_action_word(next_game)
	transition_animation_player.play("close")
	await transition_animation_player.animation_finished
	cleanup_microgame(scene)

	await get_tree().create_timer(4).timeout
	start_transition(next_game)

func check_game_over() -> void:
	if current_hp <= 0:
		transitioning = true
		start_game_over_sequence()

func set_action_word(game: PackedScene) -> void:
	result_label.text = game.instantiate().VerbHint
	result_label.pivot_offset = result_label.size/2

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
