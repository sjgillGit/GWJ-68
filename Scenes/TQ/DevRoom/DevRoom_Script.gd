extends Node3D
class_name TQ_Dev_Room
##@experimental

## (ノಠ益ಠ)ノ彡┻━┻ fuck this job V.0.2.3

@export_enum("Le_Mouse", "Ink_Blot", "Murder_Of_Crows", "Skater_Knight") var PLAYER_CLASS
@onready var class_id

@onready var PLAYER: TQ_PC = $PC

var PC_spawn_position: Vector3

var current_cam: Camera3D 

# Called when the node enters the scene tree for the first time.
func _ready():
	current_cam = $Cameras/Cam0
	current_cam.current = true
	
	$Pet.visible = false
	
	#$PC/Locator_HIDEME.visible = false
	PC_spawn_position = PLAYER.global_position
	
	
	# bake navigation
	$Geometry/Static/NaviagtionRegion.bake_navigation_mesh()
	
	
	#connect signals
	
	#connects the player to the macguffin
	$The_Magical_Macguffin/Macguffin_Radius.connect("body_entered", PLAYER._on_macguffin_radius_body_entered)
	PLAYER.connect('end_game', end_game)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_of_day()
	
	the_overseer(delta)
	
	pass

func time_of_day():
	var the_literal_sun = $Lights/Enviromental/WorldEnvironment/DirectionalLight3D
	
	the_literal_sun.rotate_x(0.001)
	pass


func the_overseer(delta):
	
	if PLAYER.transform.origin.y < -20:
		PLAYER.transform.origin = PC_spawn_position
		PLAYER.class_id = 4
		PLAYER.PC_Lose()
	
	#$PC/SpringArm3D/Camera3D.look_at(PLAYER.global_position)
	current_cam.look_at(PLAYER.global_position)
	pass

func switch_cam():
	current_cam.current = false
	current_cam = $Cameras/Cam0
	current_cam.current = true
	pass

func end_game():
	current_cam.current = false
	current_cam = $The_Magical_Macguffin/Cam_orbit_point/GuffCam
	current_cam.current = true
	
	pass


func _on_cam_trigger_0_body_entered(body):
	if body.is_in_group("Player"):
		current_cam.current = false
		current_cam = $Cameras/Cam1
		current_cam.is_current_cam = true
		current_cam.current = true
	pass # Replace with function body.


func _on_cam_trigger_0_body_exited(body):
	
	current_cam = $PC/SpringArm3D/Player_cam
	#current_cam.is_current_cam = true
	current_cam.current = true
	
	pass # Replace with function body.


func _on_cam_trigger_1_body_entered(body):
	if body.is_in_group("Player"):
		current_cam.current = false
		current_cam = $Cameras/Cam2
		current_cam.current = true
	pass # Replace with function body.
