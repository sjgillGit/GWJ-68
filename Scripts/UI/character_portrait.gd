extends PanelContainer
class_name character_portrait

signal selected

var charP0_alive = true 

func _ready():
	add_to_group("portrait")


func toggle_button():
	$Button.button_pressed = !$Button.button_pressed


func _on_button_pressed():
	charP0_alive = !charP0_alive
	PlayerClassStats.PLAYER_CLASS_STATS[PlayerClassStats.class_id]["alive"] = charP0_alive
	emit_signal("selected",charP0_alive)
	#SavingManager.save_data()
	
