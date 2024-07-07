@tool
extends Node2D

@onready var node_collection = $"node collection"
@onready var position_icon = $"position icon"

@export var debug_mode:= false:
	set(mode):
		debug_mode = mode
		if is_node_ready():
			for node in node_collection.get_children():
				node.debug_mode = debug_mode
				node.queue_redraw()
			

func _ready():
	for node in node_collection.get_children():
		if !node.is_connected("redraw",_redraw_node_lines):
			node.redraw.connect(_redraw_node_lines)
			node.texture.mouse_entered.connect(node_mouse_entered.bind(node))
			node.texture.mouse_exited.connect(node_mouse_exited.bind(node))


func _redraw_node_lines():
	for node in node_collection.get_children():
		node.queue_redraw()
	pass

func _on_node_collection_child_order_changed():
	for node in node_collection.get_children():
		if !node.redraw.is_connected(_redraw_node_lines):
			node.redraw.connect(_redraw_node_lines)
			node.debug_mode = debug_mode


func node_mouse_entered(node:Exploration_Node):
	if !node.is_locked:
		position_icon.position = node.global_position
	pass


func node_mouse_exited(node:Exploration_Node):
	#position_icon.position = node.global_position
	pass
