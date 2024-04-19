extends Control

@onready var settings_panel_container = %SettingsPanelContainer
@onready var menu_button_container = %MenuButtonContainer

signal start_game()

func _physics_process(delta):
	if settings_panel_container.visible == false:
		menu_button_container.visible = true
	else:
		menu_button_container.visible = false

func _ready():
	SavingManager.load_data()

func _on_play_button_pressed():
	start_game.emit()
	hide()

func _on_quit_button_pressed():
	get_tree().quit()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/character_select.tscn")


func _on_settings_button_pressed():
	settings_panel_container.show()
	menu_button_container.hide()
