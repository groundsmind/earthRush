extends Node2D

@onready var cups: Array = [$Cup1, $Cup2, $Cup3]
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var current_slots: Array = []
var default_positions: Array = []

var shuffle_count: int = 10      # Total pairs swapped per round
var shuffle_speed: float = .5   # Time taken per swap animation
var is_shuffling: bool = false

signal finished_shuffling
signal correct_cup_picked
signal wrong_cup_picked

func _ready() -> void:
	current_slots = cups.duplicate()
	for cup in cups:
		default_positions.append(cup.global_position)
	animation_player.play("cup_descend")
	animation_player.animation_finished.connect(start_game)

func start_game(_a) -> void:
	await get_tree().create_timer(0.5).timeout
	shuffle_round(shuffle_count)

func shuffle_round(remaining_swaps: int) -> void:
	if remaining_swaps <= 0:
		is_shuffling = false
		finished_shuffling.emit()
		return
		
	is_shuffling = true
	var slot_a = randi() % 3
	var slot_b = randi() % 3
	while slot_b == slot_a:
		slot_b = randi() % 3
	var cup_a: Node2D = current_slots[slot_a]
	var cup_b: Node2D = current_slots[slot_b]
	var pos_a = default_positions[slot_a]
	var pos_b = default_positions[slot_b]
	
	var tween = create_tween().set_parallel(true)
	
	var mid_y_offset = 80.0 
	
	tween.tween_property(cup_a, "global_position:x", pos_b.x, shuffle_speed)
	tween.tween_property(cup_a, "global_position:y", pos_a.y + mid_y_offset, shuffle_speed / 2.0).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(cup_a, "global_position:y", pos_b.y, shuffle_speed / 2.0).set_delay(shuffle_speed / 2.0).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	
	tween.tween_property(cup_b, "global_position:x", pos_a.x, shuffle_speed)
	tween.tween_property(cup_b, "global_position:y", pos_b.y - mid_y_offset, shuffle_speed / 2.0).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(cup_b, "global_position:y", pos_a.y, shuffle_speed / 2.0).set_delay(shuffle_speed / 2.0).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	
	current_slots[slot_a] = cup_b
	current_slots[slot_b] = cup_a
	
	await tween.finished
	shuffle_round(remaining_swaps - 1)

func select_cup(chosen_cup: Node2D) -> void:
	if is_shuffling:
		return
	var cup_sprite: Sprite2D = chosen_cup.find_child('Cup')
	var _raise_tween = create_tween().tween_property(cup_sprite, "position:y", cup_sprite.position.y-200, 0.5)
	_raise_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
	await _raise_tween.finished
	if chosen_cup == cups[1]:
		correct_cup_picked.emit()
	else:
		wrong_cup_picked.emit()
