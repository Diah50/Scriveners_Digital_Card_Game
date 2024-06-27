@tool
extends RichTextLabel

class_name ScrivenersRichText

# When using this make sure any key words follow this setup ${keyword}

var keyWords = [
"Ingenuity", "Endurance", "Strength", "Hegemony" , "Ambition" , "Tenacity", "Power",
"Heart", "Card", "Support", "Equipment", "Location", "Commander", "Unit","Neutral",
"Burst","Revenge","Twinattack", "Murder", "Slayer", "Protected", "Aerial", "Whirlwind", "Unique", "Logistics", "Gravefeed", "Necroform X","Improvise", "Enrage", "Pincer", "Active", "Ranged", "Guardian", "Sift X","Energize", "Patience", "Rapid", "Fervor" 
]
@export var iconSize = 24

var lastTest = ""
var lastIconSize = iconSize

func _ready():
	bbcode_enabled = true
	complile_text()

func complile_text():
	var regex = RegEx.new()
	for key in keyWords:
		regex.compile("\\$\\{("+key+"*?)}")
		#print(regex.search(text))
		text = regex.sub(text,load_text_effect(key),true)

func _process(_delta):
	if lastTest != text or iconSize != lastIconSize:
		lastTest = text
		lastIconSize = iconSize
		complile_text()

func load_text_effect(_key:String):
	match _key:
		"Ingenuity":
			return "[img={width}"+str(iconSize)+"{height}]{res://assets/textures/Icons/factions/mini_ingenuity.png}[/img]"
		"Endurance": 
			return "[img={width}"+str(iconSize)+"{height}]res://assets/textures/Icons/factions/mini_endurance.png[/img]"
		"Strength": 
			return "[img={width}"+str(iconSize)+"{height}]res://assets/textures/Icons/factions/mini_strength.png[/img]"
		"Hegemony": 
			return "[img={width}"+str(iconSize)+"{height}]res://assets/textures/Icons/factions/mini_hegemony.png[/img]"
		"Ambition": 
			return "[img={width}"+str(iconSize)+"{height}]res://assets/textures/Icons/factions/mini_ambition.png[/img]"
		"Tenacity":
			return "[img={width}"+str(iconSize)+"{height}]res://assets/textures/Icons/factions/mini_tenacity.png[/img]"
		"Power":
			return "[img={width}"+str(iconSize)+"{height}]res://assets/textures/Icons/power_icon.png[/img]"
		"Heart":
			return "[img={width}"+str(iconSize)+"{height}]res://assets/textures/Icons/heart_icon.png[/img]"
		"Card":
			return "[img={width}"+str(iconSize)+"{height}]res://assets/textures/Icons/card types/card_icon.png[/img]"
		"Neutral":
			return "[img={width}"+str(iconSize)+"{height}]res://assets/textures/Icons/card types/neutral_icon.png[/img]"
		"Support":
			return "[img={width}"+str(iconSize)+"{height}]res://assets/textures/Icons/factions/support_icon.png[/img]"
		"Equipment":
			return "[img={width}"+str(iconSize)+"{height}]res://assets/textures/Icons/card types/equipment_icon.png[/img]"
		"Location":
			return "[img={width}"+str(iconSize)+"{height}]res://assets/textures/Icons/card types/location_icon.png[/img]"
		"Commander":
			return "[img={width}"+str(iconSize)+"{height}]res://assets/textures/Icons/card types/commander_icon.png[/img]"
		"Unit":
			return "[img={width}"+str(iconSize)+"{height}]res://assets/textures/Icons/card types/unit_icon.png[/img]"
		"Burst","Revenge","Twinattack", "Murder" ,"Slayer" ,"Protected", "Aerial" ,"Whirlwind", "Unique" ,"Logistics", "Gravefeed" ,"Necroform X","Improvise" ,"Enrage" ,"Pincer" ,"Active" ,"Ranged" ,"Guardian", "Sift X","Energize", "Patience" ,"Rapid" ,"Fervor" :
			return "[font=res://assets/fonts/laila/Laila-Bold.ttf][b]"+text+"[/b][/font]"
		_:
			push_error("unlisted key word ("+text+") was used")
			return "[b][ERROR][/b] unlisted key word ("+text+") was used"


