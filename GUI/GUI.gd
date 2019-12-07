extends Control
signal hitTaken

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
        
func _process(delta):
    if heart_count > PlayerVariables.PlayerHealth:
        heart_count = PlayerVariables.PlayerHealth
        hitTaken()


func hitTaken():
    var child = int(round(PlayerVariables.PlayerHealth/2))
    print("wololoo")
    $MarginContainer/HBoxContainer/Heartcontainer.get_child(child).playAnimation()