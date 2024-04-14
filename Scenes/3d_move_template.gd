extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = $PlayerDummy
	var camera = $Path3D/PathFollow3D/Camera3D
	
	
	if player.global_position.distance_to(camera.global_position) > 5:
		$Path3D/PathFollow3D.progress += 0.05
		pass
	
	camera.look_at(player.global_position)
	
	pass

