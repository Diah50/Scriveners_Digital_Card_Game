extends Node2D

class_name CardTemplate
@onready var cardName = $Control/background/Panel/header/Panel/VBoxContainer/cardName
@onready var cost = $Control/background/Panel/header/Panel/VBoxContainer/HBoxContainer2/cost
@onready var cardType =$Control/background/Panel/header/Panel/VBoxContainer/HBoxContainer/cardType
@onready var faction = $"Control/background/Panel/Faction icon/factionTexture"
@onready var subtype = $Control/background/Panel/header/Panel/VBoxContainer/HBoxContainer/subtypeText
@onready var power = $Control/background/Panel/Power/TextureRect/powerText
@onready var heart = $Control/background/Panel/Heart/TextureRect/heartText
@onready var description = $"Control/background/Panel/Description box/Panel/GridContainer/descriptionText"
@onready var flovorText = $"Control/background/Panel/Description box/Panel/GridContainer/MarginContainer/flavorText"
@onready var cardArt = $"Control/background/Panel/Image window/cardImage"
@onready var artistName = $Control/background/Panel/ArtistTage/artistName


@export var cardInfo:CardData 



func _ready():
	update_card_data()
	
func update_card_data():
	cardName.text = cardInfo.cardName
	cost.text = str(cardInfo.cost)
	cardType.texture = await cardInfo.load_card_type_texture(cardInfo.cardType)
	faction.texture = await cardInfo.load_faction_texture(cardInfo.faction)
	subtype.text = cardInfo.subtype
	power.text = str(cardInfo.power)
	heart.text = str(cardInfo.heart)
	description.text = cardInfo.description
	flovorText.text = cardInfo.flovorText
	cardArt.texture = await cardInfo.load_card_art()
	artistName.text = cardInfo.artistName
	
