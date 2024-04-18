extends Button

@export var action: String = "ui_up"

func _ready():
	set_process_unhandled_key_input(false)
	_display_key()

func _display_key():
	text = InputMap.action_get_events(action) [0].as_text()
	
func _remap_action_to(event):
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, event)
	text = event.as_text()

func _on_pressed():
	set_process_unhandled_key_input(true)
	text = "press any key..."

func _unhandled_key_input(event):
	_remap_action_to(event)
	set_process_unhandled_key_input(false)
	release_focus()