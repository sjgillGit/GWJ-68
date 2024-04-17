extends StaticBody3D

# SET FAILSAFEPOS OBJECT TO BE BEYOND TRAP	

@export
var obstacle = false
#@export
@export
var trap = false #Currenlty don't have checkpoints for trip to work
@export
var trip = false

var obstacleStrength = 6

@onready var failSafe = $FailSafePos
@onready var player = $"../Player"

func _on_area_3d_body_entered(body):
	var speed = player.final_speed
	
	if body.name == "Player":
		if obstacle:
			#Get speed of the player, either player stops, or if fast enough, obstacle breaks and slows player.
			if speed > obstacleStrength:
				breakObstacle()
				player.playerStunned(2)
		elif trap:
			if!player.trapped:
				player.hitTrap(failSafe.global_transform.origin) #Respawn Player At Checkpoint. Checkpoints dont exist yet, will wait until map is made to implement.
		elif trip:
			if speed > 5:
				player.playerStunned(1) # Faster player is going, the more they are hindered
			else:
				player.playerStunned(2)

func breakObstacle():
	#Prob add some sort of particle effect
	$CollisionShape3D.queue_free()
	print("Player ran into obstacle")
	await get_tree().create_timer(1).timeout
	queue_free()
