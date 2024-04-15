extends Area3D

@export
var local_camera: Camera3D = null
@export
var give_back_camera: bool = true
var old_camera

func _ready():
	var attempt_get_local_camera = $Camera3D
	if attempt_get_local_camera != null && local_camera == null:
		local_camera = attempt_get_local_camera

func _on_body_entered(body):
	if body is CharacterBody3D:
		if give_back_camera:
			old_camera = get_viewport().get_camera_3d()
		local_camera.current = true

func _on_body_exited(body):
	if body is CharacterBody3D:
		if give_back_camera:
			old_camera.current = true
			old_camera = null
