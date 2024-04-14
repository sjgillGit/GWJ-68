extends Area3D

@export
var local_camera: Camera3D = null
@export
var give_back_camera: bool = true
var old_camera

# Called when the node enters the scene tree for the first time.
func _ready():
	var attempt_get_local_camera = $Camera3D
	if attempt_get_local_camera != null && local_camera == null:
		local_camera = attempt_get_local_camera
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered(body):
	if body is CharacterBody3D:
		if give_back_camera:
			old_camera = body.current_camera
		body.current_camera = local_camera
		local_camera.current = true
	
	pass # Replace with function body.


func _on_body_exited(body):
	if body is CharacterBody3D:
		if give_back_camera:
			body.current_camera = old_camera
			old_camera.current = true
			old_camera = null
		
	pass # Replace with function body.
