extends PanelContainer
class_name character_portrait


func _ready():
	add_to_group("portrait")


func toggle_button():
	$Button.button_pressed = !$Button.button_pressed


func _on_button_pressed():
	print("pressed" + str(name))
	
