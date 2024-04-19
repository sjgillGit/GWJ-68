extends TabBar

var window_mode: int
var vsync: int

@onready var fullscreen_check_box = $HBoxContainer/VBoxContainer2/FullscreenCheckBox
@onready var borderless_check_box = $HBoxContainer/VBoxContainer2/BorderlessCheckBox2
@onready var v_sync_button = $HBoxContainer/VBoxContainer2/VSyncButton


func _on_fullscreen_check_box_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		window_mode = 3
		SavingManager.save_data()
		print(window_mode)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		window_mode = 0
		SavingManager.save_data()
		print(window_mode)


func _on_borderless_check_box_2_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)
		window_mode = 1
		SavingManager.save_data()
		print(window_mode)
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)
		window_mode = 0
		SavingManager.save_data()
		print(window_mode)

func _on_v_sync_button_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)
	SavingManager.save_data()
	vsync = index
	print(vsync)
