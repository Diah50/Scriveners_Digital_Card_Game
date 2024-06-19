extends Resource

class_name CardData
enum Faction{AMBITION,INGENUITY,STRENGTH,ENDURANCE,TENACITY,CONTROL,HEGEMONY}

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
@export var moveSpeed:int = 1

func load_card_type(type:CardType):
	match type:
		CardType.CARD:
			return "${Card}"
		CardType.COMMANDER:
			return "${Commander}"
		CardType.LOCATION:
			return "${Location}"
		CardType.SUPPORT:
			return "${Support}"
		CardType.NEUTRAL:
			return "${Neutral}"
		CardType.EQUIPMENT:
			return "${Equipment}"
			
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
