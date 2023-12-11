extends CharacterBase
class_name PlayerMain

@onready var fsm = $FSM as FiniteStateMachine

const DEATH_SCREEN = preload("res://Scenes/DeathScreen.tscn")
var is_dead = false

func _die():
	if(is_dead):
		return
	
	is_dead = true
	fsm.force_change_state("Die")
	var death_scene = DEATH_SCREEN.instantiate()
	add_child(death_scene)
