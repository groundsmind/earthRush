extends Node2D

@onready var droplets: GPUParticles2D = $sprite/droplets
var full_flowers: int = 0
signal flower_done

func _on_area_2d_area_entered(flower: Area2D) -> void:
	if flower.timer.paused:
		flower.timer.paused = false
	else:
		flower.timer.start()
	
	if not flower.finished.is_connected(_on_flower_finished.bind(flower)):
		flower.finished.connect(_on_flower_finished.bind(flower))

func _on_area_2d_area_exited(flower: Area2D) -> void:
	flower.timer.paused = true

func _on_flower_finished(flower) -> void:
	flower_done.emit()
	
	if flower.finished.is_connected(_on_flower_finished.bind(flower)):
		flower.finished.disconnect(_on_flower_finished.bind(flower))
