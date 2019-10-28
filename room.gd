extends RigidBody2D
var Doors = load("res://room_layout.gd").new()

func make_room(_pos, up, left, x, y):			#creates room at the right place and then puts doors
	position = _pos
	$room_layout._make_door(x, y, up, left)

func get_size():
	var size = $room_layout._get_size()
	return size