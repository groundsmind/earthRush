extends Node2D

@export var bus_name: String = "Music" 
@export var effect_index: int = 0
const CUTOFF_NORMAL: float = 20000.0      # unmuffled
const CUTOFF_MUFFLED: float = 600.0       # muffled
const DURATION: float = 0.5               # transition time
var active_tween: Tween

func _ready() -> void:
	SoundManager.set_default_music_bus("Music") 
	var song_pool: Array[AudioStream] = MusicGetter.get_audio_streams_in_folder("res://Assets/Sounds/Music/")
	var random_song = song_pool.pick_random()
	SoundManager.play_music(random_song)
	toggle_muffle(true)

func _on_animation_player_animation_started(anim_name: StringName) -> void:
	match anim_name:
		"close":
			toggle_muffle(true)
		"open":
			toggle_muffle(false)

func toggle_muffle(muffled: bool) -> void:
	var target_hz: float = CUTOFF_MUFFLED if muffled else CUTOFF_NORMAL
	var bus_idx = AudioServer.get_bus_index(bus_name)
	var lowpass_effect = AudioServer.get_bus_effect(bus_idx, effect_index) as AudioEffectLowPassFilter
	
	if not lowpass_effect:
		push_error("LowPassFilter effect not found on bus: ", bus_name)
		return
	if active_tween and active_tween.is_valid():
		active_tween.kill()
		
	active_tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	active_tween.tween_property(lowpass_effect, "cutoff_hz", target_hz, DURATION)
