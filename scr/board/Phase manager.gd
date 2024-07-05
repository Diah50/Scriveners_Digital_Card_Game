extends Node

enum PHASES {START,DRAW,PRODUCTION,MAIN,END}
var _game_phase:PHASES = PHASES.START
@onready var phase_banner = $"phase banner"
@onready var animator = $"phase banner/AnimationPlayer"
@onready var top_text = $"phase banner/Polygon2D/Polygon2D2/Label"
@onready var buttom_text = $"phase banner/Polygon2D2/Polygon2D2/Label2"
# Called when the node enters the scene tree for the first time.
func _ready():
	Events.change_phase.connect(next_phase)




func get_game_phase():
	return _game_phase

func next_phase():
	match _game_phase:
		PHASES.START:
			_game_phase = PHASES.DRAW
			top_text.text = str(PHASES.keys()[_game_phase])
			Events.draw_phase.emit()
			play_phase_shift()
		PHASES.DRAW:
			_game_phase = PHASES.PRODUCTION
			top_text.text = str(PHASES.keys()[_game_phase])
			buttom_text.text = "PHASE"
			Events.production_phase.emit()
			play_phase_shift()
		PHASES.PRODUCTION:
			_game_phase = PHASES.MAIN
			top_text.text = str(PHASES.keys()[_game_phase])
			buttom_text.text = "PHASE"
			Events.main_phase.emit()
			play_phase_shift()
		PHASES.MAIN:
			_game_phase = PHASES.END
			top_text.text = str(PHASES.keys()[_game_phase])
			buttom_text.text = "PHASE"
			Events.end_phase.emit()
			play_phase_shift()
		PHASES.END:
			end_turn()

	print(str(PHASES.keys()[_game_phase]))

func set_phase(phase:PHASES):
	_game_phase = phase
	play_phase_shift()

func play_phase_shift():
	
	animator.play("phase shift")


func end_turn():
	if !animator.is_playing():
		_game_phase = PHASES.END
		top_text.text = "END"
		buttom_text.text = "TURN"
		play_phase_shift()
		await animator.animation_finished
		
		if Events.turn == Events.TURN.PLAYER:
			Events.turn = Events.TURN.OPPONENT
		else:
			Events.turn = Events.TURN.PLAYER
		
		top_text.text = str(Events.TURN.keys()[Events.turn])+"'s"
		buttom_text.text = "TURN"
		play_phase_shift()
		
		await animator.animation_finished
		_game_phase = PHASES.START
		top_text.text = str(PHASES.keys()[_game_phase])
		buttom_text.text = "TURN"
		Events.start_phase.emit()
		play_phase_shift()
