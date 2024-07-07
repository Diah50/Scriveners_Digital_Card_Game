extends PanelContainer

var cell_pos:Vector2i
@onready var arrow = $"Arrow"
@onready var button = $TextureButton
@onready var token_container = $"Token container"
@onready var area = $Area2D

var token:Scrivener_Token = null

var resouce_count = 0
var cell_faction:CardData.Faction = CardData.Faction.NONE:
	set(faction):
		var color = CardData.new().get_faction_color(faction)
		cell_faction = faction
		$ColorRect.color = color



func _ready():
	Events.production_phase.connect(generate_resource)
	pass # Replace with function body.


func generate_resource():
	if cell_faction != CardData.Faction.NONE:
		resouce_count = token_container.get_children().size()
		Events.resource_count_updated.emit(resouce_count,cell_faction)
		
func can_interact():
	if token:
		print(Events.phase_manager.get_game_phase() == Events.phase_manager.PHASES.MAIN," :main Phase --- Matches group:",
		(token.is_in_group("player") and Events.turn == Events.TURN.PLAYER) or (token.is_in_group("opponent") and Events.turn == Events.TURN.OPPONENT))
		return Events.phase_manager.get_game_phase() == Events.phase_manager.PHASES.MAIN and ((token.is_in_group("player") and Events.turn == Events.TURN.PLAYER) or (token.is_in_group("opponent") and Events.turn == Events.TURN.OPPONENT))
	else:
		return false
