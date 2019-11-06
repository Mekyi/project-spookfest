extends Camera2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func start(pos):
	position = pos
	var zoomx = (get_parent().room_size[0] * get_parent().tile_size) / get_viewport().get_visible_rect().size[0]
	var zoomy = (get_parent().room_size[1] * get_parent().tile_size) / get_viewport().get_visible_rect().size[1]
	set_zoom(Vector2(zoomx, zoomy))
	
# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var zoomx = (get_parent().room_size[0] * get_parent().tile_size) / get_viewport().get_visible_rect().size[0]
	var zoomy = (get_parent().room_size[1] * get_parent().tile_size) / get_viewport().get_visible_rect().size[1]
	set_zoom(Vector2(zoomx, zoomy))

func move_camera(pos):
	#print(get_camera_position())
	position = pos
