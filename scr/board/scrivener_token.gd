extends Control

var token_data:CardData
@onready var power_text = $power/Label
@onready var heath_text = $heart/Label
@onready var token_art = $PanelContainer/TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	if token_data:
		power_text.text = str(token_data.power)
		heath_text.text = str(token_data.heart)
		token_art.texture_normal = await token_data.load_card_art()


func _process(_delta):
	pass


func _on_texture_button_mouse_entered():
	modulate = Color("6e6e6e")
	pass # Replace with function body.


func _on_texture_button_mouse_exited():
	modulate = Color.WHITE
	pass # Replace with function body.


func _on_texture_button_pressed():
	print("I was cliicked")
	pass # Replace with function body.
