extends CharacterBody3D

#Set this to player
var player : CharacterBody3D

@onready var ray = $VisionCast
@onready var navAgent = $NavigationAgent3D

var speed = 4
var maxVisibility = 10
var canSeePlayer = false

var blockedPlayer = false

var playerFarAway = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if player != null:
		ray.look_at(player.global_transform.origin, Vector3.UP)
		
		if ray.is_colliding() && ray.get_collider().is_in_group("Player"):
			canSeePlayer = true
		else:
			if playerFarAway:
				player = null
			canSeePlayer = false
	
	rotation.x = 0
	rotation.z = 0
	
	# Enemy Movement
	var currentLocation = global_transform.origin
	var nextLocation = navAgent.get_next_path_position()
	
	var newVelocity = (nextLocation - currentLocation).normalized() * speed
	
	# Check how close the player is.
	
	if player != null:
		
		if canSeePlayer:
			MoveTowardPlayer()
		#var distance = global_transform.origin.distance_to(player.global_transform.origin)
		
		#if distance <= maxVisibility:
		#	canSeePlayer = true
		
		#else:
		#	canSeePlayer = false
	
	
		velocity = velocity.move_toward(newVelocity, .25)
		if canSeePlayer:
			move_and_slide()
	
func updateTargetLoc(targetLoc):
	#Move towards and look at target
	if !blockedPlayer:
		navAgent.target_position = targetLoc
		if canSeePlayer:
			look_at(targetLoc)
	
func MoveTowardPlayer():
	updateTargetLoc(player.global_transform.origin)
	
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		if !blockedPlayer:
			blockedPlayer = true
			player.playerStunned(0)
	
func _on_line_ofsight_body_entered(body):
	if body.name == "Player":
		player = body
		playerFarAway = false

func _on_line_ofsight_body_exited(body):
	if body.name == "Player":
		playerFarAway = true
