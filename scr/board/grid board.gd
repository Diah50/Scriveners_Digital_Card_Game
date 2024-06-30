extends Control
@onready var grid = $GridContainer
var grid_size = Vector2i(5,5)
var board_grid = [] 

signal mouse_entered_cell(cell)
signal mouse_exited_cell(cell)
func _ready():
	_connect_signals()
	board_grid = _create_grid()
	#var cell = get_cell_by_pos(Vector2i(3,4))
	#cell.modulate = Color.DEEP_PINK


func get_cell_by_pos(pos:Vector2i):
	if pos >= grid_size or pos < Vector2i.ZERO:
		push_error("Out of bounds cordinates for grid")
		return null
	return board_grid[pos.x][pos.y]


# Note (0,0) starts in the upper left corner
func _create_grid():
	var grid_box = []
	for y in grid.get_children().size()/grid_size.y:
		var row = []
		for x in grid.get_children().size()/grid_size.x:
			row.append(grid.get_child((y*grid_size.y)+x))
		grid_box.append(row)
	return grid_box

func _connect_signals():
	for child in grid.get_children():
		print(child)
		child.get_node("TextureButton").button_down.connect(_on_button_down.bind(child))
		child.get_node("TextureButton").button_up.connect(_on_button_up.bind(child))
		child.get_node("TextureButton").pressed.connect(_on_button_pressed.bind(child))
		child.mouse_entered.connect(_on_mouse_entered_cell.bind(child))
		child.mouse_exited.connect(_on_mouse_exited_cell.bind(child))

func _on_mouse_entered_cell(cell):
	cell.modulate = Color.DEEP_PINK
	print("All in")
	pass

func _on_mouse_exited_cell(cell):
	cell.modulate = Color.WHITE
	print("All out")
	pass

func _on_button_down(cell):
	print("Cell clicked down")
	pass
func _on_button_up(cell):
	print("Cell clicked up")
	pass
func _on_button_pressed(cell):
	print("Cell clicked")
	pass
	
	
func _on_margin_container_mouse_entered():
	print("Touchy")
	pass # Replace with function body.
