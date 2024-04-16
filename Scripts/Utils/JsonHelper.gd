extends Node

#----------------------------------
# Helper class that writes and reads json data
#----------------------------------


func write(file_path: String, data: Dictionary) -> void:
	var serialized_json = JSON.stringify(data)
	var file = FileAccess.open_compressed(file_path, FileAccess.WRITE)
	file.store_string(serialized_json)


func read(file_path: String) -> Dictionary:
	var file = FileAccess.open_compressed(file_path, FileAccess.READ)
	var file_data = file.get_line()
	return JSON.parse_string(file_data)
