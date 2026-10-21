# Thanks KevinStirling for the sample microgame code. #
#   https://github.com/KevinStirling/GodotMicroKit    #

@icon("res://addons/at-icons/node2d/controller.svg")
extends Node2D
class_name MicroGame

@export var VerbHint: String = "Agir"
@export var player_start: Node2D
@export var time_limit: float = 10.0

var game_end_timer: Timer = Timer.new()

var is_active : bool = false

var start_time: int
var total_time: float

signal won(scene)
signal lost(scene)

func _ready():
	game_end_timer.wait_time = time_limit
	add_child(game_end_timer)
	start_time = Time.get_ticks_msec()
	start_game()

func _process(_delta: float) -> void:
	if not is_active: return
	var current_time: int = Time.get_ticks_msec()
	var time_passed_ms: int = current_time - start_time
	total_time = time_passed_ms / 1000.0

func start_game():
	is_active = true
	if not game_end_timer.timeout.is_connected(game_lost):
		game_end_timer.timeout.connect(game_lost)
	game_end_timer.start()

func game_won():
	if not is_active: return
	_end_game_sequence()
	print_debug("game won!! emmitting...")
	won.emit(self)
	
func game_lost():
	if not is_active: return
	print_debug("game lost!! emmitting...")
	lost.emit(self)

func _end_game_sequence():
	is_active = false
	game_end_timer.stop()
	if game_end_timer.timeout.is_connected(game_lost):
		game_end_timer.timeout.disconnect(game_lost)
