extends TileMap
var saved_up
var saved_down
var saved_left
var saved_right
var room_size

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

func _make_door(x, y, up, left, down, right):				
    room_size = Vector2(x,y)
    door_handler(!left, !up, !right, !down, true)
    
func close_doors():
    var x = room_size[0]
    var y = room_size[1]
    if get_cell(0, y/2) > 15:
        saved_left = true
    if get_cell(x-1, y/2) > 15:
        saved_right = true
    if get_cell(x/2, 0) > 15:
        saved_up = true
    if get_cell(x/2, y-1) > 15:
        saved_down = true
    door_handler(saved_left, saved_up, saved_right, saved_down, false)
            
func open_doors():
    door_handler(saved_left, saved_up, saved_right, saved_down, false)

func door_handler(left, up, right, down, first):
    var x = room_size[0]
    var y = room_size[1]
    if left == true:
        set_cell(0, y/2-2, 10)
        set_cell(0, y/2-1, 11)
        set_cell(0, y/2, 11)
        set_cell(0, y/2+1, 10)
        if !first:
            saved_left = false
    elif left == false:
        set_cell(0, y/2-2, 13)
        set_cell(0, y/2-1, 17)
        set_cell(0, y/2, 17)
        set_cell(0, y/2+1, 12)
        if !first:
            saved_left = true
    
    if right == true:
        set_cell(x-1, y/2-2, 0)
        set_cell(x-1, y/2-1, 0)
        set_cell(x-1, y/2, 5)
        set_cell(x-1, y/2+1, 5)
        if !first:
            saved_right = false
    elif right == false:
        set_cell(x-1, y/2-2, 14)
        set_cell(x-1, y/2-1, 17)
        set_cell(x-1, y/2, 16)
        set_cell(x-1, y/2+1, 15)
        if !first:
            saved_right = true
    
    if up == true:
        set_cell(x/2-2, 0, 3)
        set_cell(x/2-1, 0, 2)
        set_cell(x/2, 0, 3)
        set_cell(x/2+1, 0, 2)
        if !first:
            saved_up = false
    elif up == false:
        set_cell(x/2-2, 0, 13)
        set_cell(x/2-1, 0, 17)
        set_cell(x/2, 0, 16)
        set_cell(x/2+1, 0, 14)
        if !first:
            saved_up = true
    
    if down == true:
        set_cell(x/2-2, y-1, 7)
        set_cell(x/2-1, y-1, 8)
        set_cell(x/2, y-1, 7)
        set_cell(x/2+1, y-1, 8)
        if !first:
            saved_down = false
    elif down == false:
        set_cell(x/2-2, y-1, 12)
        set_cell(x/2-1, y-1, 16)
        set_cell(x/2, y-1, 17)
        set_cell(x/2+1, y-1, 15)
        if !first:
            saved_down = true