extends Node

var activeCharacter = "sonic"
var sonicHP = 100
var tailsHP = 20
var sonicMaxHP = 150
var tailsMaxHP = 100
var debugMode: bool = false
var debugLabels: bool = false
var sonicHPChanged: bool = false
var tailsHPChanged: bool = false
# set the HPChanged to true when changed HP in GV

func _process(delta):
	if Input.is_action_just_pressed("q"):
		if activeCharacter == "sonic":
			activeCharacter = "tails"
		elif activeCharacter == "tails":
			activeCharacter = "sonic"

# HEY GUYS DON'T TOUCH THIS OR ASK HOW ANY OF IT WORKS UNLESS YOU KNOW WHAT YOU'RE DOING THANKS! NOT AI JS SORTA GRABBED THE KNOWLEDGE FROM THIS ADDON'S GITHUB REPO
func _ready():
	DiscordRPC.app_id = 1341078725323919490
	DiscordRPC.large_image = "Sonic: Free Future"
	print("Discord working: " + str(DiscordRPC.get_is_discord_working()))
	DiscordRPC.refresh()
	# Commands - This registers the command, the first param is the function to call, the second param is the in-game callable command, and the third param is the description.
	LimboConsole.register_command(debugModeCommand, "debugMode", "Toggle debugMode")
	LimboConsole.register_command(hpCommand, "hp", "Modify a character's HP")
	LimboConsole.register_command(debugLabelsCommand, "debugLabels", "Toggle debugging Labels (debugLabels)")
	# Autocomplete - First Param: Command Name - Second Param: Argument slot/ID (starts at 0 so second is 1) - Third Param: I have no idea how it works but just fill in your autocompletes.
	LimboConsole.add_argument_autocomplete_source("debugging", 1, func(): return [true, false])
	LimboConsole.add_argument_autocomplete_source("hp", 1, func(): return ["sonic", "tails"])
	# Command Aliases
	# LimboConsole.add_alias(x, y) # first param is name of alias, second param is origin command

func debugModeCommand(state: bool):
	debugMode = state
	LimboConsole.info("debugMode is set to" + str(state))

func hpCommand(character: String, value: int):
	if character == "sonic":
		sonicHP += value
		sonicHPChanged = true
	if character == "tails":
		tailsHP += value
		tailsHPChanged = true
	LimboConsole.info(str(character) + "'s HP has been changed by " + str(value))

func debugLabelsCommand(state: bool):
	debugLabels = state
	LimboConsole.info("debugLabels are set to: " + str(state))
	
