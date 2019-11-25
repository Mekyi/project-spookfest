extends Node2D

signal camera_change
var map_maker = load ("res://map_maker.gd").new()
var room_map = []
var Room = preload("res://room.tscn")
var tile_size = 16
var start_pos = Vector2(0,0)
var Player = preload("res://Units/Player.tscn")
var Enemy = preload("res://Units/SaltEnemy.tscn")

var room_size
var t = 0
var old_pos
var current_room

func _ready():
    randomize()
    map_maker._ready()
    room_map = map_maker.room_map
    make_rooms()
    var start_room = randi()%($Rooms.get_child_count())+0
    var pos = $Rooms.get_child(start_room).position
    start_pos = pos
    var player1 = Player.instance()
    var enemy = Enemy.instance()
    $Camera2D.start(pos)
    var startRoomCenter = Vector2(start_pos[0]+room_size[0]*tile_size/2, start_pos[1] + room_size[1]*tile_size/2)
    player1.start(startRoomCenter, 1)
    enemy.start(startRoomCenter)
    $Startposition.add_child(player1)
    $Startposition.add_child(enemy)
    old_pos = start_pos
    
func make_rooms():
    var size
    var s = Room.instance()
    room_size = s.get_size()					# checks room size to use
    
    for x in range(map_maker.roomWidth):
        for y in range(map_maker.roomHeight):
            if room_map[x][y] == 2:
                var left = false
                var up = false
                var down = false
                var right = false
                if y-1 >= 0 and room_map[x][y-1] == 2:
                    left = true
                if y+1 <= map_maker.roomHeight-1 and room_map[x][y+1] == 2:
                    right = true
                if x-1 >= 0 and room_map[x-1][y] == 2:
                    up = true
                if x+1 <= map_maker.roomWidth-1 and room_map[x+1][y] == 2:
                    down = true 
                var r = Room.instance()
                r.make_room(Vector2(y*tile_size*room_size[0], x*tile_size*room_size[1]), up, left, down, right, room_size[0], room_size[1])
                $Rooms.add_child(r)
                
func _process(delta):
    var new_pos
    var direction
    if $Startposition.get_child(0).position[0] < old_pos[0]:			# going left
        new_pos = Vector2(old_pos[0]-tile_size*room_size[0], old_pos[1])
        move_camera(new_pos, Vector2(-32, 0))
    if $Startposition.get_child(0).position[0] > old_pos[0]+tile_size*room_size[0]:		#going right
        new_pos = Vector2(old_pos[0]+tile_size*room_size[0], old_pos[1])
        move_camera(new_pos, Vector2(32, 0))
    if $Startposition.get_child(0).position[1] < old_pos[1]:		#going up
        new_pos = Vector2(old_pos[0], old_pos[1]-tile_size*room_size[1])
        move_camera(new_pos, Vector2(0, -32))
    if $Startposition.get_child(0).position[1] > old_pos[1]+tile_size*room_size[1]:		#going down
        new_pos = Vector2(old_pos[0], old_pos[1]+tile_size*room_size[1])
        move_camera(new_pos, Vector2(0, 32))
        
func move_camera(new_pos, direction):
    var player_pos
    var room_pos
    get_tree().paused = true
    $Camera2D.set_enable_follow_smoothing(true)
    $Camera2D.position = new_pos
    $Startposition.get_child(0).position += direction
    player_pos = $Startposition.get_child(0).position
    for room in $Rooms.get_child_count():
        room_pos = $Rooms.get_child(room).position
        if room_pos[0] < player_pos[0] and player_pos[0] < room_pos[0]+(room_size[0]*tile_size) and room_pos[1] < player_pos[1] and player_pos[1] < room_pos[1]+(room_size[1]*tile_size):
            current_room = room
            break
    yield(get_tree().create_timer(1.0), "timeout")
    $Rooms.get_child(current_room).close_doors()
    get_tree().paused = false
    old_pos = new_pos
    yield(get_tree().create_timer(5.0), "timeout")
    $Rooms.get_child(current_room).close_doors()
    
