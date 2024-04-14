extends Camera3D

@export
var player: CharacterBody3D
@export
var is_player_movement_adjusted: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(player.global_position)
	
	var parent = get_parent_node_3d()
	if parent is PathFollow3D:
		if player.global_position.distance_to(global_position) > 5:
			parent.progress += 0.05

	pass
