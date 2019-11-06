extends Node2D

var roomHeight = 4
var roomWidth = 5
var cull = 5
var room_map = []

func _ready():
	var done = 0
	randomize()
	while done == 0:
		done = _createRooms()

func _createRooms():							# Create array full of rooms
	var mapMatrix = []
	for x in range(roomWidth):
		mapMatrix.append([])
		for y in range(roomHeight):
			mapMatrix[x].append(1)
	return _cullRooms(mapMatrix)
	
	
func _cullRooms(mapMatrix):						# cull rooms randomly out of array
	var x
	var y
	var vacant = true

	for n in range(cull):
		vacant = false
		while vacant == false:
			x = randi()%(roomWidth)+0
			y = randi()%(roomHeight)+0
			if mapMatrix[x][y] == 1:
				mapMatrix[x][y] = 0
				vacant = true
		
	return _checkDefects(mapMatrix)
	
func _checkDefects(mapMatrix):					#check if there is no way of accessing some rooms
	var y
	var x = 0
	var id = 2
	var coordinateList = []
	
	for x in range(roomWidth):					# starts from the first room it finds and creates a list of surrounding rooms converting them to same type
		while mapMatrix[x].find(1) > -1:
			y = mapMatrix[x].find(1)
			_pathChecker(mapMatrix, coordinateList, x, y, id)
			while !coordinateList.empty():
				_pathChecker(mapMatrix, coordinateList, coordinateList[0][0], coordinateList[0][1], id)
				coordinateList.pop_front()
			id+=1
	
	if id > 3:
		return 0
	else:
		room_map = mapMatrix
		return 1
		
func _pathChecker(mapMatrix, list, x, y, id):			# checks the surrounding rooms if they are accessible and adds them to the list
	var up = x-1
	var down = x+1
	mapMatrix[x][y] = id
	var left = y-1
	var right = y+1
	if up > -1 and mapMatrix[up][y] == 1:
		mapMatrix[up][y] = id
		list.push_back([up, y])
	if down < roomWidth and mapMatrix[down][y] == 1:
		mapMatrix[down][y] = id
		list.push_back([down, y])
	if left > -1 and mapMatrix[x][left] == 1:
		mapMatrix[x][left] = id
		list.push_back([x, left])
	if right < roomHeight and mapMatrix[x][right] == 1:
		mapMatrix[x][right] = id
		list.push_back([x, right])