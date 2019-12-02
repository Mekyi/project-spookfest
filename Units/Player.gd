extends KinematicBody2D
signal hitByEnemy()
var attack = preload("res://Units/Attack/Attack.tscn")

export (int) var speed = 300
var health = 6

var playerId
var canTakeDamage = true
var velocity = Vector2()

func start(pos, id):
    position = pos 
    playerId = id
    #Add attack functionality:
    PlayerVariables.CurrentAttack = "basic_attack"
    var a = attack.instance()
    $AnimatedSprite.add_child(a)
    show()

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