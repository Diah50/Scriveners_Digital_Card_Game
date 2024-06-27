extends Control
@onready var grid = $GridContainer
var grid_size = Vector2i(5,5)



func _ready():
	var cell = get_grid_cell(Vector2i(4,4))
	cell.modulate = Color.DEEP_PINK

	pass # Replace with function body.

func get_grid_cell(pos:Vector2i):
	#if pos >= grid_size or pos < Vector2i.ZERO:
		#push_error("Out of bounds cordinates for grid")
		#return null
	var grid_box = []
	
	for y in grid.get_children().size()/grid_size.y:
		var row = []
		for x in grid.get_children().size()/grid_size.x:
			if y == 0:
				row.append(grid.get_child(x+y))
			elif x == 0:
				row.append(grid.get_child((x+y)+y))
			else:
				row.append(grid.get_child(x*y))
			print(Vector2(x,y))
		grid_box.append(row)


	
	print(grid_box)
	return grid_box[pos.y][pos.x]

