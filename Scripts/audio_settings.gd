extends Control


@onready var master_volume_slider = $PanelContainer/MarginContainer/ControlsPanelContainer/AudioContainer/ControlList/MasterVolumeSlider
@onready var music_volume_slider = $PanelContainer/MarginContainer/ControlsPanelContainer/AudioContainer/ControlList2/MarginContainer/MusicVolumeSlider
@onready var sfx_volume_slider = $PanelContainer/MarginContainer/ControlsPanelContainer/AudioContainer/ControlList3/MarginContainer/SFXVolumeSlider



func _ready():
	var audio_settings = ConfigFileHandler.load_audio_settings()
	#master_volume_slider.value = min(audio_settings.master_volume, 1.0) * 100
	#music_volume_slider.value = min(audio_settings.music_volume, 1.0) * 100
	#sfx_volume_slider.value = min(audio_settings.sfx_volume, 1.0) * 100



func _on_master_h_slider_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_setting("master_volume", master_volume_slider.value / 100)


func _on_music_h_slider_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_setting("music_volume", music_volume_slider.value / 100)


func _on_sfxh_slider_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_setting("sfx_volume", sfx_volume_slider.value / 100)
