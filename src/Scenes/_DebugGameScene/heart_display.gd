extends Node2D

@export var full_texture: Texture2D
@export var broken_texture: Texture2D

@onready var hearts: Array = get_children()
@onready var game_mgr: Node2D = $"../../.."

var curr_heart_idx: int = 2
var hp: int

func _ready() -> void:
	for heart in hearts:
		heart.texture = full_texture
	while game_mgr.current_hp == null:
		await get_tree().process_frame
	game_mgr.hp_change.connect(_on_hp_decrease)
	hp = game_mgr.current_hp

func _on_hp_decrease() -> void:
	if curr_heart_idx >= 0 and curr_heart_idx < hearts.size():
		hearts[curr_heart_idx].texture = broken_texture
		curr_heart_idx -= 1
