extends Node
class_name FiniteStateMachine

var states : Dictionary = {}
var current_state : State
@export var initial_state : State

#TODO Change behaviour of Change_state and Force_change_state

#NOTE This is a generic finite_state_machine, it handles all states, changes to this code will affect
	# everything that uses a state machine!

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)
	#print(states.values())
	#print(states.keys())

	if initial_state:
		initial_state.Enter()
		current_state = initial_state

#Call the current states update function continuosly
func _process(delta):
	if current_state:
		current_state.Update(delta)

func force_change_state(new_state : String):
	print("Forcing state change")
	var newState = states.get(new_state.to_lower())
	if !newState:
		print(new_state + " does not exist in the dictionary of states")
		return
	
	if current_state:
		current_state.Exit()

	print(current_state.name + " forced into: " + newState.name)
		
	newState.Enter()
	
	current_state = newState
	

func change_state_by_string(old_state : String, new_state_name : String):
	if old_state != current_state.name:
		print("Invalid change_state, moving from: " + old_state + " but we are currently in: " + current_state.name)
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("New state is empty")
		return
		
	if current_state:
		current_state.Exit()
		
	new_state.Enter()
	
	current_state = new_state
	#print(new_state.name + " is our new state")

func change_state(old_state : State, new_state_name : String):
	if old_state != current_state:
		print("Invalid change_state, moving from: " + old_state.name + " but we are currently in: " + current_state.name)
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("New state is empty")
		return
		
	if current_state:
		current_state.Exit()
		
	new_state.Enter()
	
	current_state = new_state
	#print(new_state.name + " is our new state")

