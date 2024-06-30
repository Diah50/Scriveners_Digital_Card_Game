extends Node2D

class_name Card_Controler
@onready var card_template = preload("res://scr/cards/card Template.tscn")
@onready var centrel_card_oval = Vector2(0,(get_viewport().size.y))
@onready var horizontal_radiance = get_viewport().size.x
@onready var vertical_radiance = get_viewport().size.y

var angle = deg_to_rad(90)
var oval_angle_vector = Vector2(0,0)
var card_spread = 0.1

var hand:Array[CardTemplate]

var hand_size_limit = 12
var draw_set_size = 5

func _ready():
	creat_hand()
	reorganise_hand()

func creat_hand():
	var newCard:CardData = CardData.new()
	newCard.cardName = "Dev Card"
	newCard.cost = 1
	newCard.cardType = CardData.CardType.CARD
	newCard.faction = CardData.Faction.AMBITION
	newCard.subtype = "Dev card"
	newCard.power = 99
	newCard.heart = 66
	newCard.description = "This is a dev card made for testing"
	newCard.flovorText = "Tested flovor"
	newCard.artistName = ""
	newCard.moveSpeed = 1
	newCard.cardArt = "res://icon.svg"
	
	print(newCard.moveSpeed)

	for _i in range(5):
		create_card(newCard)

func create_card(card_data:CardData):
	if !card_data:
		push_error("No card data given ")
		return
	oval_angle_vector = Vector2(horizontal_radiance * cos(angle), -vertical_radiance * sin(angle))
	
	var newCard = card_template.instantiate()
	newCard.cardInfo = card_data
	newCard.originalPos = (centrel_card_oval + oval_angle_vector)
	newCard.originalRot = (90 - rad_to_deg(angle))/8
	newCard.position = newCard.originalPos
	newCard.rotation = newCard.originalRot

	add_child(newCard)
	hand.append(newCard)
	newCard.update_card_visuals()

	return newCard

func reorganise_hand():
	var cards_sorted = 0
	
	if hand.size() >= 9:
		card_spread = 0.05
	else:
		card_spread = 0.04
	
	for card in hand:
		angle = PI/2 + card_spread*(float(hand.size())/2 - cards_sorted)
		oval_angle_vector = Vector2(horizontal_radiance * cos(angle), -vertical_radiance * sin(angle))
		
		card.originalPos = (centrel_card_oval + oval_angle_vector) 
		card.originalRot = (90 - rad_to_deg(angle))/180
		
		card.position = card.originalPos
		card.rotation = card.originalRot
		card.scale = Vector2(1,1)
		cards_sorted += 1

