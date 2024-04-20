class_name UserPreferences
extends Resource

@export_range(0,1, 0.05) var master_volume: float = 1.0
@export_range(0,1, 0.05) var music_volume: float = 1.0
@export_range(0,1, 0.05) var sfx_volume: float = 1.0
@export var action_events: Dictionary = {}
@export var window_mode: int

func save():
	ResourceSaver.save(self,"user://user_prefs.tres")
	
	
static func load_or_create() -> UserPreferences:
	var res: UserPreferences = load("user://user_prefs.tres") as UserPreferences
	if !res:
		res = UserPreferences.new()
	return res 
