extends CanvasLayer

@onready var settings_panel_container = %SettingsPanelContainer
@onready var pause_menu = %PauseMenu


var _is_paused:bool = false:
	set(value):
		_is_paused = value
		get_tree().paused = _is_paused
		visible = _is_paused

func _input(event):
	if event.is_action_pressed("ui_cancel") :
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state

func _on_resume_button_pressed():
	_is_paused = false

func _on_settings_button_pressed():
	%PauseContainer.visible = false
	$SettingsMenu.visible 


func _on_quit_button_pressed():
	get_tree().quit()
