extends GridContainer



@onready var ambition_text = $"Ambition resource/Label"
@onready var tenacity_text = $"Tenacity resource/Label"
@onready var endurance_text = $"Endurance resource/Label"
@onready var hegemony_text = $"Hegemony resource/Label"
@onready var ingenuity_text = $"Ingenuity resource/Label"
@onready var strength_text = $"Strength resource/Label"


var ambition_count = 0
var tenacity_count = 0
var endurance_count = 0
var hegemony_count = 0
var ingenuity_count = 0
var strength_count = 0

func _ready():
	Events.resource_count_updated.connect(update_resource_count)

func update_resource_count(count:int,faction:CardData.Faction):
	if is_in_group("player") and Events.turn == Events.TURN.PLAYER :
		match faction:
			CardData.Faction.AMBITION:
				ambition_count += count
			CardData.Faction.ENDURANCE:
				tenacity_count += count
			CardData.Faction.INGENUITY:
				endurance_count += count
			CardData.Faction.HEGEMONY:
				hegemony_count += count
			CardData.Faction.TENACITY:
				ingenuity_count += count
			CardData.Faction.STRENGTH:
				strength_count += count
		update_resources_text()
	elif  is_in_group("opponent") and Events.turn == Events.TURN.OPPONENT :
		match faction:
			CardData.Faction.AMBITION:
				ambition_count += count
			CardData.Faction.ENDURANCE:
				tenacity_count += count
			CardData.Faction.INGENUITY:
				endurance_count += count
			CardData.Faction.HEGEMONY:
				hegemony_count += count
			CardData.Faction.TENACITY:
				ingenuity_count += count
			CardData.Faction.STRENGTH:
				strength_count += count
		update_resources_text()

		
func update_resources_text():
		ambition_text.text = str(ambition_count)
		tenacity_text.text = str(tenacity_count)
		endurance_text.text = str(endurance_count)
		hegemony_text.text = str(hegemony_count)
		ingenuity_text.text = str(ingenuity_count)
		strength_text.text = str(strength_count)
