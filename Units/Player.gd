extends KinematicBody2D

export (int) var speed = 300

var playerId
var velocity = Vector2()	
const TIME_PERIOD = 5
var time = 0

func start(pos, id):
	position = pos
	playerId = id
	$AnimationPlayer.play("Move")
	
	show()

func timer(delta):
	time += delta
	if (velocity != Vector2(0,0)):
		time = 0
	if time > TIME_PERIOD:
		$AnimationPlayer.play("Idle")
		time = 0

func get_input():
	velocity = Vector2()
	if playerId == 1:
		if Input.is_action_pressed('player1_right'):
			$AnimationPlayer.stop();
			velocity.x += 1
			$Sprite_Idle.frame = 10
		if Input.is_action_pressed('player1_left'):
			$AnimationPlayer.stop();
			velocity.x -= 1
			$Sprite_Idle.frame = 14
		if Input.is_action_pressed('player1_down'):
			$AnimationPlayer.stop();
			velocity.y += 1
			$Sprite_Idle.frame = 8
		if Input.is_action_pressed('player1_up'):
			$AnimationPlayer.stop();
			velocity.y -= 1
			$Sprite_Idle.frame = 12
		if velocity == Vector2(1,-1): #Up Right
			$AnimationPlayer.stop();
			$Sprite_Idle.frame = 11
		if velocity == Vector2(-1,-1): #Up Left
			$AnimationPlayer.stop();
			$Sprite_Idle.frame = 13
		if velocity == Vector2(1,1): #Down Right
			$AnimationPlayer.stop();
			$Sprite_Idle.frame = 9
		if velocity == Vector2(-1,1): #Down Left
			$AnimationPlayer.stop();
			$Sprite_Idle.frame = 15
			
	elif playerId == 2:
		velocity = Vector2(Input.get_joy_axis(0, JOY_AXIS_0), Input.get_joy_axis(0, JOY_AXIS_1))
		
	velocity = velocity.normalized() * speed * 10
	
func _process(delta):
	timer(delta)
	if velocity.x != 0:
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity * delta)
