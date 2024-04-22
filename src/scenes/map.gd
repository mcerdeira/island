extends TileMap
var terrain = []
var terrain_done = []

func _ready():
	var rand_x = randi() % 36 + 1
	var rand_y = randi() %  20 + 1
	var initial_cell = Vector2(rand_x, rand_y)
	
	# Initialice array
	for x in range(0, 36 + 1):
		terrain.append([])
		terrain_done.append([])
		for y in range(0, 20 + 1):
			terrain[x].append(10)
			terrain_done[x].append(false)
				
	# Pick starting point
	terrain[rand_x][rand_y] = randi() % terrain[rand_x][rand_y] 
	var lowest = ""
	while(lowest != null):
		lowest = get_lowest_entrophy()
		terrain[lowest.x][lowest.y] = randi() % terrain[lowest.x][lowest.y]
		update_entrophy()
	
	# Draw the stuff
	for x in range(0, 36 + 1):
		for y in range(0, 20 + 1):
			set_cell(0, Vector2i(x, y), terrain[x][y], Vector2i(0, 0))

func update_entrophy():
	for x in range(0, 36 + 1):
		for y in range(0, 20 + 1):
			var neighboardU = neighboard(x, y, "U")
			var neighboardD = neighboard(x, y, "D")
			var neighboardL = neighboard(x, y, "L")
			var neighboardR = neighboard(x, y, "R")
			
			terrain[x][y]
			
func neighboard(x, y, dir):
	if dir == "U":
		y = y -1
	if dir == "D":
		y = y + 1
	if dir == "L":
		x = x - 1
	if dir == "R":
		x = x + 1
		
	if y == -1 or x == -1 or y > 20 or x > 36:
		return null
	else:
		return terrain[x][y]

func get_lowest_entrophy():
	var curr = Vector2(0, 0)
	var curr_val = null
	for x in range(0, 36 + 1):
		for y in range(0, 20 + 1):
			if curr_val == null or terrain[x][y] <= curr_val and terrain_done[x][y] == false:
				curr = Vector2(x, y)
				curr_val = terrain[x][y]
	
	return curr
