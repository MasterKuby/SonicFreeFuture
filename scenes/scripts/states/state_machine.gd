extends Node

@export var initialState : State

var currentState : State
var states : Dictionary = {}

func _ready(): # When start
	for child in get_children(): # For loop goes over every child of the node this script is attached to.
		if child is State: # If child has class "State"
			states[child.name.to_lower()] = child # add the child to the states dictionary of line 3
			child.transitioned.connect(childTransitioned)
	if initialState: # if we have an initial state set
		initialState.enter()
		currentState = initialState

func _process(delta):
	if currentState: # if we have a state active
		currentState.update(delta) # updates that state's process

func _physics_process(delta):
	if currentState: # if we have a state active
		currentState.physicsUpdate(delta) # updates that state's physics process

func childTransitioned(state, newStateName):
	if state != currentState: # if state is not currentstate calling this function
		return
	
	var newState = states.get(newStateName.to_lower()) # to_lower() so no skibidi shit happens JS in case
	if !newState:
		return
	
	if currentState:
		currentState.exit()
	newState.enter()
	currentState = newState
