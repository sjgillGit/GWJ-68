extends Node2D
class_name TQ_MM ## main menu integration init

@export var Lvl_0_Path: PackedScene = load("res://Scenes/TQ/Level_0/tq_level_0.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	
	connect_buttons()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	
	pass

func connect_buttons():
	var play_b: Button = $Main/PlayButton
	var settings_b: Button = $Main/ButtonsContainer/HBoxContainer/SettingsButton
	var quit_b: Button = $Main/ButtonsContainer/HBoxContainer/QuitButton
	var settings_back_b = $SettingsMenu/PanelContainer/MarginContainer/TabContainer/Audio/MarginContainer/AudioSettings/PanelContainer/MarginContainer/ControlsPanelContainer/HBoxContainer/BackButton
	
	quit_b.connect('pressed', _on_play_button_pressed)
	settings_b.connect('pressed', toggle_settings)
	play_b.connect('pressed', _on_play_button_pressed)
	settings_back_b.connect("pressed", toggle_settings)
	pass



func _on_play_button_pressed():
	
	get_tree().change_scene_to_packed(Lvl_0_Path)
	
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.
	
func toggle_settings():
	if $SettingsMenu.visible:
		$Main.visible = true
		$SettingsMenu.visible = false
	else:
		$SettingsMenu.visible = true
		$Main.visible = false
	
	print("settings menu toggled")
	pass
