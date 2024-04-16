extends CharacterBody3D

#Set this to player
@onready var player = $"../Player"

@onready var navAgent = $NavigationAgent3D

var speed = 3
var maxVisibility = 10
var canSeePlayer = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	rotation.x = 0
	rotation.z = 0
	
	# Enemy Movement
	var currentLocation = global_transform.origin
	var nextLocation = navAgent.get_next_path_position()
	
	var newVelocity = (nextLocation - currentLocation).normalized() * speed
	
	# Check how close the player is.
	var distance = global_transform.origin.distance_to(player.global_transform.origin)
	
	if distance <= maxVisibility:
		canSeePlayer = true
		MoveTowardPlayer()
	else:
		canSeePlayer = false
	
	
	velocity = velocity.move_toward(newVelocity, .25)
	if canSeePlayer:
		move_and_slide()
	
func updateTargetLoc(targetLoc):
	#Move towards and look at target
	navAgent.target_position = targetLoc
	look_at(targetLoc)
	
func MoveTowardPlayer():
	updateTargetLoc(player.global_transform.origin)
	
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		print("Player Ran Into Enemy")
		pass
	
