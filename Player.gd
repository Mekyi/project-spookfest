extends KinematicBody2D

export (int) var speed = 300

var velocity = Vector2()
var camera = load("res://Camera2D.gd")


func start(pos):
	position = pos
	show()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
func _process(delta):
	if velocity.x != 0:
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment
		$AnimatedSprite.flip_h = velocity.x < 0

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
