extends CharacterBase
class_name PlayerMain

@onready var fsm = $FSM as FiniteStateMachine

const DEATH_SCREEN = preload("res://Scenes/DeathScreen.tscn")

func _die():
	super() #calls _die() on base-class CharacterBase
	
	fsm.force_change_state("Die")
	var death_scene = DEATH_SCREEN.instantiate()
	add_child(death_scene)
