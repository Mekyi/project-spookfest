extends KinematicBody2D

export (int) var speed = 200
var playerPosition
var direction

func start(pos):
	position = pos
	show()

func _process(delta):
	direction  = (get_node("../Player").position - position).normalized()
	move_and_slide(direction * speed * 10 * delta)
