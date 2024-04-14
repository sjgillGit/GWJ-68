extends CharacterBody3D

@export
var SPEED: float = 5.0
@export
var acceleration: float = 2.00
@export
var deceleration: float = 1.25

const SPRINT_MOD: float = 2.0
const JUMP_VELOCITY: float = 4.5
const FORCE_MULTIPLIER: float = 0.001

var final_speed: float = SPEED

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	final_speed = SPEED
	
func _get_current_camera():
	return get_viewport().get_camera_3d()
	
func process_gravity(delta: float):
	if not is_on_floor():
		velocity.y -= gravity * delta
	pass
	
func handle_jump_input():
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
func calculate_final_direction(camera):
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if camera != null && camera.is_player_movement_adjusted:
		var camera_basis = camera.get_global_transform().basis
		#var camera_angle = camera_basis.z
		direction = (camera_basis * direction).normalized()
		
	return direction
	
func modify_speed_for_sprint():
	if Input.is_action_just_pressed("move_sprint"):
		final_speed = SPEED * SPRINT_MOD
	if Input.is_action_just_released("move_sprint"):
		final_speed = SPEED
		
	return final_speed
	
func apply_movement(_delta: float, direction, speed: float):
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * speed, acceleration)
		velocity.z = move_toward(velocity.z, direction.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)
		
func collide_with_rigidbodies_godot4_fix():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var other_body = collision.get_collider()
		
		var force = velocity
		if other_body is RigidBody3D:
			var apply_force = final_speed * FORCE_MULTIPLIER
#			#other_body.apply_force(-collision.get_normal() * 0.3)
			other_body.apply_impulse(-collision.get_normal() * apply_force)

func _physics_process(delta):
	process_gravity(delta)
	
	handle_jump_input()

	var direction = calculate_final_direction(_get_current_camera())
	var speed = modify_speed_for_sprint()
	
	#if is_on_floor():
	apply_movement(delta, direction, speed)
	
	move_and_slide()
	collide_with_rigidbodies_godot4_fix()
