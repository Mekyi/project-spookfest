extends KinematicBody2D
signal hitByEnemy()

export (int) var speed = 300

var playerId
var canTakeDamage = true
var velocity = Vector2()

func start(pos, id):
    position = pos
    playerId = id
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