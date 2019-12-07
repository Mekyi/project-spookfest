extends RigidBody2D

export(int) var speed
export(float) var cooldown
export(float) var travelTime
export(float) var spread
export(float) var damage

var direction

func attack(dir):
	apply_impulse(dir, (dir * speed))
	rotation = get_global_mouse_position().angle_to_point(position) + PI*0.5
	yield(get_tree().create_timer(travelTime), "timeout")
	destroy_object()
		
func _on_hit(body):
	print(body.name)
	if (body.name != "room_layout"):
		body.take_hit(damage)
		
	destroy_object()
	
func destroy_object():
	self.queue_free()
	