extends Node

#----------------------------------
# Component that must be inside savable object
#----------------------------------


@export var properties_to_save: Array[String]
@onready var parent = get_parent()

signal before_loaded
signal after_loaded


func get_save_data() -> Dictionary:
	var data = {}
	
	for property in properties_to_save:
		if property in parent:
			data[property] = parent.get(property)
			
	return data


func load_data(data: Dictionary) -> void:
	before_loaded.emit()
	
	for property in properties_to_save:
		if property in parent:
			parent.set(property, data[property])
	
	after_loaded.emit()


func _ready() -> void:
	add_to_group(SavingManager.saving_group)
