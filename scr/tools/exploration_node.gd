@tool
extends Marker2D
class_name Exploration_Node
signal redraw

@onready var texture = $texture
@export var node_type:Exploration_Node_Resource.NODE_TYPES = Exploration_Node_Resource.NODE_TYPES.NONE:
	set(type):
		node_type = type
		set_node_type_color()
@export var connected_nodes_to:Array[Exploration_Node] = []

@export var debug_mode:= false
@export var is_locked:= false

@export var event:Exploration_Node_Resource


var last_pos:Vector2
var last_connected_nodes:Array[Exploration_Node] = []

func _ready():
	set_node_type_color()
	pass

func _process(delta):
	if position != last_pos or connected_nodes_to != last_connected_nodes:
		last_pos = position
		last_connected_nodes = connected_nodes_to
		redraw.emit()


func _draw():
	if debug_mode:
		for node in connected_nodes_to:
			draw_line(Vector2.ZERO,to_local(node.global_position),Color.WHITE,5)
		#print("draw")

# THis will be replaced with images for nodes
func set_node_type_color():
	match node_type:
		Exploration_Node_Resource.NODE_TYPES.COMBAT:
			modulate = Color.RED
		Exploration_Node_Resource.NODE_TYPES.STORY:
			modulate = Color.SEA_GREEN
		Exploration_Node_Resource.NODE_TYPES.BOSS:
			modulate = Color.DARK_RED
		Exploration_Node_Resource.NODE_TYPES.EVENT:
			modulate = Color.BLUE
		Exploration_Node_Resource.NODE_TYPES.DUNGEON:
			modulate = Color.PURPLE
		Exploration_Node_Resource.NODE_TYPES.NONE:
			modulate = Color.WHITE

func trigger_event():
	match node_type:
		Exploration_Node_Resource.NODE_TYPES.COMBAT:
			print("A combat was triggered")
		Exploration_Node_Resource.NODE_TYPES.STORY:
			print("A conversation was triggered")
		Exploration_Node_Resource.NODE_TYPES.BOSS:
			print("A boss fight was triggered")
		Exploration_Node_Resource.NODE_TYPES.EVENT:
			print("An event was triggered")
		Exploration_Node_Resource.NODE_TYPES.DUNGEON:
			print("A Dungeon was triggered")
		Exploration_Node_Resource.NODE_TYPES.NONE:
			print("THis is blank node for testing")
	pass

func _on_texture_pressed():
	trigger_event()
	pass # Replace with function body.
