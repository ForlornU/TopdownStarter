extends CharacterBase
class_name PlayerMain

@onready var fsm = $FSM as FiniteStateMachine

#func _process(delta):
	
#func _ready():
#	init_character()
	
func _die():
	fsm.force_change_state("Die")
	

