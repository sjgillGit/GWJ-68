extends StaticBody3D

var obstacle = false
var trap = false

func _on_area_3d_body_entered(body):
	if body.name == "Player":
		if obstacle:
			pass #Get speed of the player, either player stops, or if fast enough, obstacle breaks and slows player.
		elif trap:
			pass #Respawn Player At Checkpoint

func breakObstacle():
	#Prob add some sort of particle effect
	print("Player ran into obstacle")
	await get_tree().create_timer(1).timeout
	queue_free()
