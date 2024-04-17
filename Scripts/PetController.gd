extends CharacterBody3D

@onready var player = get_tree().current_scene.get_node_or_null("PC")

@onready var navAgent = $NavigationAgent3D

@export var speed = 6
@export var catchUpDistance = 5
@export var maxVisibility = 13

var playerTooFar = false

var currentlyIdle = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	
	# Enemy Movement
	var currentLocation = global_transform.origin
	var nextLocation = navAgent.get_next_path_position()
	
	var newVelocity = (nextLocation - currentLocation).normalized() * speed
	
	# Check how close the player is.
	var distance = global_transform.origin.distance_to(player.global_transform.origin)
	
	if distance >= maxVisibility && !playerTooFar:
		playerTooFar = true
	elif playerTooFar:
		MoveTowardPlayer()
		
	if distance <= catchUpDistance:
		playerTooFar = false
		if !currentlyIdle:
			idle()
	
	velocity = velocity.move_toward(newVelocity, .25)

	move_and_slide()
	
	if velocity.x or velocity.z != 0:
		$Mouse/AnimationPlayer.play("walk")
	else:
		$Mouse/AnimationPlayer.play("Idle")
	
	look_at(player.global_position)
	
	pass
	
func updateTargetLoc(targetLoc):
	navAgent.target_position = targetLoc
	
	
func MoveTowardPlayer():
	updateTargetLoc(player.global_transform.origin)

func idle():
	if !playerTooFar:
		currentlyIdle = true
		var newPos = Vector3(position.x + randi_range(-2,2), position.y, position.z + randi_range(-2,2))
		updateTargetLoc(newPos)
		await get_tree().create_timer(randi_range(3,8)).timeout
		currentlyIdle = false
		
	
