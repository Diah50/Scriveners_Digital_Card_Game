extends Resource

class_name CardData
enum Faction{AMBITION,INGENUITY,STRENGTH,ENDURANCE,TENACITY,CONTROL}
enum Subtype {ROBOT}
enum CardType {CARD,COMMANDER,LOCATION,SUPPORT,NEUTRAL,EQUIPMENT}
@export var cardName:String
@export var cost:int
@export var cardType:CardType
@export var faction:Faction
@export var subtype:String
@export var power:int
@export var heart:int
@export var description:String
@export var flovorText:String
@export var artistName:String
@export var cardArt:String

func load_card_type_texture(type:CardType):
	match type:
		CardType.CARD:
			return load("res://assets/textures/Icons/card_icon.png")
		CardType.COMMANDER:
			return load("res://assets/textures/Icons/commander_icon.png")
		CardType.LOCATION:
			return load("res://assets/textures/Icons/location_icon.png")
		CardType.SUPPORT:
			return load("res://assets/textures/Icons/support_icon.png")
		CardType.NEUTRAL:
			return load("res://assets/textures/Icons/neutral_icon.png")
		CardType.EQUIPMENT:
			return load("res://assets/textures/Icons/equipment_icon.png")
		_:
			push_error("Nonexistent card type")
			return load("res://icon.svg")
		
func load_faction_texture(faction:Faction):
	match faction:
		Faction.AMBITION:
			return load("res://assets/textures/Icons/ambition_icon.png")
		Faction.INGENUITY:
			return load("res://assets/textures/Icons/ingenuity_icon.png")
		Faction.STRENGTH:
			return load("res://assets/textures/Icons/strength_icon.png")
		Faction.ENDURANCE:
			return load("res://assets/textures/Icons/endurance_icon.png")
		Faction.TENACITY:
			return load("res://assets/textures/Icons/tenacity_icon.png")
		Faction.CONTROL:
			return load("res://assets/textures/Icons/control_icon.png")
		_:
			push_error("Nonexistent faction type")
			return load("res://icon.svg")
func load_card_art():
	return load(cardArt)
