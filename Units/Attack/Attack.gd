extends Node

#Different attacks
var basic_attack = preload("res://Units/Attack/Attacks/basicAttack.tscn")
var second_attack = preload("res://Units/Attack/Attacks/secondAttack.tscn")
var direction

func _ready():
	pass # Replace with function body.
	
func attack(pos, mpos):
	var attack = get(str2var(PlayerVariables.CurrentAttack)).instance()
	$Attacks.add_child(attack)
	attack.position = pos
	direction  =  (mpos - pos).normalized()
	attack.attack(direction)