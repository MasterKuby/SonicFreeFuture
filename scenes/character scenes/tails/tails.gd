extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var dashingTimer = $"Double Tap Dash Timer"

@export var phantomCamera: Node2D

var character = "tails"

var SPEED: float = 110.0
var JUMP_VELOCITY: float = -200.0

var dashed: bool = false
var direction: int = 1
var jumping: bool = false
var flyingEnabled: bool = false

func _physics_process(delta):
	debugModeCheck(delta)
	playerControl(delta)
	gravityCheck(delta)
	jumpingFallingFlying(delta)
	airDash(delta)
	spriteAndCameraFlip()
	animations()
	move_and_slide()
	zIndexSort()
	quickReset()

func debugModeCheck(delta):
	if GV.debugMode == true and GV.activeCharacter == character:
		if Input.is_action_pressed("up"):
			velocity.y = 0
			position.y += -5 * scale.x
		if Input.is_action_pressed("down"):
			position.y += 5 * scale.x
			velocity.y = 0
		if Input.is_action_pressed("left"):
			position.x += -5 * scale.x
		if Input.is_action_pressed("right"):
			position.x += 5 * scale.x

func playerControl(delta):
	direction = Input.get_axis("a", "d") # set direction
	if not GV.activeCharacter == character:
		direction = 0
	if direction: # move
		velocity.x = lerp(velocity.x, direction*SPEED*scale.x, 0.025)
	elif dashed == false:
		velocity.x = lerp(velocity.x, 0.0, 0.1) # slow down when have no direction
	elif dashed == true:
		velocity.x = lerp(velocity.x, 0.0, 0.1)

func gravityCheck(delta):
	if not is_on_floor() and GV.debugMode == false:
		velocity += (get_gravity() * delta) / 4*scale.x
	if not is_on_floor() and GV.debugMode == false and flyingEnabled:
		velocity += (get_gravity() * delta) / 16*scale.x

func jumpingFallingFlying(delta):
	# If hasn't dashed, player animation will be jumping when going up and falling when going down.
	if dashed == false:
		if not is_on_floor() and velocity.y > 0 and not flyingEnabled:
			if not sprite.animation == "falling":
				sprite.animation = "falling"
				sprite.play()
		if not is_on_floor() and velocity.y < 0 and not flyingEnabled:
			if not sprite.animation == "jump":
				sprite.animation = "jump"
				sprite.play()
	# If jump button and criteria is met, jump.
	if Input.is_action_pressed("w") and is_on_floor() and GV.debugMode == false and GV.activeCharacter == character:
		velocity.y = JUMP_VELOCITY*scale.x
	if Input.is_action_pressed("w") and !is_on_floor() and GV.debugMode == false and GV.activeCharacter == character and flyingEnabled: #if flying then fly
		velocity.y = JUMP_VELOCITY/3*scale.x
	if Input.is_action_just_pressed("f") and GV.activeCharacter == "tails": # toggle flying with f key
		if flyingEnabled:
			flyingEnabled = false
			sprite.animation = "fly"
			sprite.play()
		elif !flyingEnabled:
			flyingEnabled = true
	if !is_on_floor() and GV.activeCharacter == character and flyingEnabled:
		sprite.animation = "fly"
		sprite.play()

func airDash(delta):
	# After double tapped in direction, dash in said locked direction. (locked in player movement script)
	if Input.is_action_just_pressed("a") and GV.activeCharacter == character:
		if dashed == false and !dashingTimer.is_stopped() and !is_on_floor():
			dashed = true
			sprite.animation = "dash forward"
			velocity.y = 0
			velocity.x += 1000*direction * scale.x # Tails dash is intentionally weaker than Sonic's
		if dashed == false:
			dashingTimer.start()
	if Input.is_action_just_pressed("d") and GV.activeCharacter == character:
		if dashed == false and !dashingTimer.is_stopped() and !is_on_floor():
			dashed = true
			sprite.animation = "dash forward"
			velocity.y = 0
			velocity.x += 1000*direction * scale.x
		if dashed == false:
			dashingTimer.start()
	if is_on_floor():
		dashed = false

func spriteAndCameraFlip():
	if GV.activeCharacter == character:
		if direction == -1 and velocity.x != 0:
			sprite.flip_h = true
			phantomCamera.set_follow_offset(Vector2(-75 * scale.x, 0))
		elif direction == 1 and velocity.x != 0:
			sprite.flip_h = false
			phantomCamera.set_follow_offset(Vector2(75 * scale.x, 0))

func animations():
	if direction != 0 and is_on_floor() and !Input.is_action_pressed("w"):
		if not sprite.animation == "run":
			if abs(velocity.x) >= 200*scale.x: 
				sprite.animation = "run"
				sprite.play()
			if abs(velocity.x) <= 200*scale.x: 
				sprite.animation = "run"
				sprite.play()
	elif is_on_floor() and direction == 0:
		if sprite.animation != "idle" and !Input.is_action_pressed("w"):
			sprite.animation = "idle"
			sprite.play()

func zIndexSort():
	if GV.activeCharacter == character:if z_index != 1: set_z_index(1)
	if GV.activeCharacter != character:if z_index != 0: set_z_index(0)

func quickReset():
	if Input.is_action_pressed("reset"):
		get_tree().reload_current_scene()
