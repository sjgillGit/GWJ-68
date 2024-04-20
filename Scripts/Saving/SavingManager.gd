#extends Node
#
##----------------------------------
## Manager class that handles methods for saving and loading current game level
##----------------------------------
#
#const save_file_path = "user://save.sav"
#const saving_group = "saving"
#
#
#func save_data() -> void:
	#var save_data = {}
	#
	#for saving_component in get_tree().get_nodes_in_group(saving_group):
		#if saving_component.has_method("get_save_data"):
			#save_data[saving_component.get_path()] = saving_component.get_save_data()
	#
	#JsonHelper.write(save_file_path, save_data)
#
#
#func load_data() -> void:
	#var saved_data = JsonHelper.read(save_file_path)
	#var saving_components = get_tree().get_nodes_in_group(saving_group)
	#
	#for temp_path in saved_data.keys():
		#var component = _find_component(saving_components, temp_path)
		#if component != null && component.has_method("load_data"):
			#var data_to_load = saved_data[temp_path]
			#component.load_data(data_to_load)
#
#
#func _find_component(components: Array, search_path: String) -> Node:
	#for item in components:
		#if str(item.get_path()) == search_path:
			#return item
	#return null
