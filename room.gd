extends RigidBody2D
var Doors = load("res://room_layout.gd").new()

func make_room(_pos, up, left, down, right, x, y):			#creates room at the right place and then puts doors
	position = _pos
	$room_layout._make_door(x, y, up, left, down, right)

func get_size():
	var size = $room_layout._get_size()
	return size
	
func close_doors():
	$room_layout.close_doors()
func open_doors():
	$room_layout.open_doors()