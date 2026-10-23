class_name AreaHoldTrigger
extends Area2D


signal duration_reached(target_area: Area2D)

@export var hold_time: float = 2.0
@export var target_class_name: String = ""

var _timer: Timer
var _tracked_area: Area2D = null


func _ready() -> void:
	_timer = Timer.new()
	_timer.one_shot = true
	_timer.wait_time = hold_time
	_timer.timeout.connect(_on_timer_timeout)
	add_child(_timer)
	
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


func _on_area_entered(area: Area2D) -> void:
	if _tracked_area != null:
		return
		
	# check if the entering area matches class (optional)
	if target_class_name != "" and not area.is_class(target_class_name) and area.get_script() == null:
		return
	if target_class_name != "" and area.get_script() != null:
		if not (area.get_script() as Script).get_instance_base_type() == target_class_name and target_class_name not in str(area.get_script().get_global_name()):
			return

	_tracked_area = area
	_timer.start(hold_time)


func _on_area_exited(area: Area2D) -> void:
	if area == _tracked_area:
		_timer.stop()
		_tracked_area = null


func _on_timer_timeout() -> void:
	if _tracked_area != null:
		duration_reached.emit(_tracked_area)
		_tracked_area = null 
