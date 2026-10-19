# Thanks KevinStirling for the sample microgame code. #
#   https://github.com/KevinStirling/GodotMicroKit    #

extends Node2D
class_name MicroGame

@export var game_end_timer : Timer
@export var VerbHint: String = "Agir"

var is_active : bool = false

signal won(scene)
signal lost(scene)

func _ready():
	start_game()
	
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
