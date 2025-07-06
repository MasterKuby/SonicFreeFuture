@icon("res://assets/custom/node icons/Pixel Boy's Icons/HPComponent.png") # Credit to https://pixel-boy.itch.io/icon-godot-node for custom node icons (thanks alot!!!)
extends Node2D
class_name HPComponent

@export var HP : float
@export var maxHP : float



func _ready():
	if get_parent().is_in_group("Character"):
		if get_parent().character == "sonic": # If parent is sonic
			HP = GV.sonicHP
		if get_parent().character == "tails":
			HP = GV.tailsHP

func takeDamage(damage):
	HP -= damage
	if get_parent().character == "sonic": # If parent is sonic
		GV.sonicHP = HP
	if get_parent().character == "tails":
		GV.tailsHP = HP
func _physics_process(delta):
	if Input.is_action_just_pressed("left"):
		takeDamage(10)

func _process(delta):
	if GV.sonicHPChanged == true and get_parent().character == "sonic":
		GV.sonicHPChanged = false
		HP = GV.sonicHP
	if GV.tailsHPChanged == true and get_parent().character == "tails":
		GV.tailsHPChanged = false
		HP = GV.tailsHP
		
		

# Later, when component is used for mobs, check if parent is in mob group and if 
# so then call death() function when HP is at or below 0 so the mob can die! Death function is in the root node's script.
