extends Node2D
class_name TQ_Save_Load

var file_p = "res://Scripts/Saving/test.txt" ## save file location
var content = str("ya_ boi")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	save_data(content)
	print(content)
	pass # Replace with function body.


func save_data(content):
	var file = FileAccess.open(file_p, FileAccess.WRITE) # saves the content of the var to text
	file.store_string(content)
	#FileAccess.open(file_p, FileAccess.WRITE)
	
	
	load_data()
	content = "changed" # notice the print output?
	pass

func load_data():
	var file = FileAccess.open(file_p, FileAccess.READ) # loads the var from text
	var content = file.get_as_text()
	
	#print(str(content))
	return content
