extends CharacterBase
class_name PlayerMain

@onready var fsm = $FSM as FiniteStateMachine
	
func _die():
	fsm.force_change_state("Die")
	

