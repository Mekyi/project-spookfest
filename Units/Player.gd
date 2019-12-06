extends KinematicBody2D
signal hitByEnemy()
var attack = preload("res://Units/Attack/Attack.tscn")

export (int) var speed = 300
export (int) var knockbackForce = 45

var canTakeDamage = true
var canMove = true
var playerId
var velocity = Vector2()	
const TIME_PERIOD = 5
var time = 0
var invincibilityTimer = 0
var invincibilityTime = 3
var knockbackTimer = 0
var knockbackTime = 0.3
var lastHitEnemy

func start(pos, id):
	position = pos
	playerId = id
	#Add attack functionality:
	PlayerVariables.CurrentAttack = "basic_attack"
	var a = attack.instance()
	$AnimatedSprite.add_child(a)
	$AnimationPlayer.play("Move")
	
	show()

func timer(delta):
	time += delta
	if (velocity != Vector2(0,0)):
		time = 0
	if time > TIME_PERIOD:
		$AnimationPlayer.play("Idle")
		time = 0
		
func invincibilityTimer(delta):
	invincibilityTimer += delta
	if invincibilityTimer > invincibilityTime:
		canTakeDamage = true
		invincibilityTimer = 0
		
func knockbackTimer(delta):
	knockbackTimer += delta
	if knockbackTimer > knockbackTime:
		canMove = true
		knockbackTimer = 0

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
		if Input.is_action_just_pressed('player1_shoot'):
			$AnimatedSprite.get_child(0).attack(get_location(), get_global_mouse_position())
		if Input.is_action_just_pressed('player1_quickswitch_weapon'):
			if PlayerVariables.CurrentAttack == "basic_attack":
				PlayerVariables.CurrentAttack = "second_attack"
			else:
				PlayerVariables.CurrentAttack = "basic_attack"
			print("SWITCH!")
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
	if !canTakeDamage:
		invincibilityTimer(delta)
	if !canMove:
		knockbackTimer(delta)
		move_and_slide(Vector2(knockbackForce,0).rotated(get_global_transform().origin.angle_to_point(lastHitEnemy))*600*delta)
	if velocity.x != 0:
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0


func _physics_process(delta):
	if canMove:
		get_input()
		velocity = move_and_slide(velocity * delta)
	handleEnemyCollision(delta)

func handleEnemyCollision(delta):
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision is KinematicCollision2D and collision.collider is Node:
			var colliderGroups = collision.collider.get_groups()
			if "Enemy" in colliderGroups:
				if canTakeDamage:
					_on_Player_hitByEnemy()
					lastHitEnemy = collision.position

func _on_Player_hitByEnemy():
	print("oof")
	PlayerVariables.PlayerHealth -= 1
	emit_signal("hitTaken")
	canTakeDamage = false
	canMove = false
		
func get_location():
	return position
