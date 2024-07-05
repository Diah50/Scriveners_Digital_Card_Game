extends Node2D

class_name Card_Controler

@onready var hand_collection = $Hand
@onready var banished_collection = $Banished
@onready var graveyard_collection = $Graveyard
@onready var deck_collection = $Deck
@onready var on_board_collection = $"On board"

@onready var scrivener_token = preload("res://scr/board/scrivener_token.tscn")
@onready var card_template = preload("res://scr/cards/card Template.tscn")
@onready var centrel_card_oval = Vector2(0,(get_viewport().size.y))
@onready var horizontal_radiance = get_viewport().size.x
@onready var vertical_radiance = get_viewport().size.y

@export var deck_btn:TextureButton
@export var graveyard_btn:TextureButton
@export var banished_btn:TextureButton

var angle = deg_to_rad(90)
var oval_angle_vector = Vector2(0,0)
var card_spread = 0.1

var hand_pile:Array[CardTemplate] = []
var deck_pile:Array[CardTemplate] = []
var graveyard_pile:Array[CardTemplate] = []
var banished_pile:Array[CardTemplate] = []
var on_board_pile:Array[CardTemplate] = []

enum CARD_HOLDER {HAND,DECK,GRAVEYARD,BANISHED,ON_BOARD}

var hand_size_limit = 12
var draw_set_size = 5

func _ready():
	_connect_signals()
	create_hand()
	reorganise_hand()

func create_hand():
	var newCard:CardData = CardData.new()
	newCard.cardName = "Dev Card2"
	newCard.cost = 1
	newCard.cardType = CardData.CardType.COMMANDER
	newCard.faction = CardData.Faction.AMBITION
	newCard.subtype = "Dev card"
	newCard.power = 900
	newCard.heart = 69
	newCard.description = "This is a dev card made for testing"
	newCard.flovorText = "Some Text a guy wrote"
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
	newCard.disable_card(true,false)
	deck_collection.add_child(newCard)
	_connect_card_signals(newCard)
	deck_pile.append(newCard)
	newCard.update_card_visuals()

	return newCard

func reorganise_hand():
	var cards_sorted = 0
	if hand_pile.size() >= 9:
		card_spread = 0.05
	else:
		card_spread = 0.04
	
	for card in hand_pile:
		angle = PI/2 + card_spread*(float(hand_pile.size())/2 - cards_sorted)
		oval_angle_vector = Vector2(horizontal_radiance * cos(angle), -vertical_radiance * sin(angle))
		
		card.originalPos = (centrel_card_oval + oval_angle_vector) 
		card.originalRot = (90 - rad_to_deg(angle))/180
		
		card.position = card.originalPos
		card.rotation = card.originalRot
		card.scale = Vector2(1,1)
		
		await animate_card_tranision(card,card.originalPos,card.originalRot)
		
		cards_sorted += 1

func base_trasfer(taker_arr:Array,recicer_arr:Array,recicer_node:Node2D,card:CardTemplate):
	card.call_deferred_thread_group("reparent",recicer_node)
	#card.call_deferred("reparent",recicer_node)
	card.reparent(recicer_node)
	recicer_arr.append(card)
	taker_arr.erase(card)

