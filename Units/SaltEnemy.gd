extends KinematicBody2D

export (int) var speed = 200
var direction

func start(pos):
	position = pos
	show()

func _process(delta):
	direction  = (get_node("../../../Startposition/Player").get_global_position() - get_global_position()).normalized()
	if Input.is_action_pressed("ui_accept"):
		print(get_node("../Player").position)
		print(position)
		print(direction)
		
		
	move_and_slide(direction * speed * 10 * delta)
