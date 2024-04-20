extends CharacterBody3D
class_name TQ_PC

## GAWD DAYUMN LETS JUST DO IT AGAIN I GUESS WHOOOOO  お(^o^)や(^O^)す(^｡^)みぃ(^-^)ﾉﾞ

@onready var anim: AnimationPlayer

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



func _ready():
	add_to_group("Player")
	generate_player_Mesh_and_anims()
	
	
	
	pass


func _process(delta):
	animation_manager(delta) # quick switch between anims
	
	pass


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#match DEV_MODE:
			#true:
				#velocity.y += DEVELOPER_STATS['jump_velocity']
			#false:
				#velocity.y += PLAYER_STATS['jump_velocity']

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
	
	if velocity.z or velocity.x != 0:
		if $Footsteps_audio_player.is_playing() == false:
			$Footsteps_audio_player.pitch_scale = randf_range(.45, 1.12 )
			$Footsteps_audio_player.playing = true
	else:
		$Footsteps_audio_player.playing = false
	
	pass


func _input(event):
	
	if Input.is_action_just_pressed("Skill"):
		match PlayerClassStats.class_id:
			0:# Rodent
				
				
				print('rodent Skill : Interact')
			1: #ink blot
				
				
				
				print("Ink Blot Skill : Drop Blot")
			2: #crows
				var glide: bool
				
				if is_on_floor():
					velocity.y += PLAYER_STATS['jump_velocity'] 
				
				print("Murder_Of_Crows : Jump")
			3: # Knight
				
				
				print("Skater Knight : Speed Up")
			4: # MC
				
				if is_on_floor():
					velocity.y += PLAYER_STATS['jump_velocity'] 
				print("needed to complete the end game puzzle : can jump")
	
	
	pass


func generate_player_Mesh_and_anims():
	
	#generate_Player character
	var model_p: PackedScene
	var model_i = model_p
	
	
	match PlayerClassStats.class_id:
		0:
			var pet_p = load("res://Assets/Mike3D/mouse.tscn")
			var pet_i = pet_p.instantiate()
			model_p = load("res://Assets/Mike3D/pet_owner.tscn")
			
			add_child(model_p.instantiate()) ## adds player
			get_tree().current_scene.add_child(pet_i) ##adds pet TODO: add spawn at player location
			pet_i.global_transform.origin = global_position
			
			print("Rodent" + str(pet_i.transform.origin))
		1:
			model_p = load("res://Assets/Mike3D/mr_thumper.tscn")
			add_child(model_p.instantiate())
			print("Ink_Blot")
		2:
			model_p = load("res://Assets/TQ/Models/Tscn/plague_doctor.tscn")
			add_child(model_p.instantiate())
			print("murder_of_crows")
		3:
			model_p = load("res://Assets/IStead/Skate_Knight_root/skate_knight.tscn")
			add_child(model_p.instantiate())
			print("Skater_Knight")
		4:#TODO: Find MC Mesh 
			
			print('Main Character')
	
	
	
	print(str(PlayerClassStats.class_id))
	# ENDBLOCK
	
	pass


func animation_manager(delta):
	
	
	
	pass



func _on_macguffin_radius_body_entered(body):
	
	if body.is_in_group("Player"):
		if body.class_id != 4:
			body.transform.origin = get_tree().current_scene.PC_spawn_position
			print("you are not the hero")
		else:
			# Animation / Fx / sounds / music Boosh boosh boosh 
			# you win
			print("You have destroyed the macguffin")
	
	pass # Replace with function body.
