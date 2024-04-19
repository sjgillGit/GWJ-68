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

@export_enum("Rodent", "Ink_Blot", "Murder_Of_Crows", "Skater_Knight", "Main_Character") var class_id = 0

signal end_game


func _ready():
	add_to_group("Player")
	generate_player_Mesh_and_anims()
	connect_ui_signals()
	
	PlayerClassStats.class_id = class_id
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
	
	
	if Input.is_action_just_pressed('Pause'):
		process_mode = Node.PROCESS_MODE_ALWAYS
		toggle_pause()
	
	
	if Input.is_action_just_pressed("Skill"):
		match class_id:
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


func connect_ui_signals():
	$Player_UI/CharacterSelect.connect('character_selected', generate_player_Mesh_and_anims)
	$Player_UI/PauseMenu/PanelContainer/MarginContainer/VBoxContainer/QuitButton.connect('pressed', quit_to_main)
	$Player_UI/PauseMenu/PanelContainer/MarginContainer/VBoxContainer/PauseButton.connect('pressed', toggle_pause)
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
	
	
	
	print(str(class_id))
	# ENDBLOCK
	
	for child in get_children():
		print(str(child))
	
	pass


func animation_manager(delta):
	
	
	
	pass

func on_death_character_select():
	
	get_tree().paused = true
	$Player_UI/CharacterSelect.visible = true
	
	pass

#func character_select():
	#
	#get_tree().paused = true
	#$Player_UI/CharacterSelect.visible = true
	#
	#pass

func toggle_pause(): ## make sure pause is invisible on ready
	var pause_menu = $Player_UI/PauseMenu
	
	match pause_menu.visible:
		true:
			pause_menu.visible = false
			get_tree().paused = false
		false:
			get_tree().paused = true
			pause_menu.visible = true
	
	print("toggled")
	pass


func _on_macguffin_radius_body_entered(body):
	
	if body.is_in_group("Player"):
		if body.class_id != 4:
			body.transform.origin = get_tree().current_scene.PC_spawn_position
			
			print("you are not the hero")
		else:
			var MM_P = load("res://Main/MainMenu.tscn") ##main menu path
			# Animation / Fx / sounds / music Boosh boosh boosh 
			# you win
			emit_signal("end_game")
			$Player_UI/You_Won.visible = true
			get_tree().paused = true
			if PROCESS_MODE_WHEN_PAUSED:
				await (get_tree().create_timer(15.0).timeout)
				get_tree().paused = false
				get_tree().change_scene_to_packed(MM_P)
			print("You have destroyed the macguffin")
	
	
	pass # Replace with function body.


func toggle_settings():
	var settingsM_p = $Player_UI/SettingsMenu
	
	if settingsM_p.visible:
		#$Main.visible = true
		settingsM_p.visible = false
	else:
		settingsM_p.visible = true
		#$Main.visible = false
	
	print("settings menu toggled")
	pass


func PC_Lose():
	on_death_character_select()
	pass


func quit_to_main():
	var MM_P = preload("res://Scripts/TQ/Integrated_MainMenu.tscn")  ## main menu with buttons
	
	get_tree().change_scene_to_packed(MM_P)
	pass
