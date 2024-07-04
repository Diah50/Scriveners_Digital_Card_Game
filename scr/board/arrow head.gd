extends Line2D
class_name Targeting_Arrow
# warning-ignore:unused_signal
signal arrow_released(target_pos:Vector2i)
# warning-ignore:unused_signal
signal arrow_hovering(set_disable:bool,calling_card:CardTemplate)
# warning-ignore:unused_signal
signal arrow_stop_hovering(set_disable:bool,calling_card:CardTemplate)

@onready var lineOwner = get_parent()
@onready var head := $head
@onready var collider = $head/Area2D
@export var maxPoints = 20

var is_arrow_disabled = true: 
	set(state):
		is_arrow_disabled = state
		collider.monitoring = !state
		visible = !state


func _ready():
	add_point(Vector2.ZERO,0)
	add_point(Vector2.ZERO,1)
	
func _process(_delta): 
	if !is_arrow_disabled:
		draw_arrow()

func draw_arrow():
	set_point_position(1,get_local_mouse_position())
 
	head.position = get_point_position(1)

	head.rotation = get_point_position(0).direction_to(get_point_position(get_point_count( ) - 1)).round().angle()
	pass

func _on_area_2d_area_entered(_area):
	pass # Replace with function body.


func _on_area_2d_area_exited(_area):
	pass # Replace with function body.


func get_colliing_cell():
	var areas = collider.get_overlapping_areas()
	for area in areas:
		if area.get_parent().is_in_group("cell") and area.get_parent() != lineOwner:
			return area.get_parent()
	return null
	
	
	
	
	
