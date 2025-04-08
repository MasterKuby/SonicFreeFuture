extends Node

var activeCharacter = "sonic"
var sonicHealth = 100
var tailsHealth = 20
var sonicMaxHealth = 150
var tailsMaxHealth = 100
var debugMode: bool = false

func _process(delta):
	if Input.is_action_just_pressed("q"):
		if activeCharacter == "sonic":
			activeCharacter = "tails"
		elif activeCharacter == "tails":
			activeCharacter = "sonic"

func _ready():
	DiscordRPC.app_id = 1341078725323919490
	DiscordRPC.large_image = "Sonic: Free Future"
	print("Discord working: " + str(DiscordRPC.get_is_discord_working()))
	DiscordRPC.refresh()
	# Commands
	LimboConsole.register_command(debugging)
	 # This registers the command, the first param is the callable command.
	LimboConsole.register_command(health)
	
func debugging(state: bool):
	debugMode = state
	print("debugging is", state)

func health(character: String, value: int):
	if character == "sonic":
		sonicHealth+= value
	if character == "tails":
		tailsHealth+= value
