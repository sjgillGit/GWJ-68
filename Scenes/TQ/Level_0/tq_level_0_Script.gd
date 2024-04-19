extends Node3D
class_name TQ_Level_0


@onready var Player = $PC

@export var current_cam: Camera3D 
var Camera_array = []
var PC_spawn_point: Vector3


func _ready():
	PC_spawn_point = Player.transform.origin
	current_cam = $PC/SpringArm3D/Player_cam
	set_current_player_cam(current_cam) 
	
	pass


func _process(delta):
	#$Lighting/DirectionalLight3D.rotate_x(0.001) ## sunshine (0.0)
	
	#The Overseer
	
	if Player.transform.origin.y <= -20:
		Player.transform.origin = PC_spawn_point
	
	
	#$Camera/Cameras/ThePeepingTom.transform.origin = $Camera/Cameras/ThePeepingTom.transform.origin.move_toward(Player.global_position, 0.25)
	current_cam.look_at(Player.global_position)
	
	
	
	if current_cam.transform.origin.distance_to(Player.transform.origin) > 11:
		current_cam.transform.origin = current_cam.transform.origin.move_toward(Player.global_position, 0.09)
	elif current_cam.transform.origin.distance_to(Player.transform.origin) < 15:
		current_cam.transform.origin = current_cam.transform.origin.move_toward(Player.global_position, -0.15)
		#print(str(current_cam.global_position.y))
	
	var cam_path = $Camera/Paths/CamPath_A/Cam_position
	
	if current_cam.global_position.distance_to(Player.global_position) not in range(16.5, 45) and current_cam != $PC/SpringArm3D/Player_cam:
		current_cam.transform.origin = current_cam.transform.origin.move_toward(Player.global_position, 0.08)
	
	#print("camera distance to player" + str(cam_path.global_position.distance_to(Player.global_position)))
	pass

func _physics_process(delta):
	$Camera/Cameras/Cam_0.transform.origin = $Camera/Paths/CamPath_A/Cam_position.global_position
	
	pass


func set_current_player_cam(current_cam):
	
	#set spawn / respawn camera
	
	current_cam.current = true
	
	
	pass


func _on_path_trigger_0_body_entered(body):
	
		current_cam = $Camera/Cameras/Cam_1
		set_current_player_cam(current_cam)
	
	
