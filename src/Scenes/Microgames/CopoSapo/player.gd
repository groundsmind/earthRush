extends AreaHoldTrigger

@onready var cup_shuffler: Node2D = $"../CupShuffler"
@onready var follow_foot: FollowFoot = $FollowFoot

func _on_cup_shuffler_finished_shuffling() -> void:
	follow_foot.track_x = true
	follow_foot.track_y = true
	monitoring = true

func _on_duration_reached(target_area: Area2D) -> void:
	print("Hi cup!")
	target_area.get_parent().select_cup(target_area)
