extends Area3D
class_name Camera_Area

@export
var local_camera: Camera3D = null
@export
var give_back_camera: bool = true
var old_camera

func _ready():
	if local_camera == null:
		var attempt_get_local_camera = $Camera3D
		local_camera = attempt_get_local_camera

func _on_body_entered(body):
	if body is CharacterBody3D:
		if give_back_camera:
			old_camera = get_viewport().get_camera_3d()
		if local_camera != null:
			local_camera.current = true

func _on_body_exited(body):
	if body is CharacterBody3D:
		if give_back_camera && old_camera != null:
			old_camera.current = true
			old_camera = null
