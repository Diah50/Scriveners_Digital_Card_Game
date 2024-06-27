extends Node2D

class_name Card_Controler
@onready var test_res =preload("res://scenes/Test card.tres")
@onready var card_template = preload("res://scenes/card Template.tscn")
@onready var centrelCardOval = Vector2(0,(get_viewport().size.y))
@onready var horRad = get_viewport().size.x
@onready var verRad = get_viewport().size.y

var angle = deg_to_rad(90)
var ovalAngleVector = Vector2(0,0)
var cardSpread = 0.1

var hand:Array[CardTemplate]

var hand_size_limit = 12
var draw_set_size = 5

func _ready():
	randomize()
	creatHand()
	reorganiseHand()
	#Global_Game_Events.card_controler = self
	

	pass # Replace with function body.

func creatHand():
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
	newCard.cardArt = load("res://icon.svg")
	
	print(newCard.moveSpeed)

	for _i in range(5):
		create_card(newCard)
	#pass

func create_card(card_data):
	if !card_data:
		push_error("No card data given ")
		return
	ovalAngleVector = Vector2(horRad * cos(angle), -verRad * sin(angle))
	
	var newCard = card_template.instantiate()
	newCard.cardInfo = card_data
	newCard.originalPos = (centrelCardOval + ovalAngleVector)
	newCard.originalRot = (90 - rad_to_deg(angle))/8

	newCard.position = newCard.originalPos
	newCard.rotation = newCard.originalRot
	#print(newCard.cardInfo.cardName)
	add_child(newCard)
	hand.append(newCard)
	newCard.update_card_visuals()
	return newCard
	
func reorganiseHand():
	var cards_sorted = 0
	
	if hand.size() >= 9:
		cardSpread = 0.05
	else:
		cardSpread = 0.04
	
	for card in hand:
		angle = PI/2 + cardSpread*(float(hand.size())/2 - cards_sorted)
		ovalAngleVector = Vector2(horRad * cos(angle), - verRad * sin(angle))
		
		card.originalPos = (centrelCardOval + ovalAngleVector) 
		card.originalRot = (90 - rad_to_deg(angle))/180
		
		card.position = card.originalPos
		card.rotation = card.originalRot
		card.scale = Vector2(1,1)
		cards_sorted += 1

