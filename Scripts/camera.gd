extends Camera3D
class_name Camcorder

@export
var is_player_movement_adjusted: bool = false
@export
var cinematic: bool = false
@export
var cinematic_progression_speed = 0.05

func _process(_delta):
	var player: CharacterBody3D = %Player
	
	if player != null:
		if_path_camera_then_move_near_player(player)
		
		look_at(player.global_position)

func if_path_camera_then_move_near_player(player):
	var parent = get_parent_node_3d()
	
	if parent is PathFollow3D:
		if cinematic:
			if player.global_position.distance_to(global_position) > 5:
				parent.progress += cinematic_progression_speed
		else:
			var path = parent.get_parent_node_3d()
			parent.progress = path.curve.get_closest_offset(path.to_local(player.global_position))
