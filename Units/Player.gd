extends KinematicBody2D
signal hitByEnemy()
var attack = preload("res://Units/Attack/Attack.tscn")
export (int) var speed = 300
var health = 6


var canTakeDamage = true
var playerId
var velocity = Vector2()	
const TIME_PERIOD = 5
var time = 0


func start(pos, id):
	position = pos
	playerId = id
	#Add attack functionality:
	PlayerVariables.CurrentAttack = "basic_attack"
	var a = attack.instance()
	$AnimatedSprite.add_child(a)
	$AnimationPlayer.play("Idle")
	
	show()

func timer(delta):
	time += delta
	if (velocity != Vector2(0,0)):
		time = 0
	if time > TIME_PERIOD:
		$AnimationPlayer.play("Idle")
		time = 0

func turning():
	var rot = get_global_mouse_position().angle_to_point(position)
	print("rotation = ", rot)
	if rot < 1.9625 && rot > 1.1775:
			$Sprite_Idle.frame = 8
	if rot < 1.1775 && rot > 0.392:
			$Sprite_Idle.frame = 9
	if rot < 0.392 && rot > -0.3925:
			$Sprite_Idle.frame = 10
	if rot < -0.3925 && rot > -1.1775:
		$AnimationPlayer.stop()
		$Sprite_Idle.frame = 11
	if rot < -1.1775 && rot > -1.9625:
		$AnimationPlayer.stop()
		$Sprite_Idle.frame = 12
	if rot < -1.9625 && rot > -2.7475:
		$AnimationPlayer.stop()
		$Sprite_Idle.frame = 13
	if rot < 2.7475 && rot > 1.9625:
		$AnimationPlayer.stop()
		$Sprite_Idle.frame = 15
	if rot < -2.7475 || rot > 2.7475:
		$AnimationPlayer.stop()
		$Sprite_Idle.frame = 14

func get_input():
	velocity = Vector2()
	if playerId == 1:
		if Input.is_action_pressed('player1_right'):
			velocity.x += 1
		if Input.is_action_pressed('player1_left'):
			velocity.x -= 1
		if Input.is_action_pressed('player1_down'):
			velocity.y += 1
		if Input.is_action_pressed('player1_up'):
			velocity.y -= 1
		if Input.is_action_just_pressed('player1_shoot'):
			$AnimatedSprite.get_child(0).attack(get_location(), get_global_mouse_position())
			if PlayerVariables.CurrentAttack == "basic_attack":
				get_node("WaveSoundPlayer").play()
			else:
				get_node("ShotSoundPlayer").play()
		if Input.is_action_just_pressed('player1_quickswitch_weapon'):
			if PlayerVariables.CurrentAttack == "basic_attack":
				PlayerVariables.CurrentAttack = "second_attack"
			else:
				PlayerVariables.CurrentAttack = "basic_attack"
			print("SWITCH!")
			
	elif playerId == 2:
		velocity = Vector2(Input.get_joy_axis(0, JOY_AXIS_0), Input.get_joy_axis(0, JOY_AXIS_1))
		
	velocity = velocity.normalized() * speed * 10
	
func _process(delta):
	timer(delta)
	turning()
	if velocity.x != 0:
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity * delta)
	


func _on_Player_hitByEnemy():
	if canTakeDamage:
		emit_signal("hitByEnemy")
		canTakeDamage = false
		
func get_location():
	return position
