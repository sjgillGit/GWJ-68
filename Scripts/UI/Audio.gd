extends TabBar

@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

@onready var master_h_slider = %MasterHSlider
@onready var music_h_slider = %MusicHSlider
@onready var sfxh_slider = %SFXHSlider

var user_prefs: UserPreferences

func _ready():
	grab_click_focus()
	
	user_prefs = UserPreferences.load_or_create()
	if master_h_slider:
		master_h_slider.value = user_prefs.master_volume
	if music_h_slider:
		music_h_slider.value = user_prefs.music_volume
	if sfxh_slider:
		sfxh_slider.value = user_prefs.sfx_volume


func _on_master_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value))
	if user_prefs:
		user_prefs.master_volume = value
		user_prefs.save()

func _on_music_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	if user_prefs:
		user_prefs.music_volume = value
		user_prefs.save()
		
func _on_sfxh_slider_value_changed(value):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	if user_prefs:
		user_prefs.sfx_volume = value
		user_prefs.save()

