extends Node2D

var map_maker = load ("res://map_maker.gd").new()
var room_map = []
var Room = preload("res://room.tscn")
var tile_size = 16
var start_pos = Vector2(0,0)
var Player = preload("res://Player.tscn")

func _ready():
    randomize()
    map_maker._ready()
    room_map = map_maker.room_map
    for n in range(map_maker.roomWidth):
        print(room_map[n])
    make_rooms()
    var player1 = Player.instance()
    player1.start(start_pos)
    $Startposition.add_child(player1)
    
func make_rooms():
    var size
    var s = Room.instance()
    size = s.get_size()					# checks room size to use
    
    for x in range(map_maker.roomWidth):
        for y in range(map_maker.roomHeight):
            if room_map[x][y] == 2:
                var left = false
                var up = false
                if y-1 >= 0 and room_map[x][y-1] == 2:
                    left = true
                if x-1 >= 0 and room_map[x-1][y] == 2:
                    up = true
                var r = Room.instance()
                r.make_room(Vector2(y*tile_size*size[0], x*tile_size*size[1]), up, left, size[0], size[1])
                $Rooms.add_child(r)