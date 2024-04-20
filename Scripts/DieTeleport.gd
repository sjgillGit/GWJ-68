extends Node3D

@export var player: Node3D

const falling_position_y = -1

func _process(_delta) -> void:
	if player.global_position.y < falling_position_y:
		player.global_position = global_position\
