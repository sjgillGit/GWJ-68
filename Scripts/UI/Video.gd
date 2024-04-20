extends TabBar

var window_mode: int
var vsync
var user_prefs: UserPreferences

@onready var fullscreen_check_box = $HBoxContainer/VBoxContainer2/FullscreenCheckBox
@onready var borderless_check_box = $HBoxContainer/VBoxContainer2/BorderlessCheckBox2
@onready var v_sync_button = $HBoxContainer/VBoxContainer2/VSyncButton

func _ready():
	user_prefs = UserPreferences.load_or_create()
	DisplayServer.window_set_mode(window_mode)
	print(window_mode)

func _on_fullscreen_check_box_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		window_mode = 3
		if user_prefs:
			user_prefs.window_mode = window_mode
			user_prefs.save()
	
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		window_mode = 0
		if user_prefs:
			user_prefs.window_mode = window_mode
			user_prefs.save()
	

func _on_borderless_check_box_2_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)
	
		
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)
	

func _on_v_sync_button_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)
	
