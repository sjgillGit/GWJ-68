extends TabBar

func _ready():
	grab_click_focus()


func _on_master_h_slider_value_changed(value):
	set_volume(0,value)

func _on_music_h_slider_value_changed(value):
	set_volume(1,value)


func _on_sfxh_slider_value_changed(value):
	set_volume(2,value)

func set_volume(idx,value):
	AudioServer.set_bus_volume_db(idx,linear_to_db(value))
