extends CharacterBase
class_name PlayerMain

@onready var fsm = $FSM as FiniteStateMachine

const DEATH_SCREEN = preload("res://Scenes/DeathScreen.tscn")

#All of our logic is either in the CharacterBase class
#or spread out over our states in the finite-state-manager, this class is nice and tidy

func _die():
	super() #calls _die() on base-class CharacterBase
	
	fsm.force_change_state("Die")
	var death_scene = DEATH_SCREEN.instantiate()
	add_child(death_scene)
