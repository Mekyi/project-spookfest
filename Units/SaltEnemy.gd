extends KinematicBody2D

export var speed = 200
var playerPosition

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func _fixed_process(delta):
    playerPosition = get_node("Player").get_translation()
    move((playerPosition - get_translation()).normalized() * delta * speed)
