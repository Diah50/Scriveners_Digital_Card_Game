extends PanelContainer

var cell_pos:Vector2i
@onready var arrow = $"Arrow"
@onready var button = $TextureButton
@onready var token_container = $"Token container"


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_area_2d_area_entered(area):
	if area.get_parent().get_parent() is Targeting_Arrow and area.get_parent().get_parent() != arrow:
		material.set("shader_parameter/is_active",true)
		pass
		
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	if area.get_parent().get_parent() is Targeting_Arrow and area.get_parent().get_parent() != arrow:
		material.set("shader_parameter/is_active",false)
	pass # Replace with function body.
