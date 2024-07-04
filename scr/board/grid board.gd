extends Control
@onready var grid = $GridContainer
var grid_size = Vector2i(5,5)
var board_grid = [] 

signal mouse_entered_cell(cell)
signal mouse_exited_cell(cell)

func _ready():
	print( Vector2(0,1)> Vector2(1,0))
	board_grid = _create_grid()
	#var cell = get_cell_by_pos(Vector2i(3,4))
	#cell.modulate = Color.DEEP_PINK
	_connect_signals()
	#for cell in grid.get_children():
		#cell.button.toggled.connect(untoggle_other_cells.bind(cell))


func get_cell_by_pos(pos:Vector2i):
	if pos.x >= grid_size.x or pos.y >= grid_size.y or pos.x < 0 or pos.y < 0:
		push_error("Cordinates: "+str(pos)+" is out of bounds of grid")
		return null
	return board_grid[pos.y][pos.x]

func _connect_signals():
	for cell in grid.get_children():
		
		cell.button.mouse_entered.connect(_on_mouse_entered_cell.bind(cell))
		cell.button.mouse_exited.connect(_on_mouse_exited_cell.bind(cell))
		cell.button.button_down.connect(_on_button_down.bind(cell))
		cell.button.button_up.connect(_on_button_up.bind(cell))
		cell.button.pressed.connect(_on_button_pressed.bind(cell))
		
# Note (0,0) starts in the upper left corner
func _create_grid():
	var grid_box = []
	for y in grid.get_children().size()/grid_size.y:
		var row = []
		for x in grid.get_children().size()/grid_size.x:
			var cell = grid.get_child((y*grid_size.y)+x)
			cell.cell_pos = Vector2i(x,y)
			row.append(cell)
		grid_box.append(row)
	return grid_box

func untoggle_other_cells(toggled,toggled_cell):

	for cell in grid.get_children():

		if cell != toggled_cell:
			print(toggled_cell, "- AHHHHHHHHHH -", cell)
			cell.button.button_pressed = false

func _on_mouse_entered_cell(cell):
	if cell.token_container.get_children().size() > 0:
		Events.update_card_display.emit(cell.token_container.get_child(0).token_data)
	cell.material.set("shader_parameter/is_active",true)
	print("All in")
	pass

func _on_mouse_exited_cell(cell):
	if cell.token_container.get_children().size() > 0:
		Events.hide_card_display.emit()
	cell.material.set("shader_parameter/is_active",false)
	print("All out")
	pass

func _on_button_down(cell):
	print("Cell clicked down")
	if cell.token_container.get_child_count() > 0:
		var token_moove_speed = cell.token_container.get_child(0).token_data.moveSpeed
		highlight_cells(determine_moveable_spaces(cell.cell_pos,token_moove_speed).map(func (pos): return get_cell_by_pos(pos) ))
		cell.arrow.is_arrow_disabled = false

func _on_button_up(cell):
	print("Cell clicked up")
	if cell.token_container.get_child_count() > 0:
		if  cell.arrow.get_colliing_cell() and determine_moveable_spaces(cell.cell_pos).has(cell.arrow.get_colliing_cell().cell_pos):
			cell.token_container.get_child(0).reparent(cell.arrow.get_colliing_cell().token_container)
			cell.arrow.is_arrow_disabled = true
			remove_highlighted_cells()
		else:
			cell.arrow.is_arrow_disabled = true
			remove_highlighted_cells()

func _on_button_pressed(cell):
	print("Cell clicked")
	pass

func highlight_cells(cells:Array):
	for cell in cells:
		if cell:
			cell.modulate = Color.GREEN

func remove_highlighted_cells():
	for cell in grid.get_children():
		cell.modulate = Color.WHITE

func determine_moveable_spaces(pos:Vector2i,move_speed:int = 1):
	var directions = [Vector2i.UP,Vector2i.DOWN,Vector2i.LEFT,Vector2i.RIGHT]
	var moveable_spaces = []
	for dis in range(1,move_speed+1):
		print(dis)
		for dir in directions:
			moveable_spaces.append((dir*dis)+pos)
		
	return moveable_spaces
