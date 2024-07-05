extends Node2D

@onready var phase_banner = $"Phase manager"
@onready var phase_manager = $"Phase manager"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_next_phase_btn_pressed():
	if !phase_banner.animator.is_playing():
		Events.change_phase.emit()



func _on_end_turn_btn_pressed():
	phase_manager.end_turn()
	pass # Replace with function body.


