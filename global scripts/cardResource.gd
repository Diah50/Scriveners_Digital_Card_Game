extends Resource

class_name CardData
enum Faction{AMBITION,INGENUITY,STRENGTH,ENDURANCE,TENACITY,CONTROL,HEGEMONY}

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
			return load("res://assets/textures/Icons/card types/card_icon.png")
		CardType.COMMANDER:
			return load("res://assets/textures/Icons/card types/commander_icon.png")
		CardType.LOCATION:
			return load("res://assets/textures/Icons/card types/location_icon.png")
		CardType.SUPPORT:
			return load("res://assets/textures/Icons/card types/support_icon.png")
		CardType.NEUTRAL:
			return load("res://assets/textures/Icons/card types/neutral_icon.png")
		CardType.EQUIPMENT:
			return load("res://assets/textures/Icons/card types/equipment_icon.png")
			
		_:
			push_error("Nonexistent card type")
			return load("res://icon.svg")
		
func load_faction_texture(faction:Faction):
	match faction:
		Faction.AMBITION:
			return load("res://assets/textures/Icons/factions/ambition_icon.png")
		Faction.INGENUITY:
			return load("res://assets/textures/Icons/factions/ingenuity_icon.png")
		Faction.STRENGTH:
			return load("res://assets/textures/Icons/factions/strength_icon.png")
		Faction.ENDURANCE:
			return load("res://assets/textures/Icons/factions/endurance_icon.png")
		Faction.TENACITY:
			return load("res://assets/textures/Icons/factions/tenacity_icon.png")
		Faction.CONTROL:
			return load("res://assets/textures/Icons/factions/control_icon.png")
		Faction.HEGEMONY:
			return load("res://assets/textures/Icons/factions/hegemony_icon.png")
		_:
			push_error("Nonexistent faction type")
			return load("res://icon.svg")
func load_card_art():
	return load(cardArt)
