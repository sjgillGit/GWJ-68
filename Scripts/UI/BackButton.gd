extends Button

@onready var settings = %Settings
@onready var pause_menu = %PauseMenu
@onready var settings_panel_container = %SettingsPanelContainer


func _on_pressed():
	pause_menu.show()
	settings_panel_container.hide()
