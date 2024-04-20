extends Control

class_name char_select
## NO COMMENT

@onready var mr_thumper = $"CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/CharacterContainer/CharacterPreviewContainer/SubViewportContainer/SubViewport/Mr Thumper"
@onready var select_button = $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/CharacterSelectionContainer/SelectButton


func _ready():
	select_button.connect("pressed", start_game)
	$CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/CharacterSelectionContainer/CharacterListContainer/MarginContainer/ScrollContainer/VBoxContainer/CharP0.selected.connect(character_selected)
	
	
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Main/MainMenu.tscn")

func _process(delta):
	mr_thumper.rotate_y(0.01)

func start_game():
	var level0path: PackedScene = load("res://Scenes/Menus/loading.tscn")
	get_tree().change_scene_to_packed(level0path)

func character_selected(alive):
	select_button.disabled = !alive
	print("alive")
