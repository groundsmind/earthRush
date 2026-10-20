# Thanks KevinStirling for the sample microgame code. #
#   https://github.com/KevinStirling/GodotMicroKit    #

extends Node2D
class_name MicroGame

@export var game_end_timer : Timer
@export var VerbHint: String = "Agir"
@export var player_start: Node2D

var is_active : bool = false

var start_time: int
var total_time: float

signal won(scene)
signal lost(scene)

func _ready():
	start_time = Time.get_ticks_msec()
	start_game()

func _process(_delta: float) -> void:
	var current_time: int = Time.get_ticks_msec()
	var time_passed_ms: int = current_time - start_time
	total_time = time_passed_ms / 1000.0

func start_game():
	print_debug("starting")
	is_active = true
	game_end_timer.timeout.connect(game_lost)
	game_end_timer.start()

func game_won():
	if not is_active: return
	print_debug("game won!! emmitting...")
	won.emit(self)
	
func game_lost():
	if not is_active: return
	print_debug("game lost!! emmitting...")
	lost.emit(self)
