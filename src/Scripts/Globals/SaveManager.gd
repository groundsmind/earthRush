extends Node

# The user:// path ensures data persists outside the game engine installation directory
const SAVE_PATH = "user://savegame.data"

# Dictionary holding all variables you want to persist across sessions
var game_data = {
	"player_name": "Hero",
	"high_score": 0,
	"unlocked_levels": [1],
	"sound_volume": 1.0
}

func _ready() -> void:
	load_game()

# Write data to the device
func save_game() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(game_data)
		file.close()
		print("game saved")

# Read data from the device
func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found; making one")
		return
		
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var loaded_data = file.get_var()
		file.close()
		
		if loaded_data is Dictionary:
			for key in loaded_data.keys():
				game_data[key] = loaded_data[key]
		print("game loaded")
