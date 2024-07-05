extends Node2D

class_name CardTemplate
@onready var cardName = $"Control/background/Panel/header/HBoxContainer/name and types/cardName"
@onready var cost = $"Control/background/Panel/header/HBoxContainer/Faction and cost/cost"
@onready var faction = $"Control/background/Panel/header/HBoxContainer/Faction and cost/factionTexture"
@onready var subtype = $"Control/background/Panel/header/HBoxContainer/name and types/subtypeText"
@onready var power = $Control/background/Panel/Power/TextureRect/powerText
@onready var heart = $Control/background/Panel/Heart/TextureRect/heartText
@onready var description = $"Control/background/Panel/Description box/GridContainer/descriptionText"
@onready var flovorText = $"Control/background/Panel/Description box/GridContainer/MarginContainer/flavorText"
@onready var cardArt = $"Control/background/Panel/Image window/cardImage"
@onready var artistName = $Control/background/Panel/ArtistTage/artistName

@onready var card_btn = $Control/background/TextureButton
@onready var area2d = $Area2D

@export var cardInfo:CardData
 
var originalPos:Vector2
var originalRot:float

var is_held = false
var is_disabled = false

func _ready():
	if !cardInfo:
		push_error("Missing cardInfo")
		return
	update_card_visuals()
	
	
func _process(_delta):
	if is_held and !is_disabled:
		global_position = get_global_mouse_position()
		rotation = 0

func update_card_visuals():
	cardName.text = cardInfo.cardName
	cost.text = str(cardInfo.cost)
	faction.texture = await cardInfo.load_faction_texture(cardInfo.faction)
	subtype.text =  await cardInfo.load_card_type(cardInfo.cardType)+" "+cardInfo.subtype
	subtype.complile_text()
	power.text = str(cardInfo.power)
	heart.text = str(cardInfo.heart)
	description.text = cardInfo.description
	description.complile_text()
	flovorText.text = cardInfo.flovorText
	flovorText.complile_text()
	cardArt.texture = await cardInfo.load_card_art()
	artistName.text = cardInfo.artistName

func disable_card(state:bool,can_see:bool=true):
	is_disabled = state
	visible = can_see
	pass
