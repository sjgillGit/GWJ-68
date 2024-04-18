extends Control

signal start_game()

func _on_play_button_pressed():
	start_game.emit()
	hide()
	
	
func _on_quit_button_pressed():
	get_tree().quit()
