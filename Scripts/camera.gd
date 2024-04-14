extends Camera3D

@export
var is_player_movement_adjusted: bool = false
@export
var cinematic: bool = false
@export
var cinematic_progression_speed = 0.05

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player: CharacterBody3D = %Player
	
	if player != null:
		look_at(player.global_position)
		
		var parent = get_parent_node_3d()
		
		if parent is PathFollow3D:
			if cinematic:
				if player.global_position.distance_to(global_position) > 5:
					parent.progress += cinematic_progression_speed
			else:
				var path = parent.get_parent_node_3d()
				parent.progress = path.curve.get_closest_offset(path.to_local(player.global_position))
			pass

	pass
