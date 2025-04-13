@icon("res://assets/custom/node icons/Pixel Boy's Icons/HitboxComponent.png") # Credit to https://pixel-boy.itch.io/icon-godot-node for custom node icons (thanks alot!!!)
extends Area2D
class_name HitboxComponent # Makes it a node in the "Add/Create a Node"

@export var HPComponent : Node2D # Assign HPComponent Node


#

func hit(damage): # Later, add more params for this function in HitboxComponent AND in damage components, so one param could be "effect" which can add effects like fire, poison, levitation etc. Or a "source" parameter which finds the owner of the projectile for perhaps something similar to Minecraft thorns?
	HPComponent.takeDamage(damage)
