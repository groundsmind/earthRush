# Thanks KevinStirling for the sample microgame code. #
#   https://github.com/KevinStirling/GodotMicroKit    #

extends Node2D

@export var game_list : Array[PackedScene]  
@export var randomize_game_order : bool = true
@export var microgame_parent: Node2D

@onready var transition_timer = $TransitionTimer
@onready var transition_animation_player = $TransitionVisuals/Transition/AnimationPlayer
@onready var victory_label = $TransitionVisuals/Transition/VictoryLabel
@onready var defeat_label = $TransitionVisuals/Transition/DefeatLabel
@onready var game_end_timer_display = $Hud/CanvasLayer/GameEndTimerDisplay

var current_game : MicroGame
var transitioning : bool = false

func _ready():
	transition_timer.timeout.connect(start_transition)
	transition_timer.start()

func start_transition():
	print_debug("starting transition...")
	if game_list.is_empty():
		print("Game Over! No more microgames left.")
		return # Or trigger a game-over screen here
	
	transitioning = false 
	var next_game : PackedScene
	victory_label.visible = false
	defeat_label.visible = false
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
	
func game_won(scene):
	print_debug("received game won!")
	end_microgame(scene, victory_label)

func game_lost(scene):
	print_debug("received game lost!")
	end_microgame(scene, defeat_label)

func end_microgame(scene, result_label: Label):
	if transitioning: return
	transitioning = true
	transition_animation_player.play("close")
	result_label.visible = true
	await transition_animation_player.animation_finished
	cleanup_microgame(scene)

	await get_tree().create_timer(2).timeout
	start_transition()

func cleanup_microgame(scene):
	if is_instance_valid(scene):
		scene.queue_free()
	current_game = null

func _process(_delta):
	if is_instance_valid(current_game) and current_game.game_end_timer:
		game_end_timer_display.text = str(int(current_game.game_end_timer.time_left))
	else:
		game_end_timer_display.text = ""
