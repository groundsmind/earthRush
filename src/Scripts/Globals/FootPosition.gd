extends Node

var left: Vector2 = Vector2.ZERO
var right: Vector2 = Vector2.ZERO
var midpoint: Vector2 = Vector2.ZERO

var unporcessed_position: Dictionary = {
	"left": Vector2(0,0),
	"right": Vector2(0,0),
}

var _oldleft: Vector2 = Vector2.ZERO
var _oldright: Vector2 = Vector2.ZERO
var offset_threshold: float = 10.0

func _process(delta: float) -> void:
	if Server.data is Dictionary and Server.data['pos']['left'][0] != null:
		var pos = Server.data['pos']
		unporcessed_position.set('left', Vector2(pos['left'][0], pos['left'][1]))
		unporcessed_position.set('right', Vector2(pos['right'][0], pos['right'][1]))
		
	if unporcessed_position["left"].x != null:
		var des_left_pos = Vector2(unporcessed_position.get("left").x, (unporcessed_position.get("left").y))
		var des_right_pos = Vector2(unporcessed_position.get("right").x, (unporcessed_position.get("right").y))
		
		# move threshold #
		if abs(des_left_pos.x - _oldleft.x) >= offset_threshold or abs(des_left_pos.y - _oldleft.y) >= offset_threshold:
			left = lerp(left, des_left_pos, delta*15)
		if abs(des_right_pos.x - _oldright.x) >= offset_threshold or abs(des_right_pos.y - _oldright.y) >= offset_threshold:
			right = lerp(right, des_right_pos, delta*15)
			
		midpoint = (left+right)/2
