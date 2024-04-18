extends Button
@onready var pause_menu = %PauseMenu


func _ready():
	grab_focus()


func _on_pause_menu_visibility_changed():
	grab_focus()
