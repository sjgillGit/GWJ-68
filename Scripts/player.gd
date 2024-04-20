extends CharacterBody3D
class_name BasePlayer

@export
var SPEED: float = 5.0
@export
var acceleration: float = 2.00
@export
var deceleration: float = 1.25

const SPRINT_MOD: float = 2.0
const JUMP_VELOCITY: float = 6
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
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down") \
		if is_on_floor() else Vector2.ZERO
	var input_flat = Vector3(input_dir.x, 0, input_dir.y)
	var input_flatter = Vector2(input_dir.x, input_dir.y)
	
	if camera != null && camera.is_player_movement_adjusted:
		var camera_vector_flat: Vector3 = camera.get_global_transform().basis.x
		var camera_vector_flatter = Vector2(camera_vector_flat.x, camera_vector_flat.z)
		var camera_angle_rads_2 = Vector2(1,0).angle_to(camera_vector_flatter)
		
		input_flatter = input_flatter.rotated(camera_angle_rads_2)
		
		input_flat = Vector3(input_flatter.x, 0, input_flatter.y)
	
	return (transform.basis * input_flat).normalized()
	
func modify_speed_for_sprint():
	if Input.is_action_just_pressed("move_sprint"):
		final_speed = SPEED * SPRINT_MOD
	if Input.is_action_just_released("move_sprint"):
		final_speed = SPEED
		
	return final_speed
	
func apply_movement(_delta: float, direction, speed: float):
	if direction.length() > 0:
		velocity.x = move_toward(velocity.x, direction.x * speed, acceleration)
		velocity.z = move_toward(velocity.z, direction.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, get_deacceleration())
		velocity.z = move_toward(velocity.z, 0, get_deacceleration())

func get_deacceleration() -> float:
	return deceleration if is_on_floor() else 0
	
func collide_with_rigidbodies_godot4_fix():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var other_body = collision.get_collider()
		
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
