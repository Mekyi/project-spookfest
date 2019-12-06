extends RigidBody2D

export(int) var speed
export(float) var cooldown
export(float) var travelTime
export(float) var spread

var direction

func attack(dir):
	apply_impulse(dir, (dir * speed))
	rotation = get_global_mouse_position().angle_to_point(position) + PI*0.5
	print(rotation)
	yield(get_tree().create_timer(travelTime), "timeout")
	self.free()