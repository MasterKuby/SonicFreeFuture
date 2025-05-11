extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var dashingTimer = $"Double Tap Dash Timer"
@export var phantomCamera: Node2D
@onready var state_machine = $"State Machine"

var character = "sonic"

var SPEED: float = 200.0
var JUMP_VELOCITY: float = -250.0

var dashed: bool = false
var direction: int = 0
var jumping: bool = false

func _physics_process(delta):
	spriteAndCameraFlip()
	move_and_slide()
	zIndexSort()
	quickReset()
	directionAndDashed()
	print(state_machine.currentState)


func directionAndDashed():
	direction = Input.get_axis("a", "d") # set direction
	if not GV.activeCharacter == character:
		direction = 0
	elif dashed == false:
		velocity.x = lerp(velocity.x, 0.0, 0.1) # slow down when have no direction
	elif dashed == true:
		velocity.x = lerp(velocity.x, 0.0, 0.1)

func spriteAndCameraFlip():
	if GV.activeCharacter == character:
		if direction == -1 and velocity.x != 0:
			sprite.flip_h = true
			phantomCamera.set_follow_offset(Vector2(-75 * scale.x, 0))
		elif direction == 1 and velocity.x != 0:
			sprite.flip_h = false
			phantomCamera.set_follow_offset(Vector2(75 * scale.x, 0))


func zIndexSort():
	if GV.activeCharacter == character:if z_index != 1: set_z_index(1)
	if GV.activeCharacter != character:if z_index != 0: set_z_index(0)

func quickReset():
	if Input.is_action_pressed("reset"):
		get_tree().reload_current_scene()
