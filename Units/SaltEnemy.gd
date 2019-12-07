extends KinematicBody2D

export (int) var speed = 200
export (float) var health = 50
var direction

func start(pos):
    var rand_mod = randi()%(10)+0
    position = pos
    print(rand_mod)
    if rand_mod == 9: 
        mod(100, 1000, Color8(222,28,28))
        
    show()

func _process(delta):
	direction  = (get_node("../../../../Startposition/Player").get_global_position() - get_global_position()).normalized()
	if Input.is_action_pressed("ui_accept"):
		print(get_node("../Player").position)
		print(position)
		print(direction)
		
		
	move_and_slide(direction * speed * 10 * delta)
		
		
func take_hit(dmg):
    health -= dmg
    if health <= 0:
        self.queue_free()
        
func mod(h, s, color):
    health = h
    speed = s
    self.get_node("AnimatedSprite").modulate = color
    
    
