extends CharacterBase
class_name EnemyMain

@onready var fsm = $FSM as FiniteStateMachine
var player_in_range = false

@export var attack_node : Node
@export var chase_node : Node

func finished_attacking():
	if(player_in_range == true):
		fsm.change_state(attack_node, "enemy_chase_state")
	else:
		fsm.change_state(attack_node, "enemy_idle_state")

func _on_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		player_in_range = true
		if fsm.current_state.name == "enemy_idle_state":
			fsm.force_change_state("enemy_chase_state")

func _on_detection_area_body_exited(body):
	if body.is_in_group("Player"):
		player_in_range = false
		fsm.change_state(chase_node, "enemy_idle_state")
		
func _die():
	fsm.force_change_state("enemy_death_state")
	
	
