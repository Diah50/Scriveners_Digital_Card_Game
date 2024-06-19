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


@export var cardInfo:CardData 

var max_health = cardInfo.heart
var health = max_health:
	set(value):
		if health-value<=0 and value<0 :
			health = 0
		elif health+value>= max_health and value>0:
			health = max_health
		health = value 
func _ready():
	update_card_visuals()
	
func update_card_visuals():
	cardName.text = cardInfo.cardName
	cost.text = str(cardInfo.cost)
	faction.texture = await cardInfo.load_faction_texture(cardInfo.faction)
	subtype.text =  await cardInfo.load_card_type(cardInfo.cardType)+" "+cardInfo.subtype
	power.text = str(cardInfo.power)
	heart.text = str(cardInfo.heart)
	description.text = cardInfo.description
	flovorText.text = cardInfo.flovorText
	cardArt.texture = await cardInfo.load_card_art()
	artistName.text = cardInfo.artistName
	
