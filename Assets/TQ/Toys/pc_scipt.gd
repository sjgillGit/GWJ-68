extends CharacterBody3D
class_name TQ_PC

## GAWD DAYUMN LETS JUST DO IT AGAIN I GUESS WHOOOOO  お(^o^)や(^O^)す(^｡^)みぃ(^-^)ﾉﾞ


#this handles dev mode stats
@export var DEV_MODE: bool = false

@export var DEVELOPER_STATS = {
	"walk_speed" : 9.0,
	"jump_velocity" : 20,
	
}

#this is how the player will experience the game
@export var PLAYER_STATS = {
	"walk_speed" : 5.0,
	"jump_velocity" : 15.0,
	
}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var GRAVITY = ProjectSettings.get_setting("physics/3d/default_gravity")

# End basics

@export_enum("Rodent", "Ink_Blot", "Murder_Of_Crows", "Skater_Knight") var PLAYERCLASS = 0


func _ready():
	
	
	#generate_Player character
	var model_p: PackedScene
	
	match PLAYERCLASS:
		0:
			
			print("Rodent")
		1:
			
			print("Ink_Blot")
		2:
			model_p = load("res://Assets/TQ/Models/Tscn/plague_doctor.tscn")
			add_child(model_p.instantiate())
			print("murder_of_crows")
		3:
			
			print("Skater_Knight")
	
	print(str(PLAYERCLASS))
	# ENDBLOCK
	
	
	pass



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		match DEV_MODE:
			true:
				velocity.y += DEVELOPER_STATS['jump_velocity']
			false:
				velocity.y += PLAYER_STATS['jump_velocity']

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	match DEV_MODE:
		true:
			if direction:
				velocity.x = direction.x * DEVELOPER_STATS['walk_speed']
				velocity.z = direction.z * DEVELOPER_STATS['walk_speed']
			else:
				velocity.x = move_toward(velocity.x, 0, DEVELOPER_STATS['walk_speed'])
				velocity.z = move_toward(velocity.z, 0, DEVELOPER_STATS['walk_speed'])
		false:
			if direction:
				velocity.x = direction.x * PLAYER_STATS['walk_speed']
				velocity.z = direction.z * PLAYER_STATS['walk_speed']
			else:
				velocity.x = move_toward(velocity.x, 0, PLAYER_STATS['walk_speed'])
				velocity.z = move_toward(velocity.z, 0, PLAYER_STATS['walk_speed'])

	move_and_slide()
