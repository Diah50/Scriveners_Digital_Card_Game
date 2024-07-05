extends PanelContainer

var cell_pos:Vector2i
@onready var arrow = $"Arrow"
@onready var button = $TextureButton
@onready var token_container = $"Token container"
@onready var area = $Area2D

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

