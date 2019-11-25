extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("FullHeart")

func playAnimation():
	if PlayerVariables.PlayerHealth % 2 != 0:
		$AnimationPlayer.play("HalfHeart")
	else:
		$AnimationPlayer.play("NoHeart")
