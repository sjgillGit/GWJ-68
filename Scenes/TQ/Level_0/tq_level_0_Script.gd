extends Node3D
class_name TQ_Level_0


@onready var Player = $PC

var current_cam: Camera3D
var Camera_array = []



func _ready():
	
	set_current_player_cam() 
	
	pass


func _process(delta):
	$Lighting/DirectionalLight3D.rotate_x(0.001) ## sunshine (0.0)
	
	#Peeping Tom
	
	#$Camera/Cameras/ThePeepingTom.transform.origin = $Camera/Cameras/ThePeepingTom.transform.origin.move_toward(Player.global_position, 0.25)
	current_cam.look_at(Player.global_position)
	
	
	
	if current_cam.transform.origin.distance_to(Player.transform.origin) > 11:
		current_cam.transform.origin = current_cam.transform.origin.move_toward(Player.global_position, 0.05)
	else:
		current_cam.transform.origin = current_cam.transform.origin
		print(str(current_cam.global_position.y))
	
	
	pass


func set_current_player_cam():
	
	#set spawn / respawn camera
	
	current_cam = $Camera/Cameras/ThePeepingTom/ThePeepingTom
	current_cam.current = true
	
	
	pass
