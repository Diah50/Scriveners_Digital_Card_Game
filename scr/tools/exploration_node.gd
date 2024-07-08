@tool
extends Marker2D
class_name Exploration_Node
signal redraw

@onready var texture = $texture
@onready var test_texture = preload("res://assets/textures/map node spirte.png")
@onready var boss_texture = preload("res://assets/textures/Icons/node map icons/boss_battle_node.png")
@onready var battel_texture = preload("res://assets/textures/Icons/node map icons/random_battle_node.png")
@onready var merchant_texture = preload("res://assets/textures/Icons/node map icons/merchant_node.png")
@onready var encounter_texture = preload("res://assets/textures/Icons/node map icons/random_encounter_node.png")
@onready var story_texture = preload("res://assets/textures/Icons/node map icons/story_node.png")
@onready var dungeon_texture = preload("res://assets/textures/Icons/node map icons/dungeon_node.png")


@export var node_type:Exploration_Node_Resource.NODE_TYPES = Exploration_Node_Resource.NODE_TYPES.NONE:
	set(type):
		node_type = type
		if is_node_ready():
			set_node_texture()
@export var connected_nodes_to:Array[Exploration_Node] = []

@export var debug_mode:= false
@export var is_locked:= false

@export var event:Exploration_Node_Resource


var last_pos:Vector2
var last_connected_nodes:Array[Exploration_Node] = []

func _ready():
	set_node_texture()
	pass

func _process(delta):
	if position != last_pos or connected_nodes_to != last_connected_nodes:
		last_pos = position
		last_connected_nodes = connected_nodes_to
		redraw.emit()


func _draw():
	if debug_mode:
		for node in connected_nodes_to:
			draw_line(Vector2.ZERO,to_local(node.global_position),set_node_color(),5)
		#print("draw")

func set_node_texture():
	match node_type:
		Exploration_Node_Resource.NODE_TYPES.COMBAT:
			texture.texture_normal = battel_texture 
		Exploration_Node_Resource.NODE_TYPES.STORY:
			texture.texture_normal = story_texture 
		Exploration_Node_Resource.NODE_TYPES.BOSS:
			texture.texture_normal = boss_texture
		Exploration_Node_Resource.NODE_TYPES.EVENT:
			texture.texture_normal = encounter_texture
		Exploration_Node_Resource.NODE_TYPES.DUNGEON:
			texture.texture_normal = dungeon_texture
		Exploration_Node_Resource.NODE_TYPES.MERCHANT:
			texture.texture_normal = merchant_texture
		Exploration_Node_Resource.NODE_TYPES.NONE:
			texture.texture_normal = test_texture

# THis will be replaced with images for nodes
func set_node_color():
	match node_type:
		Exploration_Node_Resource.NODE_TYPES.COMBAT:
			return Color.RED
		Exploration_Node_Resource.NODE_TYPES.STORY:
			return Color.SEA_GREEN
		Exploration_Node_Resource.NODE_TYPES.BOSS:
			return Color.DARK_RED
		Exploration_Node_Resource.NODE_TYPES.EVENT:
			return Color.SKY_BLUE
		Exploration_Node_Resource.NODE_TYPES.DUNGEON:
			return Color.DARK_BLUE
		Exploration_Node_Resource.NODE_TYPES.MERCHANT:
			return Color.YELLOW
		Exploration_Node_Resource.NODE_TYPES.NONE:
			return Color.WHITE

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
		Exploration_Node_Resource.NODE_TYPES.MERCHANT:
			print("A Merchant was triggered")
		Exploration_Node_Resource.NODE_TYPES.NONE:
			print("THis is blank node for testing")
	pass

func _on_texture_pressed():
	trigger_event()
	pass # Replace with function body.
