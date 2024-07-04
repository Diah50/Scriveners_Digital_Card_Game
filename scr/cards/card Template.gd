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

@onready var area2d = $Area2D
@onready var scrivener_token = preload("res://scr/board/scrivener_token.tscn")
@export var cardInfo:CardData

#@onready var max_health = cardInfo.heart
#@onready var health = max_health:
	#set(value):
		#if health-value<=0 and value<0 :
			#health = 0
		#elif health+value>= max_health and value>0:
			#health = max_health
		#health = value 

var originalPos:Vector2
var originalRot:float

var is_held = false


func _ready():
	if !cardInfo:
		push_error("Missing cardInfo")
		return
	update_card_visuals()
	
	
func _process(_delta):
	if is_held:
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
	
func check_placeable():
	var areas = area2d.get_overlapping_areas()
	for area in areas:
		if area.get_parent().is_in_group("cell"):
			var token = scrivener_token.instantiate()
			token.token_data = cardInfo
			area.get_parent().get_node("Token container").add_child(token)

			break

func _on_texture_button_mouse_entered():
	print("in")
	modulate.a = 0.8
	print(cardInfo)
	Events.update_card_display.emit(cardInfo)

	pass # Replace with function body.

func _on_texture_button_mouse_exited():
	print("out")
	modulate.a = 1
	Events.hide_card_display.emit()
	
	pass # Replace with function body.

func _on_texture_button_button_up():
	is_held = false
	position = originalPos
	rotation = originalRot
	check_placeable()
	pass # Replace with function body.

func _on_texture_button_button_down():
	is_held = true
