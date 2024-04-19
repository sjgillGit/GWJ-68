extends TabBar

var master_volume: float
var music_volume: float
var sfx_volume: float

@onready var master_h_slider = $HBoxContainer/VBoxContainer2/MasterHSlider
@onready var music_h_slider = $HBoxContainer/VBoxContainer2/MusicHSlider
@onready var sfxh_slider = $HBoxContainer/VBoxContainer2/SFXHSlider

func _ready():
	grab_click_focus()
	SavingManager.load_data()
	set_volume(0,master_volume)
	set_volume(1,music_volume)
	set_volume(2,sfx_volume)
	master_h_slider.value = master_volume
	music_h_slider.value = music_volume
	sfxh_slider.value = sfx_volume


func _on_master_h_slider_value_changed(value):
	set_volume(0,value)
	master_volume = value
	SavingManager.save_data()

func _on_music_h_slider_value_changed(value):
	set_volume(1,value)
	music_volume = value
	SavingManager.save_data()
	
func _on_sfxh_slider_value_changed(value):
	set_volume(2,value)
	sfx_volume = value
	SavingManager.save_data()

func set_volume(idx,value):
	AudioServer.set_bus_volume_db(idx,linear_to_db(value))
