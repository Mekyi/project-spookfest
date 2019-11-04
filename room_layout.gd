extends TileMap

func _make_door(x, y, up, left):				# no need to check all directions. We can make double doors
    
    if left == true:							# creates doors to left
        set_cell(0, y/2-1, 4, false, false, true)
        set_cell(0, y/2, 4, false, true, true)
        set_cell(-1, y/2-1, 4, true, false, true)
        set_cell(-1, y/2, 4, true, true, true)
    if up == true:								# creates doors to up
        set_cell(x/2-1, 0, 4)
        set_cell(x/2, 0, 4, true)
        set_cell(x/2-1, -1, 4, false, true)
        set_cell(x/2, -1, 4, true, true)

func _get_size():
    var x = 0
    var y = 0
    var size
    
    while get_cell(x, 0) != -1:
        x += 1
    while get_cell(0, y) != -1:
        y += 1
    
    size = Vector2(x,y)
    return size