# Transfer a card from one collection to another 
# Return true if transfer was successfull.
func transfer_card_to(to:CARD_HOLDER,card:CardTemplate):
	var from:int
	if card.get_parent() == hand_collection:
		from = CARD_HOLDER.HAND
	elif card.get_parent() == deck_collection:
		from = CARD_HOLDER.DECK
	elif card.get_parent() == graveyard_collection:
		from = CARD_HOLDER.GRAVEYARD
	elif card.get_parent() == banished_collection:
		from = CARD_HOLDER.BANISHED
	elif card.get_parent() == on_board_collection:
		from = CARD_HOLDER.ON_BOARD
		
	match from:
		CARD_HOLDER.HAND:
			var active_card = hand_pile.find(card,0)
			if to == CARD_HOLDER.DECK and active_card != -1:
				card.disable_card(true,false)
				base_trasfer(hand_pile,deck_pile,banished_collection,card)
				reorganise_hand()
			elif to == CARD_HOLDER.BANISHED and active_card != -1:
				card.disable_card(true,false)
				base_trasfer(hand_pile,banished_pile,banished_collection,card)
				reorganise_hand()
			elif to == CARD_HOLDER.GRAVEYARD and active_card != -1:
				card.disable_card(true,false)
				base_trasfer(hand_pile,graveyard_pile,graveyard_collection,card)
				reorganise_hand()
			elif to == CARD_HOLDER.ON_BOARD and active_card != -1:
				card.disable_card(true,false)
				base_trasfer(hand_pile,on_board_pile,on_board_collection,card)
				reorganise_hand()
			else:
				return false
		CARD_HOLDER.DECK:
			var active_card = deck_pile.find(card,0)
			if to == CARD_HOLDER.HAND and active_card != -1:
				base_trasfer(deck_pile,hand_pile,hand_collection,card)
				card.disable_card(false)
				reorganise_hand()
			elif to == CARD_HOLDER.BANISHED and active_card != -1:
				base_trasfer(deck_pile,banished_pile,banished_collection,card)
			elif to == CARD_HOLDER.GRAVEYARD and active_card != -1:
				base_trasfer(deck_pile,graveyard_pile,graveyard_collection,card)
			elif to == CARD_HOLDER.ON_BOARD and active_card != -1:
				base_trasfer(deck_pile,on_board_pile,on_board_collection,card)
			else:
				return false
		CARD_HOLDER.BANISHED:
			var active_card = banished_pile.find(card,0)
			if to == CARD_HOLDER.DECK and active_card != -1:
				base_trasfer(banished_pile,deck_pile,deck_collection,card)
			elif to == CARD_HOLDER.GRAVEYARD and active_card != -1:
				base_trasfer(banished_pile,graveyard_pile,graveyard_collection,card)
			elif to == CARD_HOLDER.HAND and active_card != -1:
				card.disable_card(false)
				base_trasfer(banished_pile,hand_pile,hand_collection,card)
				reorganise_hand()
			elif to == CARD_HOLDER.ON_BOARD and active_card != -1:
				base_trasfer(banished_pile,on_board_pile,on_board_collection,card)
			else:
				return false	
		CARD_HOLDER.GRAVEYARD:
			var active_card = graveyard_pile.find(card,0)
			if to == CARD_HOLDER.DECK and active_card != -1:
				base_trasfer(graveyard_pile,deck_pile,deck_collection,card)
			elif to == CARD_HOLDER.BANISHED and active_card != -1:
				base_trasfer(graveyard_pile,banished_pile,banished_collection,card)
			elif to == CARD_HOLDER.HAND and active_card != -1:
				card.disable_card(false)
				base_trasfer(graveyard_pile,hand_pile,hand_collection,card)
				reorganise_hand()
			elif to == CARD_HOLDER.ON_BOARD and active_card != -1:
				base_trasfer(graveyard_pile,on_board_pile,on_board_collection,card)
			else:
				return false
		CARD_HOLDER.ON_BOARD:
			var active_card = on_board_pile.find(card,0)
			if to == CARD_HOLDER.DECK and active_card != -1:
				base_trasfer(on_board_pile,deck_pile,deck_collection,card)
			elif to == CARD_HOLDER.BANISHED and active_card != -1:
				base_trasfer(on_board_pile,banished_pile,banished_collection,card)
			elif to == CARD_HOLDER.HAND and active_card != -1:
				card.disable_card(false)
				reorganise_hand()
			elif to == CARD_HOLDER.GRAVEYARD and active_card != -1:
				base_trasfer(on_board_pile,graveyard_pile,graveyard_collection,card)
			else:
				return false
			pass
	return true
	
func animate_card_tranision(card:CardTemplate,pos:Vector2,rot:float):
	var tweener := create_tween().set_parallel(true)
	var time_lasp = 0.05
	
	tweener.tween_property(card,"position",pos,time_lasp)
	tweener.tween_property(card,"scale",Vector2(1,1),time_lasp)
	tweener.tween_property(card,"rotation",rot,time_lasp,)
	tweener.play()

func draw_card():
	if deck_pile.size() == 0:
		print("No cards left to draw")
		return
	if hand_pile.size() > hand_size_limit:
		print("Hand is full can't draw anymore cards")
		return
	if deck_pile.size() == 0:
		print("nothing to draw")
		return
	transfer_card_to(CARD_HOLDER.HAND,deck_pile[0])
	
func randomise_deck_order():
	var new_deck = []
	for card in deck_pile:
		new_deck.append(deck_pile.pick_random())
	deck_pile = new_deck

func convert_card_to_token(card:CardTemplate):
	var areas = card.area2d.get_overlapping_areas()
	for area in areas:
		if area.get_parent().is_in_group("cell"):
			var token = scrivener_token.instantiate()
			token.token_data = card.cardInfo
			area.get_parent().get_node("Token container").add_child(token)
			transfer_card_to(CARD_HOLDER.ON_BOARD,card)
			break


func _connect_signals():
	deck_btn.pressed.connect(_on_deck_button_pressed)
	graveyard_btn.pressed.connect(_on_graveyard_button_pressed)
	banished_btn.pressed.connect(_on_banished_button_pressed)
	
func _connect_card_signals(card:CardTemplate):
	card.card_btn.button_down.connect(_on_card_btn_down.bind(card))
	card.card_btn.button_up.connect(_on_card_btn_up.bind(card))
	card.card_btn.mouse_entered.connect(_on_card_mouse_entered.bind(card))
	card.card_btn.mouse_exited.connect(_on_card_mouse_exited.bind(card))
	
func _on_deck_button_pressed():
	print("Clicked on deck")
	draw_card()
	pass

func _on_graveyard_button_pressed():
	print("Clicked on Graveyard")
	pass

func _on_banished_button_pressed():
	print("Clicked on Banished")
	pass

func _on_card_btn_down(card:CardTemplate):
	card.is_held = true
	pass

func _on_card_btn_up(card:CardTemplate):

	card.is_held = false
	card.position = card.originalPos
	card.rotation = card.originalRot
	convert_card_to_token(card)
	pass

func _on_card_mouse_entered(card:CardTemplate):
	print("in")
	card.modulate.a = 0.8
	print(card.cardInfo)
	Events.update_card_display.emit(card.cardInfo)

	pass

func _on_card_mouse_exited(card:CardTemplate):
	print("out")
	card.modulate.a = 1
	Events.hide_card_display.emit()
	pass
