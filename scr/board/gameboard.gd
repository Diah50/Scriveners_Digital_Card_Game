extends Node2D

@onready var phase_banner = $"Phase manager"
@onready var phase_manager = $"Phase manager"

func _on_next_phase_btn_pressed():
	if !phase_banner.animator.is_playing() and Events.turn == Events.TURN.PLAYER:
		Events.change_phase.emit()

func _on_end_turn_btn_pressed():
	if !phase_banner.animator.is_playing() and Events.turn == Events.TURN.PLAYER:
		phase_manager.end_turn()
	pass # Replace with function body.


