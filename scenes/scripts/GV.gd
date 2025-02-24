extends Node

var activeCharacter = "sonic"
var sonicHealth = 100
var tailsHealth = 100
var debugMode: bool = false

func _process(delta):
	if Input.is_action_just_pressed("q"):
		if activeCharacter == "sonic":
			activeCharacter = "tails"
		elif activeCharacter == "tails":
			activeCharacter = "sonic"
	if Input.is_action_just_pressed("`"):
		if debugMode == false:
			debugMode = true
			print("Debug Mode Activated")
		elif debugMode == true:
			debugMode = false
			print("Debug Mode Deactivated")

func _ready():
	DiscordRPC.app_id = 1341078725323919490
	DiscordRPC.large_image = "Sonic: Free Future"
	print("Discord working: " + str(DiscordRPC.get_is_discord_working()))
	DiscordRPC.refresh()
