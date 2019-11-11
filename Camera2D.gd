extends Camera2D


func start(pos):
	position = pos
	
	var room_x = get_parent().room_size[0] * get_parent().tile_size
	var room_y = get_parent().room_size[1] * get_parent().tile_size
	var zoomx = room_x / get_viewport().get_visible_rect().size[0]
	var zoomy = room_y / get_viewport().get_visible_rect().size[1]
	set_zoom(Vector2(zoomx, zoomy))
	
func _process(delta):
	var zoomx = (get_parent().room_size[0] * get_parent().tile_size) / get_viewport().get_visible_rect().size[0]
	var zoomy = (get_parent().room_size[1] * get_parent().tile_size) / get_viewport().get_visible_rect().size[1]
	set_zoom(Vector2(zoomx, zoomy))
	pass