@icon("res://addons/at-icons/node2d/person_body.svg")
extends Node2D
class_name BodyMovementComponent

var left_foot: Vector2
var right_foot: Vector2
var feet_midpoint: Vector2

func _process(_delta: float) -> void:
	left_foot = FootPosition.left
	right_foot = FootPosition.right
	feet_midpoint = FootPosition.midpoint
