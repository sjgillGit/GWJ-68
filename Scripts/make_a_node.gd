@tool
extends Node3D
class_name make_a_node
## @experimental

## Enter Description Here

var ex  ##Variable Description

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		SPINBABY(delta)
	pass

func SPINBABY(delta):
	$MeshInstance3D.rotation.y += 0.5
