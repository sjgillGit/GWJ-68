extends PanelContainer

var character_count: int
var current_character: int


func _ready():
	for child in $MarginContainer/ScrollContainer/VBoxContainer.get_children():
		if child.get_node_or_null("Button") != null:
			child.get_node_or_null("Button").connect("pressed", test)
			
	
	character_select()
	print(str(character_count))

func _process(delta):
	pass
	
func character_select():
	for child in $MarginContainer/ScrollContainer/VBoxContainer.get_children():
		if child.is_in_group("portrait"):
			character_count += 1
			match child.name:
				"CharP0":
					PlayerClassStats.class_id = 0
					current_character = 0
					PlayerClassStats.PLAYER_CLASS_STATS[PlayerClassStats.class_id]["alive"] = true
					print(str(PlayerClassStats.PLAYER_CLASS_STATS[0]["alive"]))
					
				"CharP1":
					PlayerClassStats.class_id = 1
					PlayerClassStats.PLAYER_CLASS_STATS[PlayerClassStats.class_id]["alive"] = true
					print("rodent_id")
					
				"CharP2":
					PlayerClassStats.class_id = 2
					PlayerClassStats.PLAYER_CLASS_STATS[PlayerClassStats.class_id]["alive"] = true
					print("rodent_id")
					
				"CharP3":
					PlayerClassStats.class_id = 3
					PlayerClassStats.PLAYER_CLASS_STATS[PlayerClassStats.class_id]["alive"] = true
					print("rodent_id")
					
				"CharP4":
					PlayerClassStats.class_id = 4
					PlayerClassStats.PLAYER_CLASS_STATS[PlayerClassStats.class_id]["alive"] = true
					print("rodent_id")
				
	
	
func test():
	pass
	print("test passed")

