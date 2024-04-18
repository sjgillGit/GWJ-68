extends Button
@onready var settings = %Settings
@onready var main_menu = %MainMenu
@onready var settings_panel_container = %SettingsPanelContainer



func _on_pressed():
	settings_panel_container.show()
	get_parent().hide()


func _on_back_button_pressed():
	pass # Replace with function body.
