extends Node2D
@onready var template = $CardTemplate

func _ready():
	Events.update_card_display.connect(updated_display)
	Events.hide_card_display.connect(hid_display)

func updated_display(card_data:CardData):
	template.cardInfo = card_data
	template.update_card_visuals()
	visible = true

func hid_display():
	visible = false
