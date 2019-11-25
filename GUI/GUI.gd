extends Control

var heart = preload("res://GUI/Hearts.tscn")
var heart_count = PlayerVariables.PlayerHealth
var lives = heart_count/2

# Called when the node enters the scene tree for the first time.
func _ready():
    var heart_posx = 0
    var this
    for life in range(lives):
        var new_heart = heart.instance()
        new_heart.position = Vector2(heart_posx, 0)
        $MarginContainer/HBoxContainer/Heartcontainer.add_child(new_heart)
        heart_posx += 40
    yield(get_tree().create_timer(5.0), "timeout")
    PlayerVariables.PlayerHealth -= 1
    hitTaken()
    yield(get_tree().create_timer(5.0), "timeout")
    PlayerVariables.PlayerHealth -= 1
    hitTaken()
    yield(get_tree().create_timer(5.0), "timeout")
    PlayerVariables.PlayerHealth -= 1
    hitTaken()
    yield(get_tree().create_timer(5.0), "timeout")
    PlayerVariables.PlayerHealth -= 1
    hitTaken()

func hitTaken():
	var child = int(round(PlayerVariables.PlayerHealth/2))
	$MarginContainer/HBoxContainer/Heartcontainer.get_child(child).playAnimation()