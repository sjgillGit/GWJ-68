extends Node
class_name Player_Class_Stat_Sheet
##@experimental

## a test to see if I can get each player class to store their own movement variables
## this would reduce the skills to basic behavioral function scripts
## i.e: Sprint, Interact/attack, Jump/ Glide,  

## I could probably made this in txt butt fuck it 8====D
var class_id: int  ## set this in the PC before using

var walk_speed: float
var jump_velocity: float
var alive: bool

## contains the varied stats of each class
@onready var PLAYER_CLASS_STATS = { 
	0 : {
		walk_speed : 2.0,
		jump_velocity : 7.0, 
		"alive" : true
		},
	
	1 : {
		"alive" : true
	},
	
	2 : {
		"alive" : true
	},
	
	3 : {
		"alive" : true
	},
	
	4 : {
		"alive" : true
	}
	
}

