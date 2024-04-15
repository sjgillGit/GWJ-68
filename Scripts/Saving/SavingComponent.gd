extends Node

#----------------------------------
# Component that must be inside savable object
#----------------------------------


@export var properties_to_save: Array[String]
@onready var parent = get_parent()


func get_save_data() -> Dictionary:
	var data = {}
	
	for property in properties_to_save:
		if property in parent:
			data[property] = parent.get(property)
			
	return data


func load_data(data: Dictionary) -> void:
	for property in properties_to_save:
		if property in parent:
			parent.set(property, data[property])


func _ready() -> void:
	add_to_group(SavingManager.saving_group)
