extends Node

signal update_card_display(card_data:CardData)
signal hide_card_display

signal change_phase

signal start_phase
signal draw_phase
signal production_phase
signal main_phase # Note suggest to rename to action phase to be more clear/intuitive
signal end_phase

signal resource_count_updated(count:int,faction:CardData.Faction)

enum TURN {PLAYER,OPPONENT}


var phase_manager:Phase_Manager
var turn:TURN
