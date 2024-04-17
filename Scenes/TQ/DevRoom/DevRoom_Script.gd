extends Node3D
class_name TQ_Dev_Room
##@experimental

## (ノಠ益ಠ)ノ彡┻━┻ fuck this job V.0.2.0

@export_enum("Le_Mouse", "Ink_Blot", "Murder_Of_Crows", "Skater_Knight") var PLAYER_CLASS
@onready var class_id

@onready var PLAYER: TQ_PC = $PC

var PC_spawn_position: Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	$PC/Locator_HIDEME.visible = false
	PC_spawn_position = PLAYER.global_position
	
	
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
	
	if PLAYER.transform.origin.y < -50:
		PLAYER.transform.origin = PC_spawn_position
	
	$PC/SpringArm3D/Camera3D.look_at(PLAYER.global_position)
	
	pass
