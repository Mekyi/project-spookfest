extends Control

export (NodePath) var continue_path
export (NodePath) var restart_path
export (NodePath) var exit_path
onready var button_continue = get_node(continue_path)
onready var button_restart = get_node(restart_path)
onready var button_exit = get_node(exit_path)
var game_over = false

func _ready():
    button_continue.connect("button_down", self, "set_pause")
    button_restart.connect("button_up", self, "restart_game")
    button_exit.connect("button_down", self, "exit_game")
    
func _input(event):
    if event.is_action_pressed("pause") && !game_over:
        set_pause()
        
func set_pause():
    var new_pause_state = not get_tree().paused
    get_tree().paused = not get_tree().paused
    visible = new_pause_state
    
func exit_game():
    get_tree().quit()
    
func restart_game():
    PlayerVariables.PlayerHealth = 6
    get_tree().reload_current_scene()
    set_pause()
    
func game_over():
    game_over = true