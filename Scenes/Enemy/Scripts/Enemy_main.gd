extends CharacterBase
class_name EnemyMain

@onready var fsm = $FSM as FiniteStateMachine
var PlayerInRange = false

func _ready():
	init_character()

func _process(delta):
	Turn()

func finished_attacking():
	if(PlayerInRange == true):
		fsm.change_state_by_string("enemy_attack_state", "enemy_chase_state");
	else:
		fsm.change_state_by_string("enemy_attack_state", "enemy_idle_state");

func _on_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		PlayerInRange = true
		if fsm.current_state.name == "enemy_idle_state":
			fsm.force_change_state("enemy_chase_state")

func _on_detection_area_body_exited(body):
	if body.is_in_group("Player"):
		PlayerInRange = false
		fsm.change_state_by_string("enemy_chase_state", "enemy_idle_state");
		
func _die():
	fsm.force_change_state("enemy_death_state")
	
	
